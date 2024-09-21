import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbooking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mbooking/features/auth/data/datasources/user_repo_remote_data_source.dart';
import 'package:mbooking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mbooking/features/auth/data/repositories/user_repository_impl.dart';
import 'package:mbooking/features/auth/domain/usecases/create_user.dart';
import 'package:mbooking/features/auth/domain/usecases/user_login.dart';
import 'package:mbooking/features/auth/domain/usecases/user_sign_up.dart';
import 'package:mbooking/features/auth/domain/usecases/get_user_logged_in.dart';
import 'package:mbooking/features/auth/domain/usecases/update_user.dart';
import 'package:mbooking/features/auth/domain/usecases/user_sign_out.dart';
import 'package:mbooking/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:mbooking/features/auth/presentation/blocs/user/user_bloc.dart';
import 'package:mbooking/features/movie/data/datasource/movie_remote_data_source.dart';
import 'package:mbooking/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:mbooking/features/movie/domain/repositories/movie_repository.dart';
import 'package:mbooking/features/movie/domain/usecases/get_movie_actor.dart';
import 'package:mbooking/features/movie/domain/usecases/get_now_playing.dart';
import 'package:mbooking/features/movie/presentation/blocs/movie/movies_bloc.dart';
import 'package:mbooking/features/movie/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:mbooking/features/transaction/data/datasource/transaction_remote_data_source.dart';
import 'package:mbooking/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:mbooking/features/transaction/presentation/blocs/transaction/transaction_bloc.dart';

import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/movie/domain/usecases/get_movie_detail.dart';
import 'features/movie/domain/usecases/get_upcoming.dart';
import 'features/transaction/domain/repositories/transaction_repository.dart';
import 'features/transaction/domain/usecases/create_transaction.dart';
import 'features/transaction/domain/usecases/get_user_transaction.dart';
import 'features/transaction/domain/usecases/update_transaction.dart';

final GetIt sl = GetIt.instance;

void initLocator() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  sl.registerLazySingleton<FirebaseStorage>(
    () => FirebaseStorage.instance,
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl<FirebaseAuth>(),
    ),
  );
  sl.registerLazySingleton<UserRepoRemoteDataSource>(
    () => UserRepoRemoteDataSourceImpl(
      sl<FirebaseFirestore>(),
      sl<FirebaseStorage>(),
      sl<FirebaseAuth>(),
    ),
  );
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(
      sl<FirebaseFirestore>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      sl<UserRepoRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      sl<MovieRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      sl<TransactionRemoteDataSource>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<UserLogin>(
    () => UserLogin(
      sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<UserSignUp>(
    () => UserSignUp(
      sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<UserSignOut>(
    () => UserSignOut(
      sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<CreateUser>(
    () => CreateUser(
      sl<UserRepository>(),
    ),
  );
  sl.registerLazySingleton<UpdateUser>(
    () => UpdateUser(
      sl<UserRepository>(),
    ),
  );
  sl.registerLazySingleton<GetUserLoggedIn>(
    () => GetUserLoggedIn(
      sl<UserRepository>(),
    ),
  );
  sl.registerLazySingleton<GetNowPlaying>(
    () => GetNowPlaying(
      sl<MovieRepository>(),
    ),
  );
  sl.registerLazySingleton<GetUpcoming>(
    () => GetUpcoming(
      sl<MovieRepository>(),
    ),
  );
  sl.registerLazySingleton<GetMovieDetail>(
    () => GetMovieDetail(
      sl<MovieRepository>(),
    ),
  );
  sl.registerLazySingleton<GetMovieActor>(
    () => GetMovieActor(
      sl<MovieRepository>(),
    ),
  );

  sl.registerLazySingleton<CreateTransaction>(
    () => CreateTransaction(
      sl<TransactionRepository>(),
    ),
  );
  sl.registerLazySingleton<UpdateTransaction>(
    () => UpdateTransaction(
      sl<TransactionRepository>(),
    ),
  );
  sl.registerLazySingleton<GetUserTransaction>(
    () => GetUserTransaction(
      sl<TransactionRepository>(),
    ),
  );

  // Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      userLogin: sl<UserLogin>(),
      userSignUp: sl<UserSignUp>(),
      userSignOut: sl<UserSignOut>(),
    ),
  );
  sl.registerFactory<UserBloc>(
    () => UserBloc(
      createUser: sl<CreateUser>(),
      updateUser: sl<UpdateUser>(),
      getUserLoggedIn: sl<GetUserLoggedIn>(),
    ),
  );
  sl.registerFactory(
    () => MoviesBloc(
      getNowPlaying: sl<GetNowPlaying>(),
      getUpcoming: sl<GetUpcoming>(),
    ),
  );
  sl.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: sl<GetMovieDetail>(),
      getMovieActor: sl<GetMovieActor>(),
    ),
  );
  sl.registerFactory(
    () => TransactionBloc(
      createTransaction: sl<CreateTransaction>(),
      updateTransaction: sl<UpdateTransaction>(),
      getUserTransaction: sl<GetUserTransaction>(),
    ),
  );
}
