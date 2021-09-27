import 'package:firebase_login_app/app/bloc/app_bloc.dart';
import 'package:firebase_login_app/home/home.dart';
import 'package:firebase_login_app/login/login.dart';
import 'package:flutter/widgets.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
