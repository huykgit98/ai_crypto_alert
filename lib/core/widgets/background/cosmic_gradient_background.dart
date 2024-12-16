import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CosmicGradientBackground extends StatelessWidget {
  const CosmicGradientBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CosmicBackgroundAnimation(),
        child,
      ],
    );
  }
}
