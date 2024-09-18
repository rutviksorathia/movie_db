import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({super.key});

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
  @override
  void onViewModelReady(SearchViewModel viewModel) {
    viewModel.fetchSearchMovieList();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(
            left: 18, right: 18, top: MediaQuery.of(context).padding.top + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: TextField(
                controller: viewModel.searchTextController,
                onChanged: (value) {
                  viewModel.notifyListeners();
                },
                style: TextStyle(color: Colors.grey.shade800),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  suffixIcon: IconButton(
                    onPressed: () => {
                      viewModel.searchTextController.clear(),
                      viewModel.notifyListeners(),
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (viewModel.searchMovies.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  controller: viewModel.searchScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...viewModel.searchMovies.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () =>
                                viewModel.handleMovieDetailsViewButtonTap(e),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      e.releaseDate.year.toString(),
                                    )
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
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    "Write something to search",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
