part of '../home_page.dart';

class _NowPlayingSlider extends StatefulWidget {
  const _NowPlayingSlider();

  @override
  State<_NowPlayingSlider> createState() => _NowPlayingSliderState();
}

class _NowPlayingSliderState extends State<_NowPlayingSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: 'Now Playing',
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 510,
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesSuccess) {
                final movies = state.nowPlayingMovies
                    .where((e) => e.voteAverage >= 7)
                    .toList();
                return Stack(
                  children: [
                    CarouselSlider(
                      items: movies
                          .map((movie) => MovieSliderCard(
                                id: movie.id,
                                posterUrl: movie.posterPath,
                                title: movie.title,
                                genre: getGenreNames(movie.genreIds)
                                    .take(3)
                                    .map((e) => e)
                                    .join(', '),
                                vote: movie.voteAverage.toStringAsFixed(1),
                                voteCount: movie.voteCount.toString(),
                              ))
                          .toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlayInterval: const Duration(seconds: 4),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1300),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        viewportFraction: 0.8,
                        // aspectRatio: 17 / 23,
                        height: 600,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayCurve: Curves.easeInOut, // Smooth transition
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 8.0,
                            width: movies.length * 10.0,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(top: 10),
                            height: 8.0,
                            width: 10.0,
                            transform: Matrix4.translationValues(
                                _current * 10.0, 0, 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.white
                                  : AppColors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
