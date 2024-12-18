import 'dart:math' as math;

import 'package:flutter/material.dart';

class CoolMode extends StatefulWidget {
  const CoolMode({
    super.key,
    required this.child,
    this.particleCount = 45,
    this.speedHorz,
    this.speedUp,
  });

  final Widget child;
  final int particleCount;
  final double? speedHorz;
  final double? speedUp;

  @override
  State<CoolMode> createState() => _CoolModeState();
}

class _CoolModeState extends State<CoolMode> with TickerProviderStateMixin {
  final List<Particle> _particles = [];
  final math.Random _random = math.Random();
  bool _isPointerDown = false;
  late AnimationController _animationController;
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _animationController.addListener(_updateParticles);
  }

  Offset _getWidgetPosition() {
    final RenderBox? renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? paintBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null || paintBox == null) return Offset.zero;

    // Get the global position of the button
    final Offset globalPosition = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // Convert global coordinates back to local coordinates relative to the CustomPaint
    final Offset localPosition = paintBox.globalToLocal(globalPosition);

    return Offset(
      localPosition.dx + size.width / 2,
      localPosition.dy + size.width / 4, // Start from top of the button
    );
  }

  void _updateParticles() {
    if (_isPointerDown && _particles.length < widget.particleCount) {
      _addParticle();
    }

    for (int i = _particles.length - 1; i >= 0; i--) {
      _particles[i].update();

      // Remove particles that go off screen
      if (_particles[i].position.dy < -_particles[i].size ||
          _particles[i].position.dy >
              MediaQuery.of(context).size.height + _particles[i].size) {
        _particles.removeAt(i);
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _addParticle() {
    final List<double> sizes = [15, 18, 21, 23, 26];
    final size = sizes[_random.nextInt(sizes.length)];
    final speedHorz = widget.speedHorz ?? _random.nextDouble() * 10;
    final speedUp = widget.speedUp ?? (_random.nextDouble() * 25);

    final spinVal = _random.nextDouble() * 0;

    final spinSpeed = _random.nextDouble() * 35 * (_random.nextBool() ? -1 : 1);
    final direction = _random.nextBool() ? -1 : 1;

    final widgetPosition = _getWidgetPosition();

    _particles.add(
      Particle(
        position: widgetPosition,
        size: size,
        direction: direction.toDouble(),
        speedHorz: speedHorz,
        speedUp: speedUp,
        spinSpeed: spinSpeed,
        spinVal: spinVal,
        color: HSLColor.fromAHSL(
          1.0,
          _random.nextDouble() * 360,
          0.7,
          0.5,
        ).toColor(),
        type: _random.nextBool()
            ? ParticleType.text
            : ParticleType.icon, // Random type
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // This ensures particles are painted behind the button
        if (_particles.isNotEmpty)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: CustomPaint(
                painter: ParticlePainter(particles: _particles),
              ),
            ),
          ),

        // GestureDetector handles only the button, not the entire area
        Center(
          child: GestureDetector(
            behavior:
                HitTestBehavior.opaque, // Ensures only button region reacts
            onTapDown: (_) {
              setState(() {
                _isPointerDown = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isPointerDown = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _isPointerDown = false;
              });
            },
            child: KeyedSubtree(
              key: _childKey,
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}

enum ParticleType { text, icon }

class Particle {
  Particle({
    required this.position,
    required this.size,
    required this.direction,
    required this.speedHorz,
    required this.speedUp,
    required this.spinSpeed,
    required this.spinVal,
    required this.color,
    this.type = ParticleType.text, // Default to text
  });

  Offset position;
  double size;
  double direction;
  double speedHorz;
  double speedUp;
  double spinSpeed;
  double spinVal;
  Color color;
  ParticleType type;

  void update() {
    position = Offset(
      position.dx - speedHorz * direction,
      position.dy - speedUp,
    );
    speedUp = math.min(size, speedUp - 0.1);
    spinVal += spinSpeed;
  }
}

class ParticlePainter extends CustomPainter {
  ParticlePainter({
    required this.particles,
  });

  final List<Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      canvas.save();
      canvas.translate(particle.position.dx, particle.position.dy);
      canvas.rotate(particle.spinVal * math.pi / 180);

      if (particle.type == ParticleType.text) {
        // Render Dollar Sign as Text
        final textPainter = TextPainter(
          text: TextSpan(
            text: '💰',
            style: TextStyle(
              fontSize: particle.size,
              color: particle.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );
      } else if (particle.type == ParticleType.icon) {
        // Render Dollar Icon
        final iconPainter = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(Icons.monetization_on_sharp.codePoint),
            style: TextStyle(
              fontSize: particle.size,
              color: particle.color,
              fontFamily: Icons.attach_money.fontFamily,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        iconPainter.layout();
        iconPainter.paint(
          canvas,
          Offset(-iconPainter.width / 2, -iconPainter.height / 2),
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
