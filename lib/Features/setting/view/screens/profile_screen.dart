import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sell_4_u/Features/Auth-feature/presentation/pages/login/login_screen.dart';
import 'package:sell_4_u/Features/chat_feature/screens/user/all_user_screen.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';
import 'package:sell_4_u/Features/setting/view/screens/edit_profile.dart';
import 'package:sell_4_u/Features/setting/view/screens/recently_viewed.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_cubit.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_state.dart';

import '../../../../core/helper/cache/cache_helper.dart';
import '../../../../core/responsive_screen.dart';
import '../../../../generated/l10n.dart';
import '../../Cubit/setting_cubit.dart';
import 'inbox_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getUser(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SettingCubit.get(context);
          var userModel = cubit.model!;
          return BlocConsumer<MainCubit, MainState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: ResponsiveScreen.setColorTheme(
                  Colors.white,
                  ThemeData.dark().scaffoldBackgroundColor,
                  context,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        if (CacheHelper.getData(key: "uId") == null ||
                            cubit.model.image == null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg',
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User name",
                                    style: FontStyleThame.textStyle(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginScreen()));
                                    },
                                    child: Text(
                                      'login to buy and sell anything',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 90,
                                    backgroundImage:
                                        NetworkImage(userModel!.image!),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userModel!.name!,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          S.of(context).myAccount,
                          style: FontStyleThame.textStyle(
                            fontColor: ColorStyle.primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 266,
                          decoration: BoxDecoration(
                              //color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                              )),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (CacheHelper.getData(key: "uId") == null) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return LoginScreen();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return EditProfile(
                                            model: cubit.model,
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: ResponsiveScreen.setColorTheme(
                                      const Color.fromRGBO(242, 242, 242, 1),
                                      ThemeData.dark().scaffoldBackgroundColor,
                                      context,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          S.of(context).edit_profile,
                                          style: FontStyleThame.textStyle(),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              GestureDetector(
                                onTap: () {
                                  if (CacheHelper.getData(key: "uId") == null) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return LoginScreen();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return const InBoxList();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: ResponsiveScreen.setColorTheme(
                                      const Color.fromRGBO(242, 242, 242, 1),
                                      ThemeData.dark().scaffoldBackgroundColor,
                                      context,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    //   border: Border.all(width: 1,)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.library_books_sharp,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          S.of(context).my_listings,
                                          style: FontStyleThame.textStyle(),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              GestureDetector(
                                onTap: () {
                                  if (CacheHelper.getData(key: "uId") == null) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return LoginScreen();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return const RecentlyViewed();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: ResponsiveScreen.setColorTheme(
                                      const Color.fromRGBO(242, 242, 242, 1),
                                      ThemeData.dark().scaffoldBackgroundColor,
                                      context,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite_border,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          S.of(context).my_favorites,
                                          style: FontStyleThame.textStyle(),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              GestureDetector(
                                onTap: () {
                                  if (CacheHelper.getData(key: "uId") == null) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return LoginScreen();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return AllUserScreen();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: ResponsiveScreen.setColorTheme(
                                      const Color.fromRGBO(242, 242, 242, 1),
                                      ThemeData.dark().scaffoldBackgroundColor,
                                      context,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    //   border: Border.all(width: 1,)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.support_agent_rounded,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          'Custom',
                                          style: FontStyleThame.textStyle(),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          S.of(context).setting,
                          style: FontStyleThame.textStyle(
                            fontColor: ColorStyle.primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ResponsiveScreen.setColorTheme(
                              const Color.fromRGBO(242, 242, 242, 1),
                              ThemeData.dark().scaffoldBackgroundColor,
                              context,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.language,
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      S.of(context).language,
                                      style: FontStyleThame.textStyle(),
                                    ),
                                    const Spacer(),
                                    PopupMenuButton<int>(
                                      onCanceled: () {
                                        Navigator.of(context);
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            value: 1,
                                            onTap: () {
                                              MainCubit.get(context)
                                                  .changeAppLang(
                                                      langMode: 'en');
                                            },
                                            child: Text(
                                              S.of(context).english,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            onTap: () {
                                              MainCubit.get(context)
                                                  .changeAppLang(
                                                      langMode: 'ar');
                                            },
                                            child: Text(
                                              S.of(context).arabic,
                                            ),
                                          ),
                                        ];
                                      },
                                      child: const Icon(Icons.more_horiz),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      MainCubit.get(context).isDark
                                          ? Icons.dark_mode_outlined
                                          : Icons.light_mode_outlined,
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      S.of(context).darkMode,
                                      style: FontStyleThame.textStyle(),
                                    ),
                                    const Spacer(),
                                    Switch(
                                      value:
                                          CacheHelper.getData(key: 'isDark') ??
                                              false,
                                      onChanged: (value) {
                                        MainCubit.get(context).changeAppMode();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              GestureDetector(
                                onTap: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.rightSlide,
                                      title: 'Warning',
                                      desc: 'Are You Sure To Logout...?',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        CacheHelper.clearData()
                                            .then((value) async {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return LoginScreen();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin =
                                                    const Offset(1.0, 0.0);
                                                var end = Offset.zero;
                                                var curve = Curves.ease;
                                                var tween = Tween(
                                                        begin: begin, end: end)
                                                    .chain(CurveTween(
                                                        curve: curve));
                                                var offsetAnimation =
                                                    animation.drive(tween);
                                                return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child,
                                                );
                                              },
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                            ),
                                          );

                                          FirebaseAuth.instance.signOut();
                                          FacebookAuth.instance.logOut();
                                          final GoogleSignIn _googleSignIn =
                                              GoogleSignIn();

                                          await _googleSignIn.signOut();
                                        });
                                      }).show();
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: ResponsiveScreen.setColorTheme(
                                      const Color.fromRGBO(242, 242, 242, 1),
                                      ThemeData.dark().scaffoldBackgroundColor,
                                      context,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.logout,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          S.of(context).logout,
                                          style: FontStyleThame.textStyle(),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
