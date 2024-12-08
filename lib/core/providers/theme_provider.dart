import 'package:ai_crypto_alert/core/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class CustomTheme extends _$CustomTheme {
  @override
  FutureOr<ThemeMode?> build() async {
    final theme = await ref.read(themeRepositoryProvider).getTheme();

    if (theme != null) {
      return ThemeMode.values[theme];
    }
    return ThemeMode.light;
  }

  Future<void> getTheme() async {
    final theme = await ref.read(themeRepositoryProvider).getTheme();
    if (theme != null) state = AsyncValue.data(ThemeMode.values[theme]);
  }

  Future<void> setTheme(int theme) async {
    await ref.read(themeRepositoryProvider).setTheme(theme);
    state = AsyncValue.data(ThemeMode.values[theme]);
  }
}
