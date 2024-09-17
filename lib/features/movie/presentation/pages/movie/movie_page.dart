import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_category.dart';
import 'package:mbooking/core/utils/get_genre_names.dart';
import 'package:mbooking/core/utils/number_format.dart';
import 'package:mbooking/features/movie/presentation/blocs/cubit/category_index_cubit.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../blocs/movie/movies_bloc.dart';
import '../../widgets/now_playing_card.dart';
import '../../widgets/upcoming_card.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryIndexCubit, MovieCategory>(
        builder: (context, movieCategory) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.enabled,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            transform: Matrix4.translationValues(
                              (MediaQuery.of(context).size.width / 2 - 20) *
                                  (movieCategory == MovieCategory.nowPlaying
                                      ? 0
                                      : 1),
                              0,
                              0,
                            ),
                            duration: const Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.yellow,
                            ),
                          ),
                          Row(
                            children: MovieCategory.values
                                .map(
                                  (e) => Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          movieCategory = e;
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Text(
                                            e.title,
                                            style: TextStyle(
                                              color: movieCategory == e
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesSuccess) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final crossAxisCount = width > 600 ? 3 : 2;
                        final heightCard =
                            movieCategory == MovieCategory.nowPlaying
                                ? 380
                                : 345;
                        final aspectRatio = width / crossAxisCount / heightCard;

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 20,
                          childAspectRatio: aspectRatio,
                          children: movieCategory == MovieCategory.nowPlaying
                              ? state.nowPlayingMovies
                                  .map(
                                    (movie) => NowPlayingCard(
                                      id: movie.id,
                                      posterUrl: movie.posterPath,
                                      title: movie.title,
                                      vote:
                                          movie.voteAverage.toStringAsFixed(1),
                                      voteCount:
                                          numFormat(movie.voteCount.toString()),
                                      genre: getGenreNames(movie.genreIds),
                                      release: movie.releaseDate,
                                    ),
                                  )
                                  .toList()
                              : state.upcomingMovies
                                  .map(
                                    (movie) => UpcomingCard(
                                      posterUrl: movie.posterPath,
                                      title: movie.title,
                                      genre: getGenreNames(movie.genreIds)
                                          .take(2)
                                          .map((e) => e)
                                          .toList()
                                          .join(', '),
                                      release: movie.releaseDate,
                                    ),
                                  )
                                  .toList(),
                        );
                      },
                    );
                  } else if (state is MoviesError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
