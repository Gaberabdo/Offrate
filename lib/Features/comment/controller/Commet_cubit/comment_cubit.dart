import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant.dart';
import '../../../Auth-feature/manger/model/user_model.dart';
import '../../model/comment_model.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  static CommentCubit get(context) {
    return BlocProvider.of(context);
  }

  UserModel model = UserModel();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> getUser() async {
    emit(LoadingGetUserdata());

    fireStore
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .snapshots()
        .listen((value) {
      model = UserModel.fromJson(value.data()!);
      emit(GetUserdataSuccess());
    }).onError((handleError) {
      emit(ErrorGetUserdata());
    });
  }

  Future createComment({
    required String comment,
    required String productId,
    required String image,
    required double price,
    required String name,
    required String phone,
  }) async {
    String dataTime = DateFormat('E MMM d y HH:mm:ss \'GMT\'Z (z)', 'en').format(DateTime.now());
    emit(CreateCommentLoadingState());
    CommentModel commentModel = CommentModel(
      name: name,
      uid: CacheHelper.getData(key: 'uId'),
      image: image,
      text: comment,
      price: price,
      phone: phone,
      dataTime: dataTime,
    );
    FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      sendNot();
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      emit(CreateCommentErrorState());
    });
  }

  Future<void> sendNot() async {
    final data = {
      'to': '/topics/Admin',
      'notification': {
        'body': 'Notification Form 4Sales',
        'title': 'new offer added on the post to  owner  ${model.name}',
      }
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${Constant.notImage}'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  List<CommentModel> commentPost = [];
  List<String> commentIds = [];

  void getComment({
    required String productId,
  }) {
    emit(GetCommentLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .collection('comments')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      commentPost.clear();
      for (var element in event.docs) {
        commentPost.add(CommentModel.fromJson(element.data()));
        commentPost.sort((a, b) => b.price!.compareTo(a.price as num));
        commentIds.add(element.id);
      }
      emit(GetCommentSuccessState());
    }).onError((handleError) {
      print(handleError.toString());
      emit(GetCommentErrorState());
    });
  }

  void makePhoneCall({required String phone}) async {
    final url = Uri.parse('tel:$phone');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
