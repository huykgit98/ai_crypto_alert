import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    super.key,
    this.onTap,
    this.gradientColors,
    this.buttonSize = MoonButtonSize.lg,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.fixedWidth,
  });
  final Widget label;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;
  final MoonButtonSize buttonSize;
  final bool isFullWidth;
  final bool showPulseEffect;
  final double? fixedWidth;
  @override
  Widget build(BuildContext context) {
    return MoonFilledButton(
      isFullWidth: isFullWidth,
      buttonSize: buttonSize,
      width: fixedWidth,
      onTap: onTap,
      label: label,
      showPulseEffect: showPulseEffect,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors ??
              [
                context.moonColors?.jiren ?? Colors.green,
                context.moonColors?.bulma ?? Colors.green,
              ],
        ),
        borderRadius:
            BorderRadius.circular(buttonSize == MoonButtonSize.sm ? 8 : 16),
      ),
    );
  }
}
