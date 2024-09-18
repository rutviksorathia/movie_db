import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movie_db/app/ui/views/movie_details/movie_details_view.dart';
import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  TextEditingController searchTextController = TextEditingController();
  Timer? _debounce;

  SearchViewModel() {
    searchTextController.addListener(onBusinessSearchTextChange);
    searchScrollController.addListener(handleTopRelatedScrollView);
  }

  ScrollController searchScrollController = ScrollController();
  List<Movie> searchMovies = [];
  int searchMoviePage = 1;
  bool isSearchScrollEventDispatched = false;
  String movieSearchText = '';

  Future<void> onBusinessSearchTextChange() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      searchMoviePage = 1;

      movieSearchText = searchTextController.text;

      await fetchSearchMovieList();
    });
  }

  void handleTopRelatedScrollView() {
    if (searchScrollController.position.extentAfter <= 200) {
      if (!isSearchScrollEventDispatched) {
        handleSearchMovieListScrollEnd();
        isSearchScrollEventDispatched = true;
      }
    } else {
      isSearchScrollEventDispatched = false;
    }
  }

  Future<void> handleSearchMovieListScrollEnd() async {
    searchMoviePage++;
    await fetchSearchMovieList(isPaginated: true);
  }

  Future<void> fetchSearchMovieList({bool isPaginated = false}) async {
    if (!isPaginated) searchMoviePage = 1;

    setBusyForObject(fetchSearchMovieList, true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response = await apiMovieSearchV1(
        query: ApiMovieSearchListV1RequestQuery(
          page: searchMoviePage,
          query: movieSearchText,
        ),
      );
      if (isPaginated) {
        searchMovies.addAll(response.results);
      } else {
        searchMovies = response.results;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchSearchMovieList, false);
    }
  }

  void handleMovieDetailsViewButtonTap(Movie movie) {
    Get.to(() => MovieDetailsView(movie: movie));
  }
}
