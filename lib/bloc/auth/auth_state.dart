import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_closet/models/auth.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthenticationStatus.loading) AuthenticationStatus status,
    @Default(false) bool showLoggedOutDialog,
    @Default("") String message,
    Auth? auth,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();
}

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  loading,
  tokenExpired
}
