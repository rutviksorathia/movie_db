import 'package:flutter/material.dart';
import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

class MoviesViewModel extends BaseViewModel {
  ScrollController scrollController = ScrollController();
  List<Movie> movies = [];
  int offset = 1;
  bool isMoreScroll = false;

  MoviesViewModel() {
    scrollController.addListener(loadMore);
  }

  void loadMore() {
    if (scrollController.position.pixels >
            scrollController.position.maxScrollExtent - 100 &&
        !isMoreScroll) {
      offset += 1;
      fetchMovieList(offset: offset);
      isMoreScroll = true;
      notifyListeners();
    }
  }

  Future<void> fetchMovieList({required int offset}) async {
    setBusyForObject(fetchMovieList, true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response =
          await apiMovieListV1(query: ApiMovieListV1RequestQuery(page: offset));

      movies.addAll(response.results);

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchMovieList, false);
    }
  }
}
