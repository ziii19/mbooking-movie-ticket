import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mbooking/features/auth/data/datasources/user_repo_remote_data_source.dart';
import 'package:mbooking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mbooking/features/auth/data/repositories/user_repository_impl.dart';
import 'package:mbooking/features/auth/domain/usecases/create_user.dart';
import 'package:mbooking/features/auth/domain/usecases/user_login.dart';
import 'package:mbooking/features/auth/domain/usecases/user_sign_up.dart';
import 'package:mbooking/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:mbooking/features/auth/presentation/pages/onboard/onboard_page.dart';
import 'package:mbooking/firebase_options.dart';

import 'core/theme/theme.dart';
import 'features/auth/domain/usecases/get_user_logged_in.dart';
import 'features/auth/domain/usecases/update_user.dart';
import 'features/auth/domain/usecases/user_sign_out.dart';
import 'features/auth/presentation/blocs/user/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(
        userLogin: UserLogin(
          AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(
              firebaseAuth: FirebaseAuth.instance,
            ),
          ),
        ),
        userSignUp: UserSignUp(
          AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(
              firebaseAuth: FirebaseAuth.instance,
            ),
          ),
        ),
        userSignOut: UserSignOut(
          AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(
              firebaseAuth: FirebaseAuth.instance,
            ),
          ),
        ),
      ),
    ),
    BlocProvider(
        create: (context) => UserBloc(
              createUser: CreateUser(
                UserRepositoryImpl(
                  UserRepoRemoteDataSourceImpl(
                    FirebaseFirestore.instance,
                    FirebaseStorage.instance,
                  ),
                ),
              ),
              updateUser: UpdateUser(
                UserRepositoryImpl(
                  UserRepoRemoteDataSourceImpl(
                    FirebaseFirestore.instance,
                    FirebaseStorage.instance,
                  ),
                ),
              ),
              getUserLoggedIn: GetUserLoggedIn(
                UserRepositoryImpl(
                  UserRepoRemoteDataSourceImpl(
                    FirebaseFirestore.instance,
                    FirebaseStorage.instance,
                  ),
                ),
              ),
            )),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const OnboardPage(),
    );
  }
}
