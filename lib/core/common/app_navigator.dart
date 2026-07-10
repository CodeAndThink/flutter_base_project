import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseNavigator {
  final BuildContext context;

  BaseNavigator({required this.context});

  Future<T?> pushNamed<T>(String name, {Object? arguments}) async {
    return context.pushNamed<T>(name, extra: arguments);
  }

  Future<T?> push<T>(String location, {Object? arguments}) async {
    return context.push<T>(location, extra: arguments);
  }

  void replaceNamed(String routeName, {Object? arguments}) async {
    context.replaceNamed(routeName, extra: arguments);
  }

  void goNamed(String routeName, {Object? arguments}) {
    context.goNamed(routeName, extra: arguments);
  }

  void go(String location, {Object? arguments}) {
    context.go(location, extra: arguments);
  }

  void replace(String routeName, {Object? arguments}) {
    context.replace(routeName, extra: arguments);
  }

  void pop() {
    context.pop();
  }
}
