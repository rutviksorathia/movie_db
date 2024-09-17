part of 'movie.dart';

class Movie {
  int id;
  String title;
  bool adult;
  String? backdropPath;
  String originalLanguage;
  String? posterPath;
  String originalTitle;
  String overview;
  double popularity;
  DateTime releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.id,
    required this.title,
    required this.adult,
    this.backdropPath,
    required this.originalLanguage,
    this.posterPath,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'].toString(),
      adult: map['adult'],
      backdropPath: map['backdrop_path']?.toString(),
      originalLanguage: map['original_language'].toString(),
      posterPath: map['poster_path']?.toString(),
      originalTitle: map['original_title'].toString(),
      overview: map['overview'].toString(),
      popularity: double.tryParse(map['popularity'].toString()) ?? 0,
      releaseDate: DateTime.parse(map['release_date']),
      video: map['video'],
      voteAverage: double.tryParse(map['vote_average'].toString()) ?? 0,
      voteCount: int.tryParse(map['vote_count'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'adult': adult,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'poster_path': posterPath,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
