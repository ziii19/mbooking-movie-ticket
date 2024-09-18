import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/movie/presentation/blocs/cubit/category_index_cubit.dart';

import 'core/theme/theme.dart';
import 'core/utils/rand_int.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/auth/presentation/blocs/user/user_bloc.dart';
import 'features/auth/presentation/pages/auth/auth_page.dart';
import 'features/main/pages/main_page.dart';
import 'features/movie/presentation/blocs/movie/movies_bloc.dart';
import 'features/movie/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'firebase_options.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initLocator();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => sl<AuthBloc>(),
    ),
    BlocProvider(
      create: (context) => sl<UserBloc>(),
    ),
    BlocProvider(
      create: (context) => sl<MoviesBloc>(),
    ),
    BlocProvider(
      create: (context) => NavIndexCubit(),
    ),
    BlocProvider(
      create: (context) => CategoryIndexCubit(),
    ),
    BlocProvider(
      create: (context) => sl<MovieDetailBloc>(),
    ),
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUser());
    context.read<MoviesBloc>().add(BlocGetMovies(page: generateRandomInt(5)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocSelector<UserBloc, UserState, bool>(
        selector: (state) {
          return state is UserSuccess;
        },
        builder: (context, isLoggedIn) {
          if (!isLoggedIn) {
            return const AuthPage();
          }
          return const MainPage();
        },
      ),
    );
  }
}
