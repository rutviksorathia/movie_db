import 'dart:ffi';

import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

class MovieDetailsViewModel extends BaseViewModel {
  Movie movie;

  List<int> count = [1, 2, 3, 4, 5];

  MovieDetailsViewModel({required this.movie});

  Future<void> fetchMovieById() async {
    try {
      movie = await apiMovieGetByIdV1(
        movieId: movie.id,
        query: ApiMovieGetByIdV1RequestQuery(),
      );

      notifyListeners();
    } finally {}
  }
}
