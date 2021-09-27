import 'package:formz/formz.dart';

/// validatation error email
enum EmailValidationError {
  /// generic validation
  invalid
}

//// @template email
///form input email
//// @endtemplate

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  ///macro email
  const Email.dirty([String value = '']) : super.dirty(value);

  /// email validation
  static final _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value!) ? null : EmailValidationError.invalid;
  }
}
