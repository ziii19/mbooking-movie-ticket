enum MovieCategory { nowPlaying, upcoming }

extension MovieCategoryExtension on MovieCategory {
  String get category {
    switch (this) {
      case MovieCategory.nowPlaying:
        return 'now_playing';
      case MovieCategory.upcoming:
        return 'upcoming';
    }
  }

  String get title {
    switch (this) {
      case MovieCategory.nowPlaying:
        return 'Now playing';
      case MovieCategory.upcoming:
        return 'Cooming soon';
    }
  }
}
