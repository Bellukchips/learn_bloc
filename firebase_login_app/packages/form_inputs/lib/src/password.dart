import 'package:formz/formz.dart';

/// validation password
enum PasswordValidationError {
  /// generic validation
  invalid
}

///@template password
/// formz input password
///@endtemplate

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  /// macro password
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value!)
        ? null
        : PasswordValidationError.invalid;
  }
}
