import 'package:ai_crypto_alert/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class AlertNotification {
  AlertNotification._();

  static show(
    BuildContext context, {
    required String title,
    required AlertVariant variant,
    Widget? content,
    Duration? displayDuration,
  }) {
    final foregroundColor = switch (variant) {
      AlertVariant.success => Colors.white,
      AlertVariant.error => Colors.white,
      AlertVariant.warning => Colors.white,
      _ => Colors.transparent,
    };

    final backgroundColor = switch (variant) {
      AlertVariant.success => context.moonColors?.frieza,
      AlertVariant.error => context.moonColors?.chichi,
      AlertVariant.warning => context.moonColors?.krillin,
      _ => Colors.transparent,
    };

    final alertIcon = switch (variant) {
      AlertVariant.success => MoonIcons.generic_check_rounded_24_regular,
      AlertVariant.error => MoonIcons.generic_alarm_round_24_regular,
      AlertVariant.warning => MoonIcons.generic_alarm_24_regular,
      _ => MoonIcons.arrows_left_short_16_regular,
    };

    final double width = context.responsiveWhen(400, sm: double.maxFinite);
    final Alignment alignment =
        context.responsiveWhen(Alignment.topRight, sm: Alignment.topCenter);

    return MoonToast.show(
      context,
      content: content,
      width: width,
      backgroundColor: backgroundColor,
      toastAlignment: alignment,
      displayDuration: displayDuration,
      leading: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: MoonSquircleBorderRadius(cornerRadius: 8),
        ),
        child: Icon(
          alertIcon,
          color: foregroundColor,
        ),
      ),
      label: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      trailing: const MoonButton.icon(
        buttonSize: MoonButtonSize.sm,
        icon:
            Icon(MoonIcons.controls_close_small_16_light, color: Colors.white),
        onTap: MoonToast.clearToastQueue,
      ),
      toastShadows: context.moonShadows?.sm,
    );
  }
}

enum AlertVariant { success, error, warning, info }
