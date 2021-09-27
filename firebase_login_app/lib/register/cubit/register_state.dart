part of 'register_cubit.dart';

enum ConfirmPassowrdValidationError { invalid }

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
  });
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;
  @override
  List<Object> get props => [email, password, confirmPassword, status];

  RegisterState copyWith(
      {Email? email,
      Password? password,
      ConfirmPassword? confirmPassword,
      FormzStatus? status}) {
    return RegisterState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        status: status ?? this.status);
  }
}
