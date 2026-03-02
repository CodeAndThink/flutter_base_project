import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/widgets/appbars/custom_sliver_app_bar.dart';
import '../../../../core/widgets/scaffold/app_scaffold.dart';
import '../../detail/cubit/movie_detail_cubit.dart';
import '../../detail/cubit/movie_detail_state.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailCubit>()..fetchMovieDetails(movieId),
      child: AppScaffold(
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;
              return CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: movie.title,
                    imagePath: movie.backdropPath.isNotEmpty
                        ? movie.backdropPath
                        : movie.posterPath,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Release: ${movie.releaseDate}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.overview,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
