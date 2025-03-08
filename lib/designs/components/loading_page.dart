import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.color,
    this.size = 64.0,
  });

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _animatedPokeball(),
    );
  }

  Widget _animatedPokeball() {
    return Image.asset(
      'assets/images/pokeball.png',
      color: color ?? Colors.black,
      width: size,
      height: size,
    )
        .animate(
      onPlay: (controller) => controller.repeat(), // Start looping when animation plays
    )
        .fadeIn(duration: 500.ms)
        .scale(begin: const Offset(0.5, 0.5), duration: 500.ms)
        .rotate(delay: 500.ms, duration: 1.seconds, curve: Curves.easeInOut)
        .then(delay: 500.ms) // Add pause between rotations
        .fadeOut(duration: 500.ms)
        .scale(begin: const Offset(1.5, 1.5), duration: 500.ms);
  }
}