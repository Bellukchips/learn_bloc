import 'package:clean_arch/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(appThemeData[AppTheme.lightMode]);
  void changeTheme(AppTheme theme) => emit(appThemeData[theme]);
}
