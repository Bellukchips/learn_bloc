import 'package:clean_arch/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/pages.dart';

void main() {
  runApp(InitLayer());
}

class InitLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(1080, 1920),
          builder: () => MaterialApp(
            title: "Clean Architecture",
            theme: state,
            home: SignInPage(),
          ),
        );
      },
    );
  }
}
