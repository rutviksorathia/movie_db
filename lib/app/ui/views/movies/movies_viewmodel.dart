import 'package:flutter/material.dart';
import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

class MoviesViewModel extends BaseViewModel {
  MoviesViewModel() {
    nowPlayingScrollController.addListener(handleNowPlayingScrollView);
    upcomingScrollController.addListener(handleUpcomingScrollView);
    topRelatedScrollController.addListener(handleTopRelatedScrollView);
  }
  //  Now Playing

  ScrollController nowPlayingScrollController = ScrollController();
  List<Movie> nowPlayingMovies = [];
  int nowPlayingMoviePage = 1;
  bool isNowPlayingScrollEventDispatched = false;

  void handleNowPlayingScrollView() {
    if (nowPlayingScrollController.position.extentAfter <= 200) {
      if (!isNowPlayingScrollEventDispatched) {
        handleNowPlayingMovieListScrollEnd();
        isNowPlayingScrollEventDispatched = true;
      }
    } else {
      isNowPlayingScrollEventDispatched = false;
    }
  }

  Future<void> handleNowPlayingMovieListScrollEnd() async {
    nowPlayingMoviePage++;
    await fetchMovieList(isPaginated: true);
  }

  Future<void> fetchMovieList({bool isPaginated = false}) async {
    if (!isPaginated) nowPlayingMoviePage = 1;

    setBusyForObject(fetchMovieList, true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response = await apiNowPlayingMovieListV1(
          query:
              ApiNowPlayingMovieListV1RequestQuery(page: nowPlayingMoviePage));

      if (isPaginated) {
        nowPlayingMovies.addAll(response.results);
      } else {
        nowPlayingMovies = response.results;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchMovieList, false);
    }
  }

  // Upcoming Movies

  ScrollController upcomingScrollController = ScrollController();
  List<Movie> upcomingMovies = [];
  int upComingMoviePage = 1;
  bool isUpcomingScrollEventDispatched = false;

  void handleUpcomingScrollView() {
    if (upcomingScrollController.position.extentAfter <= 200) {
      if (!isUpcomingScrollEventDispatched) {
        handleUpcomingMovieListScrollEnd();
        isUpcomingScrollEventDispatched = true;
      }
    } else {
      isUpcomingScrollEventDispatched = false;
    }
  }

  Future<void> handleUpcomingMovieListScrollEnd() async {
    upComingMoviePage++;
    await fetchMovieList(isPaginated: true);
  }

  Future<void> fetchUpComingMovieList({bool isPaginated = false}) async {
    if (!isPaginated) upComingMoviePage = 1;

    setBusyForObject(fetchUpComingMovieList, true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response = await apiUpcomingMovieListV1(
          query: ApiUpcomingMovieListV1RequestQuery(page: upComingMoviePage));

      if (isPaginated) {
        upcomingMovies.addAll(response.results);
      } else {
        upcomingMovies = response.results;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchUpComingMovieList, false);
    }
  }

  // Top Related

  ScrollController topRelatedScrollController = ScrollController();
  List<Movie> topRelatedMovies = [];
  int topRelatedMoviePage = 1;
  bool isTopRelatedScrollEventDispatched = false;

  void handleTopRelatedScrollView() {
    if (topRelatedScrollController.position.extentAfter <= 200) {
      if (!isTopRelatedScrollEventDispatched) {
        handleTopRelatedMovieListScrollEnd();
        isTopRelatedScrollEventDispatched = true;
      }
    } else {
      isTopRelatedScrollEventDispatched = false;
    }
  }

  Future<void> handleTopRelatedMovieListScrollEnd() async {
    topRelatedMoviePage++;
    await fetchUpTopRelatedMovieList(isPaginated: true);
  }

  Future<void> fetchUpTopRelatedMovieList({bool isPaginated = false}) async {
    if (!isPaginated) topRelatedMoviePage = 1;

    setBusyForObject(handleTopRelatedMovieListScrollEnd, true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response = await apiTopRatedMovieListV1(
          query: ApiTopRatedMovieListV1RequestQuery(page: topRelatedMoviePage));

      if (isPaginated) {
        topRelatedMovies.addAll(response.results);
      } else {
        topRelatedMovies = response.results;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(handleTopRelatedMovieListScrollEnd, false);
    }
  }
}
