part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}

final class UserSuccess extends UserState {
  final User user;

  UserSuccess(this.user);
}
