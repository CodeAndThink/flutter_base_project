import 'package:flutter_base_project/core/common/app_navigator.dart';
import 'package:flutter_base_project/router/app_router.dart';
import 'package:flutter_base_project/ui/pages/detail/page/movie_detail_page.dart';
import 'package:go_router/go_router.dart';

class HomeNavigator extends BaseNavigator {
  HomeNavigator({required super.context});

  void openMovieDetail({required MovieDetailArgument args}) {
    context.goNamed(AppRouter.movieDetailName, extra: args);
  }
}
