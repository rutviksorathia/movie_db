import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_db/app/ui/views/movies/movies_view.dart';
import 'package:movie_db/app/ui/views/search/search_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
              child: PageView(
            key: const PageStorageKey('profile_view'),
            restorationId: 'profile_view',
            controller: viewModel.pageController,
            onPageChanged: (value) {
              viewModel.selectedTabBar = BottomTab.values[value];
              viewModel.notifyListeners();
            },
            children: const [
              MoviesView(),
              SearchView(),
            ],
          )),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 26,
                sigmaY: 26,
              ),
              child: SizedBox(
                height: kBottomNavigationBarHeight + 30,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...BottomTab.values.map(
                      (e) => Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: InkWell(
                          onTap: () => viewModel.handleBottomTabButtonTap(e),
                          child: Container(
                            color: Colors.black12,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BottomTab.movies == e
                                      ? Icon(
                                          Icons.tv,
                                          color: viewModel.selectedTabBar == e
                                              ? Colors.blue
                                              : Colors.grey,
                                        )
                                      : Icon(
                                          Icons.search,
                                          color: viewModel.selectedTabBar == e
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                  Text(
                                    e.content,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: viewModel.selectedTabBar == e
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
