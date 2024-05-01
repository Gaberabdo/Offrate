import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/create_post.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/feeds_screen.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/panner_cat.dart';
import 'package:sell_4_u/Features/setting/view/screens/profile_screen.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/helper/cache/cache_helper.dart';

import '../../../Auth-feature/manger/model/user_model.dart';
import '../../models/coupon-model.dart';
import '../../models/subscripation-model.dart';
import 'home-state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const FeedsScreen(),
    const BannerCat(),
    const CreatePost(),
    const ProfileScreen(),
  ];
  int selectedIndex = 0;

  TextEditingController controller = TextEditingController();

  void onItemTapped(int index) {
    selectedIndex = index;
    emit(ChangeItemIndex());
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  UserModel model = UserModel();

  Future<void> getUser() async {
    fireStore
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .snapshots()
        .listen((value) {
      model = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'uId', value: model.uId);
      print("*********************************${model.toMap().toString()}");
      CacheHelper.saveData(key: 'isBlocked', value: model.blocked ?? false);
      print(
          '*********************************${CacheHelper.getData(key: 'isBlocked')}');
      print(
          '*********************************${CacheHelper.getData(key: 'uId')}');

      emit(GetUserdataSuccess());
    }).onError((handleError) {
      emit(ErrorGetUserdata());
    });
    emit(LoadingGetUserdata());
  }

  List<CouponModel> coupons = [];

  Future<void> getCoupons() async {
    emit(CouponGetLoadinglState());
    FirebaseFirestore.instance.collection('Coupons').snapshots().listen(
        (snapshot) {
      coupons = [];
      snapshot.docs.forEach((element) {
        print('eeeeeeeeeeeeelement${element.data()}');
      });
      for (var doc in snapshot.docs) {
        var data = doc.data();
        coupons.add(CouponModel.fromJson(data));
        print(coupons.length);
        print('lennnnnnnnnnthhhhhhhhhh');
      }
      emit(CouponGetScussesState());
    }, onError: (e) {
      print(e.toString());
      emit(CouponGetErorrState());
    });
  }

  List<SubscripationModel> subscriptions = [];

  Future<void> getSubscriptions() async {
    emit(SubscripationGetLoadinglState());
    FirebaseFirestore.instance.collection('subscripations').snapshots().listen(
        (snapshot) {
      subscriptions = [];
      snapshot.docs.forEach((element) {
        print('eeeeeeeeeeeeelement${element.data()}');
      });
      for (var doc in snapshot.docs) {
        var data = doc.data();
        subscriptions.add(SubscripationModel.fromJson(data));
        print(subscriptions.length);
        print('lennnnnnnnnnthhhhhhhhhh');
      }
      emit(SubscripationGetScussesState());
    }, onError: (e) {
      print(e.toString());
      emit(SubscripationGetErorrState());
    });
  }

  ///
}
