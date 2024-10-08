part of '../home_page.dart';

class _ComingSoonSection extends StatelessWidget {
  const _ComingSoonSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
            title: 'Coming Soon',
            onPressed: () {
              context.read<NavIndexCubit>().setIndex(2);
              context
                  .read<CategoryIndexCubit>()
                  .setCategory(MovieCategory.upcoming);
              Navigator.push(context, MainPage.route());
            }),
        BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviesSuccess) {
              return SizedBox(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.upcomingMovies.length,
                  itemBuilder: (context, index) {
                    final movies = state.upcomingMovies[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: movies == state.upcomingMovies.last ? 0 : 16),
                      child: UpcomingCard(
                        posterUrl: movies.posterPath,
                        title: movies.title,
                        genre: getGenreNames(movies.genreIds)
                            .take(2)
                            .map((e) => e)
                            .join(', '),
                        release: movies.releaseDate,
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
