import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

class MovieDetailsViewModel extends BaseViewModel {
  Movie movie;
  MovieCredit? credit;
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

  // Movie Credits

  Future<void> fetchMovieCredit() async {
    try {
      credit = await apiMovieCreditGetByIdV1(
        movieId: movie.id,
        query: ApiMovieCreditGetByIdV1RequestQuery(),
      );

      notifyListeners();
    } finally {}
  }
}
