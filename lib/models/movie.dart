class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String? mood;
  final String overview;
  final String? backdropPath;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.mood,
    this.overview = '',
    this.backdropPath,
    this.voteAverage = 0.0,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final posterPath = json['poster_path'] as String?;
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: posterPath ?? '',
      mood: json['mood'] as String?,
      overview: json['overview'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  String get fullPosterPath {
    if (posterPath.isEmpty || !posterPath.startsWith('/')) {
      return 'https://via.placeholder.com/500x750?text=No+Image';
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String get fullBackdropPath {
    if (backdropPath == null || backdropPath!.isEmpty) {
      return 'https://via.placeholder.com/1280x720?text=No+Backdrop';
    }
    return 'https://image.tmdb.org/t/p/w1280$backdropPath';
  }
}
