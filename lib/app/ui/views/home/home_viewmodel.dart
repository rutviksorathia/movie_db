import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

enum BottomTab {
  movies,
  search;

  String get content {
    switch (this) {
      case BottomTab.search:
        return "Search";
      default:
        return "Movies";
    }
  }
}

class HomeViewModel extends BaseViewModel {
  PageController pageController = PageController(initialPage: 0);

  BottomTab selectedTabBar = BottomTab.movies;

  void handleBottomTabButtonTap(BottomTab tabBar) {
    selectedTabBar = tabBar;
    pageController.animateToPage(
      tabBar == BottomTab.movies ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }
}
