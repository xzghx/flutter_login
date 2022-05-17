import 'package:formz/formz.dart';

enum UserNameError { invalid }

class UserName extends FormzInput<String, UserNameError> {
  const UserName.pure() : super.pure('');

  const UserName.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameError? validator(String value) {
    return value.isNotEmpty ? null : UserNameError.invalid;
  }
}
