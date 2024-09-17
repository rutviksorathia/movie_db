import 'package:flutter/material.dart';
import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

class MoviesViewModel extends BaseViewModel {
  ScrollController scrollController = ScrollController();
  List<Movie> movies = [];

  MoviesViewModel() {
    scrollController.addListener(handleProfilesScrollView);
  }

  int profilePage = 1;
  bool isScrollEventDispatched = false;

  void handleProfilesScrollView() {
    if (scrollController.position.extentAfter <= 200) {
      if (!isScrollEventDispatched) {
        handleProfileListScrollEnd();
        isScrollEventDispatched = true;
      }
    } else {
      isScrollEventDispatched = false;
    }
  }

  Future<void> handleProfileListScrollEnd() async {
    print(profilePage);
    profilePage++;
    await fetchMovieList(isPaginated: true);
  }

  Future<void> fetchMovieList({bool isPaginated = false}) async {
    if (!isPaginated) profilePage = 1;

    setBusyForObject(fetchMovieList, true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response = await apiNowPlayingMovieListV1(
          query: ApiNowPlayingMovieListV1RequestQuery(page: profilePage));

      movies.addAll(response.results);

      if (isPaginated) {
        movies.addAll(response.results);
      } else {
        movies = response.results;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchMovieList, false);
    }
  }
}
