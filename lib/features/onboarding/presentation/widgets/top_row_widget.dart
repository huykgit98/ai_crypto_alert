import 'package:ai_crypto_alert/core/enums/enums.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    required this.isLoading,
    required this.onLanguageTap,
    required this.onThemeTap,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onLanguageTap;
  final VoidCallback onThemeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Aligns items tightly
      mainAxisAlignment:
          MainAxisAlignment.end, // Right-align if placed in flexible layouts
      children: [
        // Language Button
        MoonButton(
          buttonSize: MoonButtonSize.sm,
          onTap: isLoading ? null : onLanguageTap,
          leading: Image.asset(
            context.l10n.localeName == LanguageCode.en.name
                ? Assets.icons.usFlag.path
                : Assets.icons.vnFlag.path,
            width: 24,
            height: 24,
          ),
          label: Text(
            context.l10n.localeName == LanguageCode.en.name
                ? context.l10n.english
                : context.l10n.vietnamese,
            style: context.moonTypography?.body.text14.copyWith(
              color: context.moonColors!.goten,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Theme Button
        MoonButton.icon(
          buttonSize: MoonButtonSize.sm,
          onTap: isLoading ? null : onThemeTap,
          icon: Icon(
            MingCute.brightness_line,
            color: context.moonColors!.goten,
          ),
        ),
      ],
    );
  }
}
