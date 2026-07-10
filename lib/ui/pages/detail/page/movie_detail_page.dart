import 'package:flutter/material.dart';
import 'package:flutter_base_project/ui/pages/detail/navigator/movie_detail_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base_project/ui/widgets/appbars/custom_sliver_app_bar.dart';
import 'package:flutter_base_project/ui/widgets/scaffold/app_scaffold.dart';
import 'package:flutter_base_project/ui/pages/detail/cubit/movie_detail_cubit.dart';
import 'package:flutter_base_project/ui/pages/detail/cubit/movie_detail_state.dart';
import 'package:flutter_base_project/data/repositories/movie_repository.dart';

class MovieDetailArgument {
  final int movieId;
  const MovieDetailArgument({required this.movieId});
}

class MovieDetailPage extends StatelessWidget {
  final MovieDetailArgument args;

  const MovieDetailPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailCubit(
        repository: context.read<MovieRepository>(),
        navigator: MovieDetailNavigator(context: context),
      ),
      child: MovieDetailChildPage(args: args),
    );
  }
}

class MovieDetailChildPage extends StatefulWidget {
  final MovieDetailArgument args;

  const MovieDetailChildPage({super.key, required this.args});

  @override
  State<MovieDetailChildPage> createState() => _MovieDetailChildPageState();
}

class _MovieDetailChildPageState extends State<MovieDetailChildPage> {
  late final MovieDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MovieDetailCubit>();
    _cubit.fetchMovieDetails(widget.args.movieId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state.fetchMovieDetailsStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.fetchMovieDetailsStatus.isFailure) {
            return Center(child: Text('Error'));
          } else if (state.fetchMovieDetailsStatus.isSuccess) {
            final movie = state.movie;
            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: movie?.title ?? 'Unknown',
                  imagePath: (movie?.backdropPath?.isNotEmpty == true)
                      ? movie!.backdropPath!
                      : (movie?.posterPath ?? ''),
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
                              movie?.voteAverage?.toStringAsFixed(1) ?? '0.0',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Release: ${movie?.releaseDate ?? 'Unknown'}',
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
                          movie?.overview ?? 'No overview available.',
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
    );
  }
}
