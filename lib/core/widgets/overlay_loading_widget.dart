import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class OverlayLoadingWidget extends StatelessWidget {
  const OverlayLoadingWidget({
    super.key,
    this.size = 54.0,
    this.color,
  });
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        color: context.moonColors?.beerus.withValues(alpha: 0.5),
        child: Center(
          child: CustomProgressIndicator(size: size),
        ),
      ),
    );
  }
}
