import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/movie_category.dart';

class CategoryIndexCubit extends Cubit<MovieCategory> {
  CategoryIndexCubit() : super(MovieCategory.nowPlaying);

  void setCategory(MovieCategory category) => emit(category);
}
