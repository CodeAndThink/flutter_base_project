import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigator/app_router.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/widgets/images/app_network_image.dart';
import '../../../../core/widgets/scaffold/app_scaffold.dart';
import '../cubit/home_movie_cubit.dart';
import '../cubit/home_movie_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeMovieCubit>()..fetchPopularMovies(),
      child: AppScaffold(
        title: 'Popular Movies',
        body: BlocBuilder<HomeMovieCubit, HomeMovieState>(
          builder: (context, state) {
            if (state is HomeMovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeMovieError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is HomeMovieLoaded) {
              final movies = state.movies;
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        AppRouter.movieDetailName,
                        pathParameters: {'id': movie.id.toString()},
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: AppNetworkImage(
                              imagePath: movie.posterPath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
