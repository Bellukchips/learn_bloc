import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_login_app/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
part 'register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocProvider<RegisterCubit>(
            create: (_) =>
                RegisterCubit(context.read<AuthenticationRepository>()),
            child: const RegisterForm()),
      ),
    );
  }
}
