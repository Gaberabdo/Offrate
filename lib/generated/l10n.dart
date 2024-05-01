// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Search for anything`
  String get search {
    return Intl.message(
      'Search for anything',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Near you`
  String get nearYou {
    return Intl.message(
      'Near you',
      name: 'nearYou',
      desc: '',
      args: [],
    );
  }

  /// `CreateAccount`
  String get CreateAccount {
    return Intl.message(
      'CreateAccount',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Continue Browsing`
  String get continueB {
    return Intl.message(
      'Continue Browsing',
      name: 'continueB',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get mostP {
    return Intl.message(
      'Most Popular',
      name: 'mostP',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign {
    return Intl.message(
      'Sign Up',
      name: 'sign',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get Or {
    return Intl.message(
      'OR',
      name: 'Or',
      desc: '',
      args: [],
    );
  }

  /// `please enter your email address`
  String get pleaseEmail {
    return Intl.message(
      'please enter your email address',
      name: 'pleaseEmail',
      desc: '',
      args: [],
    );
  }

  /// `please enter your phone`
  String get pleasePhone {
    return Intl.message(
      'please enter your phone',
      name: 'pleasePhone',
      desc: '',
      args: [],
    );
  }

  /// `please enter your name`
  String get pleaseName {
    return Intl.message(
      'please enter your name',
      name: 'pleaseName',
      desc: '',
      args: [],
    );
  }

  /// `please enter your password`
  String get pleasePassword {
    return Intl.message(
      'please enter your password',
      name: 'pleasePassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in With Google`
  String get signWithgoogle {
    return Intl.message(
      'Sign in With Google',
      name: 'signWithgoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in With Facebook`
  String get signWithFace {
    return Intl.message(
      'Sign in With Facebook',
      name: 'signWithFace',
      desc: '',
      args: [],
    );
  }

  /// `Don\'t have an accounat?`
  String get donthave {
    return Intl.message(
      'Don\\\'t have an accounat?',
      name: 'donthave',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Complete Sign Up`
  String get completeSignUp {
    return Intl.message(
      'Complete Sign Up',
      name: 'completeSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get homeWelcome {
    return Intl.message(
      'Welcome',
      name: 'homeWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Call now`
  String get callMe {
    return Intl.message(
      'Call now',
      name: 'callMe',
      desc: '',
      args: [],
    );
  }

  /// `What's app`
  String get whatsapp {
    return Intl.message(
      'What\'s app',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Post an Ad`
  String get postAd {
    return Intl.message(
      'Post an Ad',
      name: 'postAd',
      desc: '',
      args: [],
    );
  }

  /// `Please write your details...`
  String get details {
    return Intl.message(
      'Please write your details...',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Please write your description...`
  String get descriptionAdd {
    return Intl.message(
      'Please write your description...',
      name: 'descriptionAdd',
      desc: '',
      args: [],
    );
  }

  /// `Please write reason to offer...`
  String get reasonAdd {
    return Intl.message(
      'Please write reason to offer...',
      name: 'reasonAdd',
      desc: '',
      args: [],
    );
  }

  /// ` Verify Phone`
  String get verfyEmail {
    return Intl.message(
      ' Verify Phone',
      name: 'verfyEmail',
      desc: '',
      args: [],
    );
  }

  /// ` Resend Otp`
  String get resendOtp {
    return Intl.message(
      ' Resend Otp',
      name: 'resendOtp',
      desc: '',
      args: [],
    );
  }

  /// ` Create Ad`
  String get createPost {
    return Intl.message(
      ' Create Ad',
      name: 'createPost',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `My Listings`
  String get my_listings {
    return Intl.message(
      'My Listings',
      name: 'my_listings',
      desc: '',
      args: [],
    );
  }

  /// `My Favorites`
  String get my_favorites {
    return Intl.message(
      'My Favorites',
      name: 'my_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `myAccount`
  String get myAccount {
    return Intl.message(
      'myAccount',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Category details`
  String get catDetails {
    return Intl.message(
      'Category details',
      name: 'catDetails',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Commercials`
  String get commercials {
    return Intl.message(
      'Commercials',
      name: 'commercials',
      desc: '',
      args: [],
    );
  }

  /// `Post an Ad`
  String get post_an_ad {
    return Intl.message(
      'Post an Ad',
      name: 'post_an_ad',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
