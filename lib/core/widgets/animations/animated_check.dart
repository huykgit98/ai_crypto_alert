import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedCheck extends StatelessWidget {
  const AnimatedCheck({
    required this.progress,
    required this.size,
    this.color,
    this.strokeWidth,
    super.key,
  });

  final Animation<double> progress;

  /// The size of the checkmark
  final double size;

  /// The primary color of the checkmark
  final Color? color;

  /// The width of the checkmark stroke
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomPaint(
      painter: AnimatedPathPainter(
        progress: progress,
        color: color ?? theme.primaryColor,
        strokeWidth: strokeWidth,
      ),
      size: Size.square(size),
    );
  }
}

class AnimatedPathPainter extends CustomPainter {
  AnimatedPathPainter({
    required this.progress,
    required this.color,
    this.strokeWidth,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final Color color;
  final double? strokeWidth;

  Path _createPath(Size size) {
    return Path()
      ..moveTo(0.27 * size.width, 0.54 * size.height)
      ..lineTo(0.42 * size.width, 0.69 * size.height)
      ..lineTo(0.75 * size.width, 0.35 * size.height);
  }

  Path _createAnimatedPath(Path originalPath, double animationValue) {
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);
    final currentLength = totalLength * animationValue;

    return _extractPathUntilLength(originalPath, currentLength);
  }

  Path _extractPathUntilLength(Path originalPath, double length) {
    var currentLength = 0.0;
    final path = Path();

    for (final metric in originalPath.computeMetrics()) {
      final nextLength = currentLength + metric.length;

      if (nextLength > length) {
        final remainingLength = length - currentLength;
        path.addPath(metric.extractPath(0, remainingLength), Offset.zero);
        break;
      } else {
        path.addPath(metric.extractPath(0, metric.length), Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationValue = progress.value;
    final animatedPath = _createAnimatedPath(_createPath(size), animationValue);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? size.width * 0.06;

    canvas.drawPath(animatedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
