import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Align(
        alignment: Alignment.centerLeft,
        child: MoonButton.icon(
          icon: const Icon(MoonIcons.controls_close_small_16_light),
          buttonSize: MoonButtonSize.sm,
          backgroundColor: context.moonColors!.beerus,
          borderRadius: BorderRadius.circular(24),
          onTap: () => context.goNamed(AppRoute.onboarding.name),
        ),
      ),
    );
  }
}
