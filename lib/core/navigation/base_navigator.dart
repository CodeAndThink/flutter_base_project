import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/extensions/num_extensions.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/notifications/app_flush_bar.dart';
import '../../presentation/widgets/dialogs/app_dialog.dart';

abstract class BaseNavigator {
  final BuildContext context;

  /// Access to application dialogs
  AppDialog get dialog => AppDialog(context);

  /// Access to application notifications/alerts
  AppFlushBar get flushBar => AppFlushBar(context);

  const BaseNavigator(this.context);

  void safePop([Object? result]) {
    if (context.canPop()) {
      context.pop(result);
    }
  }

  bool isCanPop() => context.canPop();

  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool showDragHandle = true,
    bool useSafeArea = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      builder: (_) => child,
    );
  }

  void go(String path, {Object? extra}) {
    context.go(path, extra: extra);
  }

  void goNamed(String name, {Object? extra}) {
    context.goNamed(name, extra: extra);
  }

  void push(String path, {Object? extra}) {
    context.push(path, extra: extra);
  }

  Future<Object?> pushNamed(String name, {Object? extra}) async {
    return await context.pushNamed(name, extra: extra);
  }

  void replace(String path, {Object? extra}) {
    context.replace(path, extra: extra);
  }

  void replaceNamed(String name, {Object? extra}) {
    context.replaceNamed(name, extra: extra);
  }
}

class _RiseUpTransition extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _RiseUpTransition({required this.child, required this.delay});

  @override
  State<_RiseUpTransition> createState() => _RiseUpTransitionState();
}

class _RiseUpTransitionState extends State<_RiseUpTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 600.milliseconds);

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
