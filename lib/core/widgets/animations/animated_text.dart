import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    required this.text,
    required this.style,
    required this.delay,
    super.key,
  });
  final String text;
  final TextStyle? style;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms, delay: delay.ms),
        ScaleEffect(
          duration: 500.ms,
          delay: delay.ms,
          begin: const Offset(0.8, 0.8),
        ),
      ],
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
