import 'package:flutter_base_project/core/navigation/base_navigator.dart';
import 'package:flutter_base_project/router/app_router.dart';
import 'package:flutter_base_project/presentation/features/detail/movie_detail_page.dart';
import 'package:go_router/go_router.dart';

class HomeNavigator extends BaseNavigator {
  HomeNavigator(super.context);

  void openMovieDetail({required MovieDetailArgument args}) {
    context.pushNamed(AppRouter.movieDetailName, extra: args);
  }
}
