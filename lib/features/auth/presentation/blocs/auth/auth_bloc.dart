import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/usecases/usecases.dart';
import 'package:mbooking/features/auth/domain/usecases/sign_in_google.dart';
import 'package:mbooking/features/auth/domain/usecases/user_login.dart';
import 'package:mbooking/features/auth/domain/usecases/user_sign_out.dart';
import 'package:mbooking/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  final UserSignOut _userSignOut;
  final SignInGoogle _signInGoogle;
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required UserSignOut userSignOut,
    required SignInGoogle signInGoogle,
  })  : _userLogin = userLogin,
        _userSignUp = userSignUp,
        _userSignOut = userSignOut,
        _signInGoogle = signInGoogle,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthLogin>((event, emit) async {
      final result = await _userLogin(
        UserLoginParam(
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (l) => emit(AuthError(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
    on<AuthSignUp>((event, emit) async {
      final result = await _userSignUp(
        UserSignUpParam(
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (l) => emit(AuthError(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
    on<AuthGoogleSignIn>((_, emit) async {
      final result = await _signInGoogle(NoParams());
      result.fold(
        (l) => emit(AuthError(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
    on<AuthLogout>((_, emit) async {
      final result = await _userSignOut(NoParams());
      result.fold(
        (l) => emit(AuthError(l.message)),
        (r) => emit(AuthInitial()),
      );
    });
  }
}
