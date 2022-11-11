import 'package:flutter/material.dart';

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ColoredSafeArea({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        child: Container(
          // color: Theme.of(context).colorScheme.background,
          child: child,
        ),
      ),
    );
  }
}
