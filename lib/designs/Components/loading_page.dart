import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.color = Colors.black,
    this.size = 64.0,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/pokeball.png',
        color: color,
        width: size,
        height: size,
      )
          .animate()
          .fade(duration: 500.ms)
          .scale(duration: 500.ms)
          .rotate(duration: 1.seconds)
          .then(onPlay: (controller) => controller.repeat()),
    );
  }
}
