import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class MeshRadialGradientBackground extends StatelessWidget {
  const MeshRadialGradientBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.9,
              center: Alignment.topLeft,
              colors: [
                context.moonColors!.dodoria10,
                context.moonColors!.dodoria10,
                context.moonColors!.dodoria10,
                context.moonColors!.goku.withOpacity(0),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.8,
              center: Alignment.bottomRight,
              colors: [
                context.moonColors!.frieza60,
                context.moonColors!.goku.withOpacity(0),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.8,
              center: Alignment.topCenter,
              colors: [
                context.moonColors!.dodoria10,
                context.moonColors!.goku.withOpacity(0),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.8,
              center: Alignment.topRight,
              colors: [
                context.moonColors!.cell10,
                context.moonColors!.cell10,
                context.moonColors!.goku.withOpacity(0),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
