import 'package:ai_crypto_alert/core/enums/enums.dart';
import 'package:ai_crypto_alert/core/providers/providers.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class LanguageSettingSheet extends ConsumerWidget {
  const LanguageSettingSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    return MeshGradientBackground(
      child: Column(
        children: [
          BottomSheetHeader(
            title: 'Select language'.hardcoded,
            onClose: () => Navigator.of(context).pop(),
          ),
          _buildLanguageOptions(context, ref, language),
        ],
      ),
    );
  }

  Widget _buildLanguageOptions(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<Locale?> language,
  ) {
    return Column(
      children: LanguageCode.values
          .map(
            (code) => MoonMenuItem(
              absorbGestures: true,
              onTap: () {
                VibrationUtil.vibrate(context);
                _setNewLanguage(
                  ref,
                  language.value?.languageCode,
                  code.name,
                );
              },
              label: Text(_getLanguageTitle(context, code)),
              leading: MoonRadio<LanguageCode>(
                value: code,
                groupValue: language.value != null
                    ? LanguageCode.values.firstWhere(
                        (e) => e.name == language.value?.languageCode,
                      )
                    : null,
                onChanged: (LanguageCode? value) {},
              ),
            ),
          )
          .toList(),
    );
  }

  String _getLanguageTitle(BuildContext context, LanguageCode code) {
    switch (code) {
      case LanguageCode.en:
        return context.l10n.english;
      case LanguageCode.vi:
        return context.l10n.vietnamese;
    }
  }

  void _setNewLanguage(WidgetRef ref, String? current, String next) {
    if (current != next) {
      ref.read(languageProvider.notifier).setLanguage(next);
    }
  }
}
