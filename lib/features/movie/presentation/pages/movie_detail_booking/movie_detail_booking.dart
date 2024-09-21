import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/constants/cinema.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/core/utils/number_format.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/auth/presentation/blocs/user/user_bloc.dart';
import 'package:mbooking/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:mbooking/features/booking/presentation/pages/booking/booking_page.dart';
import 'package:mbooking/features/movie/domain/entities/actor.dart';
import 'package:mbooking/features/movie/domain/entities/movie_detail.dart';
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
  MovieDetail? _movieDetail;
  List<Actor>? _actors;
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
            _movieDetail = state.movieDetail;
            _actors = state.actor;
          } else if (state is MovieDetailError) {
            return Text(state.error);
          } else if (state is MovieDetailLoading ||
              state is MovieDetailInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      _movieDetail?.backdropPath != null
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500/${_movieDetail!.backdropPath}',
                              width: double.infinity,
                              height: 240,
                              fit: BoxFit.cover,
                            )
                          : Container(),
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
                          title: _movieDetail?.title ?? '',
                          runtime: _movieDetail?.runtime ?? 0,
                          vote: _movieDetail?.voteAverage ?? 0.0,
                          voteCount: _movieDetail?.voteCount ?? 0,
                          date: _movieDetail?.releaseDate ?? '',
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
                        genre:
                            _movieDetail?.genres.map((e) => e).join(', ') ?? '',
                        censorship: 'PG-13',
                        language: _movieDetail?.language ?? '',
                        storyline: _movieDetail?.overview ?? '',
                      ),
                      const SizedBox(height: 20),
                      _ActorSection(
                        actors: _actors ?? [],
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
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0)
            .copyWith(top: 6.0, bottom: 16),
        child: ElevatedButton(
          onPressed: () {
            if (cinemaSelected == null) {
              showSnackBar(context, 'Please pick a cinema');
              return;
            }
            final user = context.read<UserBloc>().state as UserSuccess;
            context.read<BookingCubit>().updateState(
                  cinema: cinemaSelected!,
                  price: listCinema[cinemaSelected!].price,
                  movieGenres: _movieDetail!.genres,
                  movieImage: _movieDetail!.posterPath,
                  movieRuntime: _movieDetail!.runtime,
                  movieTitle: _movieDetail!.title,
                  uid: user.user.uid,
                );
            Navigator.push(context, BookingPage.route());
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
