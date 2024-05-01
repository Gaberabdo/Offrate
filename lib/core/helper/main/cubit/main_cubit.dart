import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant.dart';
import '../../cache/cache_helper.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  void changeLang() {
    emit(ChangeLangState());
  }

  String? language;

  void changeAppLang({
    String? fromSharedLang,
    String? langMode,
  }) {
    if (fromSharedLang != null) {
      language = fromSharedLang;
      emit(AppChangeModeState());
    } else {
      language = langMode;
      CacheHelper.saveData(
        key: 'language',
        value: langMode!,
      ).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeFromSharedState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(
        key: 'isDark',
        value: isDark,
      );
      print(isDark);
      print(CacheHelper.getData(key: 'isDark'));
      emit(AppChangeModeState());
    }
  }

  void subscribeToAdminTopic() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if(!kIsWeb){
      FirebaseMessaging.instance.subscribeToTopic('Admin').then((value) {
        emit(AdminTopicState());
      }).catchError((onError) {
        print('*************************');
        print(onError.toString());
        print('*************************');
      });
    }

  }
}
