import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_category.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/capital.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/main/pages/main_page.dart';
import 'package:mbooking/features/movie/presentation/blocs/cubit/category_index_cubit.dart';
import 'package:mbooking/features/movie/presentation/pages/movie_detail_booking/movie_detail_booking.dart';

import '../../../../../core/utils/get_genre_names.dart';
import '../../../../../core/utils/rand_int.dart';
import '../../../../auth/presentation/blocs/user/user_bloc.dart';
import '../../../../booking/presentation/cubit/booking_cubit.dart';
import '../../../domain/entities/movie.dart';
import '../../blocs/movie/movies_bloc.dart';
import '../../widgets/movie_slider_card.dart';
import '../../widgets/title_section.dart';
import '../../widgets/upcoming_card.dart';

part 'section/user_section.dart';
part 'section/now_playing_slider.dart';
part 'section/coming_soon_section.dart';
part 'section/promo_section.dart';
part 'section/service_section.dart';
part 'section/movie_news_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];
  String searchQuery = '';

  void _filterMovies(String query) {
    final filtered = movies.where((movie) {
      final nameLower = movie.title.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
    setState(() {
      searchQuery = query;
      filteredMovies = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<MoviesBloc>()
              .add(BlocGetMovies(page: generateRandomInt(5)));
        },
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesSuccess) {
              movies = [...state.nowPlayingMovies, ...state.upcomingMovies];
              if (filteredMovies.isEmpty && searchQuery.isEmpty) {
                filteredMovies = movies;
              }
            }

            return SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  const _UserSection(),
                  const SizedBox(height: 16),
                  TextFormField(
                    onChanged: _filterMovies,
                    style: const TextStyle(color: AppColors.white),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      prefixIcon: Icon(Icons.search, color: AppColors.gray),
                      hintText: 'Search',
                      fillColor: AppColors.enabled,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (searchQuery.isNotEmpty) ...[
                    if (filteredMovies.isEmpty) ...[
                      const Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(color: AppColors.white),
                        ),
                      )
                    ] else ...[
                      Container(
                        height:
                            ((filteredMovies.length / 2).ceil() * 300) + 150,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final crossAxisCount = width > 600 ? 3 : 2;
                            final aspectRatio = width / crossAxisCount / 320;
                            return GridView.count(
                              crossAxisCount: crossAxisCount,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: aspectRatio,
                              crossAxisSpacing: 16,
                              children: filteredMovies
                                  .map((movie) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MovieDetailBooking.route(movie.id),
                                          );
                                        },
                                        child: SizedBox(
                                          width: 170,
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                  width: 170,
                                                  height: 240,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: 165,
                                                child: Text(
                                                  movie.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ]
                  ] else ...[
                    const _NowPlayingSlider(),
                    const SizedBox(height: 16),
                    const _ComingSoonSection(),
                    const SizedBox(height: 16),
                    const _PromoSection(),
                    const SizedBox(height: 16),
                    const _ServiceSection(),
                    const SizedBox(height: 16),
                    const _MovieNewsSection(),
                    const SizedBox(height: 20),
                  ],
                ]),
              ),
            ));
          },
        ),
      ),
    );
  }
}
