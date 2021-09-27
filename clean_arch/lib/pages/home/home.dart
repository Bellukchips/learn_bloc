import 'package:clean_arch/blocs/blocs.dart';
import 'package:clean_arch/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
                value: isDarkMode,
                onChanged: (value) {
                  isDarkMode = value;
                  setState(() {
                    if (isDarkMode) {
                      context.read<ThemeCubit>().changeTheme(AppTheme.darkMode);
                    } else {
                      context
                          .read<ThemeCubit>()
                          .changeTheme(AppTheme.lightMode);
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
