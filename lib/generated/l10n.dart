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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Food BooK`
  String get common_all_title {
    return Intl.message(
      'Food BooK',
      name: 'common_all_title',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get home_login_button_title {
    return Intl.message(
      'Join',
      name: 'home_login_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get home_scan_button_title {
    return Intl.message(
      'Scan',
      name: 'home_scan_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get login_title {
    return Intl.message(
      'Sign in',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `My store`
  String get menu_mystore_title {
    return Intl.message(
      'My store',
      name: 'menu_mystore_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get menu_logout_title {
    return Intl.message(
      'Sign out',
      name: 'menu_logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get menu_login_title {
    return Intl.message(
      'Sign in',
      name: 'menu_login_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get login_login_title {
    return Intl.message(
      'Sign in',
      name: 'login_login_title',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get login_mail_hintText {
    return Intl.message(
      'Mail',
      name: 'login_mail_hintText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password_hintText {
    return Intl.message(
      'Password',
      name: 'login_password_hintText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Your email address.`
  String get login_email_validator_empty_msg {
    return Intl.message(
      'Please enter Your email address.',
      name: 'login_email_validator_empty_msg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address. `
  String get login_email_validator_not_valid_msg {
    return Intl.message(
      'Please enter a valid email address. ',
      name: 'login_email_validator_not_valid_msg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password. `
  String get login_password_validator_empty_msg {
    return Intl.message(
      'Please enter your password. ',
      name: 'login_password_validator_empty_msg',
      desc: '',
      args: [],
    );
  }

  /// `My store`
  String get mystore_title {
    return Intl.message(
      'My store',
      name: 'mystore_title',
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
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}