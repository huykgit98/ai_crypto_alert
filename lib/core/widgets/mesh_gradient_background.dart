import 'package:flutter/material.dart';

class MeshGradientBackground extends StatefulWidget {
  const MeshGradientBackground({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<MeshGradientBackground> createState() =>
      _AnimatedMeshGradientBackgroundState();
}

class _AnimatedMeshGradientBackgroundState extends State<MeshGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Color?>> _colorAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    final colors = [
      [Colors.red, Colors.purple],
      [Colors.blue, Colors.orange],
      [Colors.green, Colors.pink],
      [Colors.yellow, Colors.cyan],
    ];

    _colorAnimations = colors
        .map((colorPair) =>
            _createColorTweenAnimation(colorPair[0], colorPair[1]))
        .toList();
  }

  Animation<Color?> _createColorTweenAnimation(Color begin, Color end) {
    return ColorTween(begin: begin, end: end).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _colorAnimations
                          .map((animation) => animation.value!)
                          .toList(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            widget.child,
          ],
        );
      },
    );
  }
}
