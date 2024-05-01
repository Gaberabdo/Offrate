import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';
import 'package:sell_4_u/core/responsive_screen.dart';

import 'package:sell_4_u/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_4_u/Features/Auth-feature/presentation/pages/register/phone%20screen.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/helper/component/component.dart';
import '../../../../../generated/l10n.dart';
import '../register/register_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessGoogleLoginState) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Login success',
              ),
            );

            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigatorTo(context, LayoutScreen());
          }
          if (state is SuccessLoginState) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Login success',
              ),
            );
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigatorTo(context, LayoutScreen());
          }
          if (state is SuccessFaceLoginState) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Login success',
              ),
            );
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigatorTo(context, LayoutScreen());
          }
          if (state is UsernotRegister) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: 'Please Register',
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PhoneScreen();
            }));
          }
          if (state is PhoneNotRegisterstate) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: 'Please Register',
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PhoneScreen();
            }));
          }
          if (state is ErrorLoginState) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: 'Login Error',
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return ResponsiveScreen(
            mobileScreen: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  S.of(context).signIn,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          S.of(context).homeWelcome,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            fontSize: 27,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.phone,
                                obscureText: false,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).pleasePhone;
                                  }
                                  return null;
                                },
                                keyboardAppearance: Brightness.dark,
                                decoration: InputDecoration(
                                  labelText: S.of(context).Phone,
                                  labelStyle: GoogleFonts.tajawal(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    // Set the border radius
                                    borderSide:
                                        BorderSide.none, // Remove the border
                                  ),
                                  filled: true,
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: cubit.isPassword,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return S.of(context).pleasePassword;
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                labelText: S.of(context).Password,
                                labelStyle: GoogleFonts.tajawal(
                                    fontSize: 20, color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    cubit.suffix,
                                    color: Colors.grey,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  // Set the border radius
                                  borderSide:
                                      BorderSide.none, // Remove the border
                                ),
                                filled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            (state is LoadingLoginState)
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: ColorStyle.primaryColor,
                                    ),
                                  )
                                : Container(
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ColorStyle.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          cubit.login2(
                                              '${emailController.text}@gmail.com',
                                              passwordController.text);
                                        }

                                        if (state is SuccessLoginState) {
                                          print('donnnnnnnnnnnnne');
                                        }
                                      },
                                      child: Text(
                                        S.of(context).signIn,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  S.of(context).Or,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      cubit.signInWithFacebook();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade300,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/face.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  onTap: () {
                                    cubit.signInWithGoogle();
                                  },
                                  child: Container(
                                    height: 52,
                                    width: 52,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Image.asset(
                                        'assets/images/119930_google_512x512.png'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).donthave,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PhoneScreen();
                                    }));
                                  },
                                  child: Text(S.of(context).CreateAccount,
                                      style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            desktopScreen: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  S.of(context).signIn,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  S.of(context).homeWelcome,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.phone,
                                      obscureText: false,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return S.of(context).pleasePhone;
                                        }
                                        return null;
                                      },
                                      keyboardAppearance: Brightness.dark,
                                      decoration: InputDecoration(
                                        labelText: S.of(context).Phone,
                                        labelStyle: GoogleFonts.tajawal(
                                          fontSize: 20,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.phone,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          // Set the border radius
                                          borderSide: BorderSide
                                              .none, // Remove the border
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: cubit.isPassword,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return S.of(context).pleasePassword;
                                        }
                                        return null;
                                      },
                                      keyboardAppearance: Brightness.dark,
                                      decoration: InputDecoration(
                                        labelText: S.of(context).Password,
                                        labelStyle: GoogleFonts.tajawal(
                                          fontSize: 20,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.changePasswordVisibility();
                                          },
                                          icon: Icon(
                                            cubit.suffix,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          // Set the border radius
                                          borderSide: BorderSide
                                              .none, // Remove the border
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    state is LoadingLoginState
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Container(
                                            height: 45,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: ColorStyle.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: MaterialButton(
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.login2(
                                                      '${emailController.text}@gmail.com',
                                                      passwordController.text);
                                                }

                                                if (state
                                                    is SuccessLoginState) {
                                                  print('donnnnnnnnnnnnne');
                                                }
                                              },
                                              child: Text(
                                                S.of(context).signIn,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Divider(
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          S.of(context).Or,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Expanded(
                                          child: Divider(
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              cubit.signInWithFacebook();
                                            },
                                            child: Container(
                                              height: 55,
                                              width: 55,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/face.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              cubit.signInWithGoogle();
                                            },
                                            child: Container(
                                              height: 52,
                                              width: 52,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/119930_google_512x512.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).donthave,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return PhoneScreen();
                                            }));
                                          },
                                          child:
                                              Text(S.of(context).CreateAccount,
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Image(
                        height: MediaQuery.sizeOf(context).height,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/sales-b43bd.appspot.com/o/sale-discount-label-symbols-vector-trendy-design-template_460848-13447-removebg-preview.png?alt=media&token=e386d68c-333d-47bd-af1c-86c08ff1794b'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
