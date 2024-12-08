import 'package:ai_crypto_alert/core/enums/enums.dart';
import 'package:ai_crypto_alert/core/providers/providers.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class LanguageSettingSheet extends ConsumerStatefulWidget {
  const LanguageSettingSheet({super.key});

  @override
  ConsumerState<LanguageSettingSheet> createState() =>
      _LanguageSettingSheetState();
}

class _LanguageSettingSheetState extends ConsumerState<LanguageSettingSheet>
    with TickerProviderStateMixin {
  final Map<LanguageCode, AnimationController> _animationControllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize AnimationControllers for each LanguageCode
    for (final code in LanguageCode.values) {
      _animationControllers[code] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  void dispose() {
    // Dispose all AnimationControllers
    for (final controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);

    // Start animation for the selected language
    if (language.value != null) {
      for (final code in LanguageCode.values) {
        if (language.value!.languageCode == code.name) {
          _animationControllers[code]?.forward();
        } else {
          _animationControllers[code]?.reset();
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: context.moonColors!.gohan,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          BottomSheetHeader(
            title: context.l10n.languageSettingTitle,
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
              label: Text(
                _getLanguageTitle(context, code),
                style: context.moonTypography?.heading.text14.copyWith(
                  fontWeight: FontWeight.w500,
                  color: language.value?.languageCode == code.name
                      ? context.moonColors?.textPrimary
                      : context.moonColors?.textSecondary,
                ),
              ),
              trailing: SizedBox(
                width: 32,
                height: 32,
                child: AnimatedCheck(
                  progress: _animationControllers[code]!,
                  size: 32,
                  color: context.moonColors?.roshi,
                ),
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
