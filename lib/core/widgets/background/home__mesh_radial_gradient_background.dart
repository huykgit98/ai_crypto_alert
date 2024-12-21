import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeMeshRadialGradientBackground extends StatelessWidget {
  const HomeMeshRadialGradientBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildGradientContainer(context.topLeftRadialGradient),
        _buildGradientContainer(context.topCenterRadialGradient),
        _buildGradientContainer(context.topRightRadialGradient),
        _buildGradientContainer(context.centerRightRadialGradient),
        _buildGradientContainer(context.bottomCenterRadialGradient),
        child,
      ],
    );
  }

  Widget _buildGradientContainer(Gradient gradient) {
    return Container(decoration: BoxDecoration(gradient: gradient));
  }
}
