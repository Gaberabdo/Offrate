import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'dart:io';
import 'dart:typed_data';
import '../models/chat_model.dart';
import 'chat-states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialChatPageStates());

  static ChatCubit get(context) => BlocProvider.of(context);
  dynamic? chatImage;
  UserModel? userModel;
  var picker = ImagePicker();

//All User
  UserModel? admin;
  UserModel? allAdmin;

  void getAllUserData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == '7QfP0PNO6qVWVKij4jJzVNCG9sj2') {
          admin = UserModel.fromJson(element.data());
          print(('addddddddddddddddddddddddmin${admin.toString()}'));
        }
      }
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
  }

  void getAdminData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc('H4tYPw18nrNaahQtvljf6v86oc53')
        .snapshots()
        .listen((value) {
      allAdmin = UserModel.fromJson(value.data()!);
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
  }

  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        // Read the image data into memory
        List<int> imageData = await pickedFile.readAsBytes();
        // Convert the image data to Uint8List
        Uint8List uint8List = Uint8List.fromList(imageData);
        // Set chatImage to the Uint8List
        chatImage = uint8List;
        Future.delayed(Duration(seconds: 1), () {
          chatImage = File(pickedFile.path);
        });
      } else {
        chatImage = File(pickedFile.path);
      }
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<File> convertUint8ListToFile(
      Uint8List uint8List, String filePath) async {
    // Open the file in write mode.
    File file = File(filePath);

    // Write the bytes to the file.
    await file.writeAsBytes(uint8List);

    return file;
  }

  Future<void> sendChatImage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) async {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          receiverId: receiverId,
          dateTime: dateTime,
          text: text,
          image: value,
        );
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorHomePageStates());
      });
    });
  }

  List<MessageModel> adminList = [];
  List<MessageModel> messages = [];

  void getMessage({required String receiveId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(receiveId)
        .collection('message')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }

      print(messages.length);
      emit(Sucessgetmessage());
    });
  }

  void removePostImage() {
    chatImage = null;

    emit(SocialRemovePostImageState());
  }

  var uId = FirebaseAuth.instance.currentUser?.uid;

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) {
    MessageModel massageModel = MessageModel(
      message: text,
      senderId: uId,
      receiverId: receiverId,
      time: dateTime,
      image: image ?? '',
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc('7QfP0PNO6qVWVKij4jJzVNCG9sj2')
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(uId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  void getMessageAdmin() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc('7QfP0PNO6qVWVKij4jJzVNCG9sj2')
        .collection('message')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      adminList.clear();
      for (var element in event.docs) {
        adminList.add(MessageModel.fromJson(element.data()));
      }
      print(messages.length);
      emit(Sucessgetmessage());
    });
  }
}
