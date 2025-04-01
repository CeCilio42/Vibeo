class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final posterPath = json['poster_path'] as String?;
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: posterPath ?? '',
    );
  }

  String get fullPosterPath {
    if (posterPath.isEmpty || !posterPath.startsWith('/')) {
      return 'https://via.placeholder.com/500x750?text=No+Image';
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
