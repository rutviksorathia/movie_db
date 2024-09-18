import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movie_db/models/movie/movie.dart';
import 'package:stacked/stacked.dart';

import 'movie_details_viewmodel.dart';

class MovieDetailsView extends StackedView<MovieDetailsViewModel> {
  final Movie movie;
  const MovieDetailsView({
    super.key,
    required this.movie,
  });

  @override
  MovieDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MovieDetailsViewModel(movie: movie);

  @override
  void onViewModelReady(MovieDetailsViewModel viewModel) {
    viewModel.fetchMovieById();
    viewModel.fetchMovieCredit();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    MovieDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/${movie.backdropPath ?? movie.posterPath}",
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (viewModel.movie.genres.isNotEmpty)
                        Text(
                          viewModel.movie.genres.first.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(width: 12),
                      if (viewModel.movie.runtime != null)
                        Text(
                          "${viewModel.movie.runtime!.toString()} Minutes",
                        )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    viewModel.movie.overview,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ...viewModel.count.map((e) {
                        if (e < viewModel.movie.voteAverage / 2) {
                          return const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          );
                        }
                        return const Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                        );
                      }),
                      const SizedBox(width: 10),
                      Text(
                          '${viewModel.movie.voteAverage.toStringAsFixed(0)}/10')
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (viewModel.credit != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Starring",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ...viewModel.credit!.cast.map(
                                (e) => Text(
                                  e.name,
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...viewModel.credit!.crew.map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.job,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        e.name,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
