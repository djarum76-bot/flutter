import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError { invalid }

class ConfirmPasswordValidator extends FormzInput<String, ConfirmedPasswordValidationError>{
  const ConfirmPasswordValidator.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordValidator.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmedPasswordValidationError.invalid;
  }
}