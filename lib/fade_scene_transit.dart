import 'package:flutter/material.dart';

class FadeSceneTransition extends StatelessWidget {
  final Widget child;
  final bool visible;

  const FadeSceneTransition(
      {super.key, required this.child, required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(milliseconds: 1800),
      curve: Curves.easeInOutCubic,
      child: child,
    );
  }
}
