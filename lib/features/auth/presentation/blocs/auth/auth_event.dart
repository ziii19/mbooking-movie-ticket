part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignUp({required this.email, required this.password});
}

final class AuthLogout extends AuthEvent {}
