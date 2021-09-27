import 'package:formz/formz.dart';

enum UsernameValidatorError { empty }

class Username extends FormzInput<String, UsernameValidatorError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidatorError validator(String value) {
    return value.isNotEmpty == true ? null : UsernameValidatorError.empty;
  }
}
