import 'package:formz/formz.dart';

/// validation errors
enum ConfirmPasswordValidationError {
  /// generic invalid error
  invalid
}

/// form input confirm password
class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  /// confirm password
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// original password
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmPasswordValidationError.invalid;
  }
}
