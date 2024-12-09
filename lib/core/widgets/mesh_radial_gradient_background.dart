import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';

class MeshRadialGradientBackground extends StatelessWidget {
  const MeshRadialGradientBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildGradientContainer(context.topLeftRadialGradient),
        _buildGradientContainer(context.bottomRightRadialGradient),
        _buildGradientContainer(context.topCenterRadialGradient),
        _buildGradientContainer(context.topRightRadialGradient),
        child,
      ],
    );
  }

  Widget _buildGradientContainer(Gradient gradient) {
    return Container(decoration: BoxDecoration(gradient: gradient));
  }
}
