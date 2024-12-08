import 'package:ai_crypto_alert/core/providers/providers.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class ThemeSettingSheet extends ConsumerStatefulWidget {
  const ThemeSettingSheet({super.key});

  @override
  ConsumerState<ThemeSettingSheet> createState() => _ThemeSettingSheetState();
}

class _ThemeSettingSheetState extends ConsumerState<ThemeSettingSheet>
    with TickerProviderStateMixin {
  final Map<ThemeMode, AnimationController> _animationControllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize AnimationControllers for each ThemeMode
    for (final mode in ThemeMode.values) {
      _animationControllers[mode] = AnimationController(
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
    final theme = ref.watch(customThemeProvider);

    // Start animation for the selected theme
    for (final mode in ThemeMode.values) {
      if (theme.value == mode) {
        _animationControllers[mode]?.forward();
      } else {
        _animationControllers[mode]?.reset();
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetHeader(
          title: context.l10n.darkMode,
          onClose: () => Navigator.of(context).pop(),
        ),
        ...ThemeMode.values.reversed
            .map((mode) => _buildThemeModeOption(context, ref, theme, mode)),
      ],
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<ThemeMode?> theme,
    ThemeMode mode,
  ) {
    String title;
    String? subtitle;

    switch (mode) {
      case ThemeMode.dark:
        title = context.l10n.on;
      case ThemeMode.light:
        title = context.l10n.off;
      case ThemeMode.system:
        title = context.l10n.system;
        subtitle = context.l10n.systemSubtitle;
    }

    return MoonMenuItem(
      absorbGestures: true,
      onTap: () {
        VibrationUtil.vibrate(context);
        _setNewTheme(ref, theme.value, mode);
      },
      hoverEffectColor: Colors.red,
      label: Text(title),
      content: subtitle != null ? Text(subtitle) : null,
      trailing: SizedBox(
        width: 32,
        height: 32,
        child: AnimatedCheck(
          progress: _animationControllers[mode]!,
          size: 32,
          color: context.moonColors?.roshi,
        ),
      ),
    );
  }

  void _setNewTheme(WidgetRef ref, ThemeMode? current, ThemeMode next) {
    if (current != next) {
      ref.read(customThemeProvider.notifier).setTheme(next.index);
    }
  }
}
