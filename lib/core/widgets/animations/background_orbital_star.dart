import 'dart:math';

import 'package:flutter/material.dart';

class CosmicBackgroundAnimation extends StatelessWidget {
  const CosmicBackgroundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        BackgroundGradient(),
        ParticleEffect(),
        OrbitalPaths(),
        MovingStars(),
      ],
    );
  }
}

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, 1.5), // Centered horizontally, below the bottom
          radius: 1.2,
          colors: [
            Color(0xFF441260), // Deep purple
            Color(0xFF1A1040), // Mid purple
            Color(0xFF110B2B), // Dark purple
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
    );
  }
}

class ParticleEffect extends StatefulWidget {
  const ParticleEffect({super.key});

  @override
  State<ParticleEffect> createState() => _ParticleEffectState();
}

class _ParticleEffectState extends State<ParticleEffect>
    with TickerProviderStateMixin {
  late List<Particle> particles;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    particles = List.generate(30, (index) => Particle.random());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(particles, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Particle.random()
      : x = Random().nextDouble(),
        // Fixed positions in bottom third of screen
        y = 0.7 + (Random().nextDouble() * 0.3),
        brightness = Random().nextDouble() * 0.7 + 0.3,
        angle = Random().nextDouble() * 2 * pi,
        phaseOffset = Random().nextDouble() * 2 * pi,
        size = Random().nextDouble() * 2.0 + 0.5;
  double x;
  double y;
  double brightness;
  double angle; // For rotation
  double phaseOffset; // For individual timing
  double size;
}

class ParticlePainter extends CustomPainter {
  ParticlePainter(this.particles, this.animation);
  final List<Particle> particles;
  final double animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final particle in particles) {
      // Calculate current rotation angle
      final currentAngle =
          particle.angle + (animation * 2 * pi) + particle.phaseOffset;

      // Use angle to create shimmer effect
      final shimmerIntensity = (cos(currentAngle) + 1) / 2; // Normalized to 0-1

      // Calculate position with tiny circular movement
      const radius = 2.0;
      final x = particle.x + (cos(currentAngle) * radius / size.width);
      final y = particle.y + (sin(currentAngle) * radius / size.height);

      // Shimmer brightness varies with rotation
      final currentBrightness =
          particle.brightness * (0.3 + (shimmerIntensity * 0.7));

      // Draw main glow
      paint
        ..color = Colors.white.withValues(alpha: currentBrightness * 0.6)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          particle.size * (0.5 + shimmerIntensity),
        );

      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        particle.size * (1.0 + shimmerIntensity * 0.5),
        paint,
      );

      // Draw bright core when catching light
      if (shimmerIntensity > 0.7) {
        paint
          ..color = Colors.white.withValues(alpha: shimmerIntensity * 0.9)
          ..maskFilter = null;

        canvas.drawCircle(
          Offset(x * size.width, y * size.height),
          particle.size * 0.3,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

class OrbitalPaths extends StatelessWidget {
  const OrbitalPaths({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: OrbitalPathsPainter(),
      size: Size.infinite,
    );
  }
}

class OrbitalPathsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Adjust center point to be closer to bottom
    final center = Offset(size.width / 2, size.height + (size.height * 0.05));
    const numberOfPaths = 6;

    // Start with a much smaller initial radius
    for (var i = 0; i < numberOfPaths; i++) {
      // Exponential growth for radius to match the image pattern
      final radius = size.width * (0.3 + (i * i * 0.08));
      paint.color = Colors.purple[100]!.withValues(alpha: 0.15 - (i * 0.02));

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        pi, // Starting angle (180 degrees)
        pi, // Sweep angle (180 degrees)
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(OrbitalPathsPainter oldDelegate) => false;
}

class MovingStars extends StatefulWidget {
  const MovingStars({super.key});

  @override
  State<MovingStars> createState() => _MovingStarsState();
}

class _MovingStarsState extends State<MovingStars>
    with TickerProviderStateMixin {
  late List<StarController> starControllers;

  @override
  void initState() {
    super.initState();
    // Create multiple star controllers with different paths and speeds
    starControllers = List.generate(3, (index) {
      return StarController(
        controller: AnimationController(
          vsync: this,
          duration: Duration(
            seconds: 3 + Random().nextInt(4),
          ), // Random duration between 3-7 seconds
        ),
        pathIndex: index, // Each star follows a different orbital path
        brightness: 0.3 + Random().nextDouble() * 0.7, // Random brightness
      )..controller.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: starControllers.map((controller) {
        return AnimatedBuilder(
          animation: controller.controller,
          builder: (context, child) {
            return CustomPaint(
              painter: StarTrailPainter(
                animation: controller.controller.value,
                pathIndex: controller.pathIndex,
                brightness: controller.brightness,
              ),
              size: Size.infinite,
            );
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    for (final controller in starControllers) {
      controller.controller.dispose();
    }
    super.dispose();
  }
}

class StarController {
  StarController({
    required this.controller,
    required this.pathIndex,
    required this.brightness,
  });
  final AnimationController controller;
  final int pathIndex;
  final double brightness;
}

class StarTrailPainter extends CustomPainter {
  StarTrailPainter({
    required this.animation,
    required this.pathIndex,
    required this.brightness,
  });
  final double animation;
  final int pathIndex;
  final double brightness;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: brightness)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    // Calculate the path radius based on the star's assigned path
    final center = Offset(size.width / 2, size.height + (size.height * 0.05));
    // Match the orbital paths radius calculation
    final radius = size.width * (0.3 + (pathIndex * pathIndex * 0.08));

    // Calculate current position
    final angle = pi + (pi * animation);
    final x = center.dx + radius * cos(angle);
    final y = center.dy + radius * sin(angle);

    // Draw the main star
    canvas.drawCircle(Offset(x, y), 1.5, paint);

    // Draw the trail
    for (var i = 1; i <= 5; i++) {
      final trailAngle = angle - (i * 0.1);
      final trailX = center.dx + radius * cos(trailAngle);
      final trailY = center.dy + radius * sin(trailAngle);

      paint.color = Colors.white.withValues(alpha: brightness * (1 - i * 0.2));
      canvas.drawCircle(Offset(trailX, trailY), 1.0 - (i * 0.15), paint);
    }
  }

  @override
  bool shouldRepaint(StarTrailPainter oldDelegate) => true;
}
