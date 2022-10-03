import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class PasswordValidator extends FormzInput<String, PasswordValidationError>{
  const PasswordValidator.pure() : super.pure('');
  const PasswordValidator.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return value!.length >= 6 ? null : PasswordValidationError.invalid;
  }
}