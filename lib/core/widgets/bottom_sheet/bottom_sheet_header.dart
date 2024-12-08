import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    required this.title,
    required this.onClose,
    super.key,
  });
  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 4,
          width: 40,
          margin: const EdgeInsets.only(top: Sizes.p8),
          decoration: ShapeDecoration(
            color: context.moonColors!.textSecondary,
            shape: const StadiumBorder(),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              child: Text(
                title,
                style: MoonTypography.typography.heading.text16,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 32,
                height: 32,
                child: MoonButton.icon(
                  icon: const Icon(MoonIcons.controls_close_small_16_light),
                  buttonSize: MoonButtonSize.sm,
                  backgroundColor: context.moonColors!.beerus,
                  borderRadius: BorderRadius.circular(24),
                  onTap: onClose,
                ),
              ),
            ),
          ],
        ),
        Divider(height: 0, color: context.moonColors!.textSecondary),
      ],
    );
  }
}
