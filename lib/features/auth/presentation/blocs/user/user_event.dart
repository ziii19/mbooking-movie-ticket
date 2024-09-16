part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class CreateNewUser extends UserEvent {
  final String uid;
  final String name;
  final String email;
  final num? phoneNumber;
  final File? photoUrl;
  CreateNewUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
  });
}

final class UpdateUserDetail extends UserEvent {
  final String uid;
  final String name;
  final String email;
  final num? phoneNumber;
  final File? photoUrl;
  UpdateUserDetail({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
  });
}

final class GetUser extends UserEvent {
  final String? uid;
  GetUser({this.uid});
}
