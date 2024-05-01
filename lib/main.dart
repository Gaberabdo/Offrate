import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_state.dart';

import 'core/helper/bloc_observe/observe.dart';
import 'core/helper/cache/cache_helper.dart';
import 'core/helper/main/cubit/main_cubit.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Provider.debugCheckInvalidValueType = null;

  await Firebase.initializeApp(
    options: Constant.options,
  );

  await CacheHelper.init();
  CacheHelper.getData(key: 'uId');

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
    print(value);
    if (CacheHelper.getData(key: "uId") != null) {
      CacheHelper.saveData(key: 'fcmToken', value: value);
      FirebaseFirestore.instance
          .collection('users')
          .doc(CacheHelper.getData(key: "uId"))
          .update(
        {
          'token': value,
        },
      );
    }
    print('token*********');
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "900168241845784",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }
  runApp(MyApp(
    language: CacheHelper.getData(key: 'language') ?? 'en',
  ));
}

class MyApp extends StatelessWidget {
  final String language;

  MyApp({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..changeAppLang(fromSharedLang: language)
        ..changeAppMode(
          fromShared: CacheHelper.getData(key: 'isDark') ?? false,
        )
        ..subscribeToAdminTopic(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return MaterialApp(
            title: 'oferrta - أوڨيرتا',

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: false,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 3,
                  backgroundColor: Colors.white,
                  selectedItemColor: ColorStyle.primaryColor,
                  selectedLabelStyle: FontStyleThame.textStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  unselectedLabelStyle: FontStyleThame.textStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  unselectedItemColor: const Color.fromRGBO(207, 207, 206, 1),
                  selectedIconTheme: const IconThemeData(
                    size: 18,
                  ),
                  unselectedIconTheme: const IconThemeData(
                    size: 18,
                  ),
                ),
                //  scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                )),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(
              useMaterial3: false,
            ),
            home: LayoutScreen(),
            locale: cubit.language == 'en'
                ? const Locale('en')
                : const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}
