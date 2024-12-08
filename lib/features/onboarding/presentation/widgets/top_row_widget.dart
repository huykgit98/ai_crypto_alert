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
    return Positioned(
      top: 0,
      right: 0,
      child: Row(
        children: [
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
            ),
          ),
          const SizedBox(width: 8),
          MoonButton.icon(
            buttonSize: MoonButtonSize.sm,
            onTap: isLoading ? null : onThemeTap,
            icon: const Icon(MingCute.brightness_line),
          ),
        ],
      ),
    );
  }
}
