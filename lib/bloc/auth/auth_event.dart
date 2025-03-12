import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insta_closet/models/auth.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final Auth auth;

  LoggedIn(this.auth);

  @override
  List<Object> get props => [auth];
}

class LoggedOut extends AuthEvent {
  final BuildContext? context;
  LoggedOut({this.context});
}
