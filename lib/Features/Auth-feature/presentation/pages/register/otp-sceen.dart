// import 'dart:core';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sell_4_u/Features/Auth-feature/presentation/pages/register/cubit/register_states.dart';
// import 'package:sell_4_u/core/constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:pinput/pinput.dart';
//
// import '../../../../../core/helper/cache/cache_helper.dart';
// import '../../../../../core/helper/component/component.dart';
// import '../../../../../core/responsive_screen.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../../Home-feature/view/layout.dart';
// import '../../../manger/model/user_model.dart';
// import 'cubit/register_cubit.dart';
//
// class OtpScreen extends StatefulWidget {
//   OtpScreen({
//     required this.phoneNumber,
//     required this.email,
//     required this.name,
//     required this.password,
//   });
//
//   String phoneNumber;
//   String name;
//   String email;
//   String password;
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   final TextEditingController pinController = TextEditingController();
//   String? verificationId;
//
//   Future<void> phoneVerify() async {
//     print('ppppppppppphhhhone${widget.phoneNumber}');
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: widget.phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {
//         showTopSnackBar(
//           Overlay.of(context),
//           CustomSnackBar.error(
//             message: e.message ?? 'Verification failed',
//           ),
//         );
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//         // Save verification ID locally
//         saveVerificationId(verificationId);
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//         // Save verification ID locally
//         saveVerificationId(verificationId);
//       },
//     );
//   }
//
//   Future<void> saveVerificationId(String verificationId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('verificationId', verificationId);
//   }
//
//   Future<String?> getVerificationId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('verificationId');
//   }
//
//   Future<void> sendOtp(BuildContext context) async {
//     try {
//       String? storedVerificationId = await getVerificationId();
//       if (storedVerificationId != null) {
//         String smsCode = pinController.text;
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//             verificationId: storedVerificationId, smsCode: smsCode);
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         RegisterCubit.get(context).registerWithEmailPassword(
//             context: context,
//             email: widget.email,
//             name: widget.name,
//             password: widget.password,
//             platform: CacheHelper.getData(key: 'platform'),
//
//             phone: widget.phoneNumber);
//       } else {
//
//         showTopSnackBar(
//           Overlay.of(context),
//           CustomSnackBar.error(
//             message: 'Verification ID not found. Please try again.',
//           ),
//         );
//       }
//     } catch (e) {
//       showTopSnackBar(
//         Overlay.of(context),
//         CustomSnackBar.error(
//           message: e.toString(),
//         ),
//       );
//     }
//   }
//
//   void resendOtp() async {
//     phoneVerify();
//     showTopSnackBar(
//       Overlay.of(context),
//       CustomSnackBar.success(
//         message: 'OTP resent successfully',
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     phoneVerify();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RegisterCubit(),
//       child: BlocConsumer<RegisterCubit, RegisterState>(
//         listener: (context, state) {
//           if (state is SuccessRegisterState) {
//             showTopSnackBar(
//               Overlay.of(context),
//               CustomSnackBar.success(
//                 message: 'Verification success',
//               ),
//             );
//             CacheHelper.saveData(key: 'uId', value: state.uId);
//             navigatorTo(context, LayoutScreen());
//           }
//           if (state is ErrorRegisterState) {
//             showTopSnackBar(
//               Overlay.of(context),
//               CustomSnackBar.error(
//                 message: 'Enter correct OTP',
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           var cubit = RegisterCubit.get(context);
//
//           return ResponsiveScreen(
//             mobileScreen:Scaffold(
//               appBar: AppBar(
//                 elevation: 0,
//                 title: Text(
//                   S.of(context).verfyEmail,
//                   style: GoogleFonts.tajawal(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 centerTitle: true,
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Directionality(
//                       textDirection: TextDirection.ltr,
//                       child: Pinput(
//                         length: 6,
//                         controller: pinController,
//                         androidSmsAutofillMethod:
//                         AndroidSmsAutofillMethod.smsUserConsentApi,
//                         listenForMultipleSmsOnAndroid: true,
//                         defaultPinTheme: PinTheme(
//                           width: 56,
//                           height: 56,
//                           textStyle: TextStyle(
//                             fontSize: 22,
//                             color: Color.fromRGBO(30, 60, 87, 1),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                         ),
//                         separatorBuilder: (index) => SizedBox(width: 8),
//                         hapticFeedbackType: HapticFeedbackType.lightImpact,
//                         onCompleted: (pin) {
//                           debugPrint('onCompleted: $pin');
//                         },
//                         onChanged: (value) {
//                           debugPrint('onChanged: $value');
//                         },
//                         cursor: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.only(bottom: 9),
//                               width: 22,
//                               height: 1,
//                               color: Colors.blue,
//                             ),
//                           ],
//                         ),
//                         focusedPinTheme: PinTheme(
//                           width: 56,
//                           height: 56,
//                           textStyle: TextStyle(
//                             fontSize: 22,
//                             color: Color.fromRGBO(30, 60, 87, 1),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(19),
//                             border: Border.all(color: Colors.blue),
//                           ),
//                         ),
//                         submittedPinTheme: PinTheme(
//                           width: 56,
//                           height: 56,
//                           textStyle: TextStyle(
//                             fontSize: 22,
//                             color: Color.fromRGBO(30, 60, 87, 1),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(19),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                         ),
//                         errorPinTheme: PinTheme(
//                           width: 56,
//                           height: 56,
//                           textStyle: TextStyle(
//                             fontSize: 22,
//                             color: Colors.redAccent,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(19),
//                             border: Border.all(color: Colors.redAccent),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             resendOtp();
//                           },
//                           child: Text(
//                             S.of(context).resendOtp,
//                             style: GoogleFonts.tajawal(
//                                 color: ColorStyle.secondColor,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                     Container(
//                       height: 45,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: ColorStyle.primaryColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: MaterialButton(
//                         onPressed: () {
//                           String otp = pinController.text;
//                           print('Entered OTP: $otp');
//                           sendOtp(context);
//                         },
//                         child: Text(
//                           S.of(context).verfyEmail,
//                           style: GoogleFonts.tajawal(
//                               fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             desktopScreen: Scaffold(
//               backgroundColor: Colors.white,
//               appBar: AppBar(
//                 elevation: 0,
//                 title: Text(
//                   S.of(context).verfyEmail,
//                   style: GoogleFonts.tajawal(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 centerTitle: true,
//               ),
//               body: Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child:Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: Pinput(
//                               length: 6,
//                               controller: pinController,
//                               androidSmsAutofillMethod:
//                               AndroidSmsAutofillMethod.smsUserConsentApi,
//                               listenForMultipleSmsOnAndroid: true,
//                               defaultPinTheme: PinTheme(
//                                 width: 56,
//                                 height: 56,
//                                 textStyle: TextStyle(
//                                   fontSize: 22,
//                                   color: Color.fromRGBO(30, 60, 87, 1),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                               ),
//                               separatorBuilder: (index) => SizedBox(width: 8),
//                               hapticFeedbackType: HapticFeedbackType.lightImpact,
//                               onCompleted: (pin) {
//                                 debugPrint('onCompleted: $pin');
//                               },
//                               onChanged: (value) {
//                                 debugPrint('onChanged: $value');
//                               },
//                               cursor: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin: const EdgeInsets.only(bottom: 9),
//                                     width: 22,
//                                     height: 1,
//                                     color: Colors.blue,
//                                   ),
//                                 ],
//                               ),
//                               focusedPinTheme: PinTheme(
//                                 width: 56,
//                                 height: 56,
//                                 textStyle: TextStyle(
//                                   fontSize: 22,
//                                   color: Color.fromRGBO(30, 60, 87, 1),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(19),
//                                   border: Border.all(color: Colors.blue),
//                                 ),
//                               ),
//                               submittedPinTheme: PinTheme(
//                                 width: 56,
//                                 height: 56,
//                                 textStyle: TextStyle(
//                                   fontSize: 22,
//                                   color: Color.fromRGBO(30, 60, 87, 1),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(19),
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                               ),
//                               errorPinTheme: PinTheme(
//                                 width: 56,
//                                 height: 56,
//                                 textStyle: TextStyle(
//                                   fontSize: 22,
//                                   color: Colors.redAccent,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(19),
//                                   border: Border.all(color: Colors.redAccent),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   resendOtp();
//                                 },
//                                 child: Text(
//                                   S.of(context).resendOtp,
//                                   style: GoogleFonts.tajawal(
//                                       color: ColorStyle.secondColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 30),
//                           Container(
//                             height: 45,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: ColorStyle.primaryColor,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: MaterialButton(
//                               onPressed: () {
//                                 String otp = pinController.text;
//                                 print('Entered OTP: $otp');
//                                 sendOtp(context);
//                               },
//                               child: Text(
//                                 S.of(context).verfyEmail,
//                                 style: GoogleFonts.tajawal(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Center(
//                       child: Image(
//                         image: NetworkImage(
//                             'https://img.freepik.com/free-vector/two-factor-authentication-concept-illustration_114360-5488.jpg?t=st=1710854824~exp=1710858424~hmac=7ad125566b9172e16081985e4ee22fb51122d2b89fa0b1896dce05e8a6d19edd&w=740'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
