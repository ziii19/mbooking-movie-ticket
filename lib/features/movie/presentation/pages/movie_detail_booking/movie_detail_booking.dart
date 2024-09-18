import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/constants/cinema.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/number_format.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/movie/domain/entities/actor.dart';
import 'package:mbooking/features/movie/presentation/widgets/movie_info.dart';
import 'package:mbooking/features/movie/presentation/widgets/title_content_detail_movie.dart';

import '../../../../../core/widgets/expendable_text.dart';
import '../../blocs/movie_detail/movie_detail_bloc.dart';
import '../../widgets/actor_card.dart';
import '../../widgets/cinema_card.dart';

part 'section/movie_card_section.dart';
part 'section/movie_detail_section.dart';
part 'section/actor_section.dart';
part 'section/pick_cinema.dart';

class MovieDetailBooking extends StatefulWidget {
  static route(int id) => MaterialPageRoute(
        builder: (context) => MovieDetailBooking(id: id),
      );

  final int id;
  const MovieDetailBooking({super.key, required this.id});

  @override
  State<MovieDetailBooking> createState() => _MovieDetailBookingState();
}

class _MovieDetailBookingState extends State<MovieDetailBooking> {
  int? cinemaSelected;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(BlocGetMovieDetai(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailSuccess) {
            final movie = state.movieDetail;
            final actors = state.actor;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
                          width: double.infinity,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: BackNav(
                            text: '',
                            isBgIcon: true,
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                        Positioned(
                          top: 160,
                          left: 16,
                          right: 16,
                          child: _MovieCard(
                            title: movie.title,
                            runtime: movie.runtime,
                            vote: movie.voteAverage,
                            voteCount: movie.voteCount,
                            date: movie.releaseDate,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        _MovieDetailSection(
                          genre: movie.genres.map((e) => e).join(', '),
                          censorship: 'PG-13',
                          language: movie.language,
                          storyline: movie.overview,
                        ),
                        const SizedBox(height: 20),
                        _ActorSection(
                          actors: actors,
                        ),
                        const SizedBox(height: 20),
                        _PickCinema(
                          listCinema: listCinema,
                          onItemTapped: (i) {
                            setState(() {
                              cinemaSelected = cinemaSelected == i ? null : i;
                            });
                          },
                          selectedIndex: cinemaSelected,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
