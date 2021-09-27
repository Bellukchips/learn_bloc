import 'dart:async';
import 'package:flutter/material.dart';

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
      context,
      FlutterBlocLocalizations,
    );
  }

  String get appTitle => 'Flutter Todos';
}

class FlutterBlocLocalizationsDelegate
    extends LocalizationsDelegate<FlutterBlocLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode.toLowerCase().contains('en');
  }

  @override
  Future<FlutterBlocLocalizations> load(Locale locale) =>
      Future(() => FlutterBlocLocalizations());

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<FlutterBlocLocalizations> old) {
    return false;
  }
}
