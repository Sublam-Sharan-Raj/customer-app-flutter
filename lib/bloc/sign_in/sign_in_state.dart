part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSendingCodeState extends SignInState {}

class SignInCodeSentState extends SignInState {
  final String? userName;
  SignInCodeSentState(this.userName);
  @override
  List<Object?> get props => [userName];
}

class SignInValidatingCodeState extends SignInState {}

class SignInErrorState extends SignInState {
  final String? error;

  SignInErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class SignInFinishedState extends SignInState {}

class SignInCreatingAccountState extends SignInState {}

class SignInCreateAccountSuccessState extends SignInState {}

class SignInCreateAccountErrorState extends SignInState {
  final String? error;

  SignInCreateAccountErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
