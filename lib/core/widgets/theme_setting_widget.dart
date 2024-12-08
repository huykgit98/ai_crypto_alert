import 'package:ai_crypto_alert/core/providers/providers.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class ThemeSettingSheet extends ConsumerWidget {
  const ThemeSettingSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MeshGradientBackground(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            title: context.l10n.darkMode,
            onClose: () => Navigator.of(context).pop(),
          ),
          ...ThemeMode.values.reversed
              .map((mode) => _buildThemeModeOption(context, ref, mode)),
        ],
      ),
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
  ) {
    final theme = ref.watch(customThemeProvider);
    String title;
    String? subtitle;
    switch (mode) {
      case ThemeMode.dark:
        title = context.l10n.on;
        break;
      case ThemeMode.light:
        title = context.l10n.off;
        break;
      case ThemeMode.system:
        title = context.l10n.system;
        subtitle = context.l10n.systemSubtitle;
        break;
    }

    return MoonMenuItem(
      absorbGestures: true,
      onTap: () {
        VibrationUtil.vibrate(context);
        _setNewTheme(ref, theme.value, mode);
      },
      label: Text(title),
      content: subtitle != null ? Text(subtitle) : null,
      leading: MoonRadio<ThemeMode>(
        value: mode,
        groupValue: theme.value,
        onChanged: (ThemeMode? value) {
          if (value != null) {
            _setNewTheme(ref, theme.value, value);
          }
        },
      ),
    );
  }

  void _setNewTheme(WidgetRef ref, ThemeMode? current, ThemeMode next) {
    if (current != next) {
      ref.read(customThemeProvider.notifier).setTheme(next.index);
    }
  }
}
