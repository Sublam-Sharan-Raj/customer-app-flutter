part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class GenerateVerificationCode extends SignInEvent {
  final String? userName;

  GenerateVerificationCode({this.userName});
}

class ValidateVerificationCode extends SignInEvent {
  final String? userName;
  final String? code;

  ValidateVerificationCode({this.userName, this.code});
}

class CreateNewAccount extends SignInEvent {
  final String? lastName;
  final String? firstName;
  final String? role;
  final String? email;
  final String? mobile;
  final BuildContext context;

  CreateNewAccount(
      {this.lastName,
      this.firstName,
      this.role,
      this.email,
      this.mobile,
      required this.context});
}
