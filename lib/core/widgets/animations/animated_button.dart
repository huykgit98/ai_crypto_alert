import 'package:ai_crypto_alert/core/widgets/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    required this.label,
    required this.onTap,
    required this.delay,
    this.gradientColors,
    this.borderColor,
    super.key,
  });
  final String label;
  final VoidCallback? onTap;
  final int delay;
  final List<Color>? gradientColors;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 300.ms, delay: delay.ms),
        ScaleEffect(
          duration: 300.ms,
          delay: delay.ms,
          begin: const Offset(0.8, 0.8),
        ),
      ],
      child: gradientColors != null
          ? PrimaryButton(
              onTap: onTap,
              label: Text(
                label,
                style: TextStyle(color: context.moonColors!.goku),
              ),
              gradientColors: gradientColors,
              isFullWidth: true,
            )
          : MoonOutlinedButton(
              buttonSize: MoonButtonSize.lg,
              borderColor: borderColor ?? context.moonColors!.bulma,
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              label: Text(
                label,
                style: TextStyle(color: context.moonColors!.bulma),
              ),
              isFullWidth: true,
            ),
    );
  }
}
