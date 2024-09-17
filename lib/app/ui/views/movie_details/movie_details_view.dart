import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stacked/stacked.dart';

import 'movie_details_viewmodel.dart';

class MovieDetailsView extends StackedView<MovieDetailsViewModel> {
  const MovieDetailsView({super.key});

  @override
  MovieDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MovieDetailsViewModel();

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "The Avengers",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            color: Colors.amberAccent,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Science",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "dhjwebfuief behfif8ofb vf viehvow vjbvuihv bviuwhgew evbviwefwv ekvifofwv wviqhvoq  vewevoqg",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 14),
                    Text('7/10')
                  ],
                ),
                const SizedBox(height: 10),
                Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
