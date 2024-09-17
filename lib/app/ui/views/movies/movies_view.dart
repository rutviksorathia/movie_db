import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'movies_viewmodel.dart';

class MoviesView extends StackedView<MoviesViewModel> {
  const MoviesView({super.key});

  @override
  MoviesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MoviesViewModel();

  @override
  void onViewModelReady(MoviesViewModel viewModel) {
    viewModel.fetchMovieList();
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    MoviesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "The MovieDb",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      "Now Playing",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    controller: viewModel.scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...viewModel.movies.map(
                          (e) => Container(
                            height: 300,
                            margin: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500/${e.posterPath}",
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        viewModel.busy(viewModel.fetchMovieList)
                            ? Container(
                                height: 300,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.transparent,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      "Now Playing",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...viewModel.movies.map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 160,
                                  width: 250,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${e.posterPath}",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(e.title)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...viewModel.movies.map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 160,
                                  width: 250,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${e.posterPath}",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(e.title)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
