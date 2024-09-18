import 'package:dio/dio.dart';
import 'package:mbooking/core/constants/movie_category.dart';
import 'package:mbooking/core/constants/service_token.dart';
import 'package:mbooking/features/movie/data/models/movie_detail_model.dart';
import 'package:mbooking/features/movie/data/models/movie_model.dart';

import '../models/actor_model.dart';

abstract interface class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying(int page);
  Future<List<MovieModel>> getUpcoming(int page);
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<ActorModel>> getActorMovie(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  Dio get dio {
    return Dio()
      ..options = BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/movie',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ServiceToken.tmdbToken}',
        },
      );
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    try {
      final response = await dio.get('/$id');
      return MovieDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<MovieModel>> getNowPlaying(int page) async => await _getMovies(
        MovieCategory.nowPlaying.category,
        page: page,
      );

  @override
  Future<List<MovieModel>> getUpcoming(int page) async => await _getMovies(
        MovieCategory.upcoming.category,
        page: page,
      );

  @override
  Future<List<ActorModel>> getActorMovie(int id) async {
    try {
      final response = await dio.get('/$id/credits');
      final cast = List<Map<String, dynamic>>.from(response.data['cast'])
          .where((e) => e['profile_path'] != null)
          .toList();
      final crew = List<Map<String, dynamic>>.from(response.data['crew'])
          .where((e) => e['profile_path'] != null && e['job'] == 'Director')
          .toList();

      final actors = [...cast, ...crew];
      return actors.map((e) => ActorModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieModel>> _getMovies(String category, {int page = 1}) async {
    try {
      final response = await dio.get(
        '/$category',
        queryParameters: {'page': page, 'language': 'en-US'},
      );

      final movie = List<Map<String, dynamic>>.from(response.data['results']);

      return movie.map((e) => MovieModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
