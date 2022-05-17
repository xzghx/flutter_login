import 'package:formz/formz.dart';

enum PasswordError { invalid }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.pure(value);

  @override
  PasswordError? validator(String value) {
    return value.isNotEmpty && value.length >= 3 ? null : PasswordError.invalid;
  }
}
