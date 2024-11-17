import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisiabilty());
  }

  /// sign in google

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in failed');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      print(user!.uid);

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (!userSnapshot.exists) {
        print('User not registered. Please register.');
        emit(UsernotRegister());
      } else {
        emit(SuccessGoogleLoginState(user.uid));
      }

      return userCredential;
    } catch (e) {
      emit(ErrorLoginState());
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  ///sign in facebook
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken!.tokenString);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final User? user = userCredential.user;
        print("Firebase User ID: ${user?.uid}");
        print("Firebase User Display Name: ${user?.displayName}");

        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (!userSnapshot.exists) {
          print('User not registered. Please register.');
          emit(UsernotRegister());
          return;
        }

        emit(SuccessFaceLoginState(user.uid));
      } else {
        emit(ErrorLoginState());
        print("Facebook login failed. Status: ${result.status}");
      }
    } catch (e) {
      emit(ErrorLoginState());
      print("Error during Facebook authentication: $e");
    }
  }

  ///sign with phone
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isPhoneNumberRegistered(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> verifyPhoneNumberAndLogin(BuildContext context,
      {required String phoneNumber, required String password}) async {
    bool isRegistered = await isPhoneNumberRegistered(phoneNumber);
    if (isRegistered) {
      print('Phone number is registered. Proceeding with login...');
      login2(phoneNumber, password);
      emit(PhoneRegisterState());
    } else {
      emit(PhoneNotRegisterstate());
      print('Phone number is not registered. Please register first.');
    }
  }

  PhoneAuthCredential? _phoneAuthCredential;
  User? _firebaseUser;

  Future<void> login2(String phoneNumber, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: phoneNumber,
        password: password,
      )
          .then((authRes) {
        _firebaseUser = authRes.user!;
        print('User logged in: ${_firebaseUser.toString()}');
        print(authRes.user!.uid);
        print('uiiiiiiiiiiiid');
        emit(SuccessLoginState(authRes.user!.uid));
      });
    } catch (e) {
      // Handle login errors
      print('Error logging in: ${e.toString()}');
      emit(ErrorLoginState());
    }
  }
}
