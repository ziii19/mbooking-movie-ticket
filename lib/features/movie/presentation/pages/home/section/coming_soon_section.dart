part of '../home_page.dart';

class _ComingSoonSection extends StatelessWidget {
  const _ComingSoonSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleSection(title: 'Coming Soon'),
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
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: UpcomingCard(
                        posterUrl: state.upcomingMovies[index].posterPath,
                        title: state.upcomingMovies[index].title,
                        genre: state.upcomingMovies[index].genreIds
                            .map((e) => e.toString())
                            .join(', '),
                        release: state.upcomingMovies[index]
                            .toString()
                            .substring(0, 4),
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
