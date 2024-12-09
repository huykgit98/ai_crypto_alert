import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';

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
            gradient: context.topLeftRadialGradient,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: context.bottomRightRadialGradient,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: context.topCenterRadialGradient,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: context.topRightRadialGradient, // Using GradientUtils
          ),
        ),
        child,
      ],
    );
  }
}
