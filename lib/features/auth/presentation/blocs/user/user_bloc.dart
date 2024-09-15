import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/auth/domain/usecases/get_user_logged_in.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/create_user.dart';
import '../../../domain/usecases/update_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUser _createUser;
  final UpdateUser _updateUser;
  final GetUserLoggedIn _getUserLoggedIn;
  UserBloc({
    required CreateUser createUser,
    required UpdateUser updateUser,
    required GetUserLoggedIn getUserLoggedIn,
  })  : _createUser = createUser,
        _updateUser = updateUser,
        _getUserLoggedIn = getUserLoggedIn,
        super(UserInitial()) {
    on<UserEvent>((_, emit) => emit(UserLoading()));
    on<CreateNewUser>((event, emit) async {
      emit(UserLoading());
      final result = await _createUser(
        CreateUserParam(
          uid: event.uid,
          name: event.name,
          email: event.email,
          phoneNumber: event.phoneNumber,
          photoUrl: event.photoUrl,
        ),
      );
      result.fold(
        (l) => emit(UserError(l.message)),
        (r) => emit(UserSuccess(r)),
      );
    });
    on<UpdateUserDetail>((event, emit) async {
      emit(UserLoading());
      final result = await _updateUser(
        UpdateUserParam(
          uid: event.uid,
          name: event.name,
          email: event.email,
          phoneNumber: event.phoneNumber,
          photoUrl: event.photoUrl,
        ),
      );
      result.fold(
        (l) => emit(UserError(l.message)),
        (r) => emit(UserSuccess(r)),
      );
    });
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      final result = await _getUserLoggedIn(GetUserParam(uid: event.uid));
      result.fold(
        (l) => emit(UserError(l.message)),
        (r) => emit(UserSuccess(r)),
      );
    });
  }
}
