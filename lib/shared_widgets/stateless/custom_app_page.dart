import 'package:flutter/material.dart';

class CustomAppPage extends StatelessWidget {
  const CustomAppPage({
    super.key,
    required Widget child,
    bool clearSnackBarOnLaunch = false,
    bool safeTop = false,
    bool safeBottom = true,
    bool safeLeft = false,
    bool safeRight = false,
    Gradient? gradient,
    Color? backgroundColor,
    double? height,
    double? width,
  }) : _child = child,
       _clearSnackBarOnLaunch = clearSnackBarOnLaunch,
       _safeTop = safeTop,
       _safeBottom = safeBottom,
       _safeLeft = safeLeft,
       _safeRight = safeRight,
       _gradient = gradient,
       _backgroundColor = backgroundColor;
  final Widget _child;
  final bool _clearSnackBarOnLaunch;
  final bool _safeTop;
  final bool _safeBottom;
  final bool _safeLeft;
  final bool _safeRight;
  final Gradient? _gradient;
  final Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (_clearSnackBarOnLaunch) _clearAnySnackBarFromPreviousPage(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: _gradient,
        color: _backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        top: _safeTop,
        left: _safeLeft,
        right: _safeRight,
        bottom: _safeBottom,
        child: _child,
      ),
    );
  }

  void _clearAnySnackBarFromPreviousPage(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
  }
}
