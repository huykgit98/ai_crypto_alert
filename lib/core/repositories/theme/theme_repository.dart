import 'package:ai_crypto_alert/core/client/local/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_repository.g.dart';

class ThemeRepository {
  ThemeRepository({required this.preferences});

  final SharedPreferences preferences;

  static const _themeKey = 'theme';

  Future<int?> getTheme() async {
    return preferences.getInt(_themeKey);
  }

  Future<bool> setTheme(int theme) async {
    return preferences.setInt(_themeKey, theme);
  }
}

@riverpod
ThemeRepository themeRepository(ThemeRepositoryRef ref) {
  return ThemeRepository(preferences: ref.watch(sharedPrefsProvider));
}

@riverpod
Future<int?> getTheme(GetThemeRef ref) async {
  return ref.watch(themeRepositoryProvider).getTheme();
}

@riverpod
Future<bool> setTheme(SetThemeRef ref, {required int theme}) async {
  return ref.watch(themeRepositoryProvider).setTheme(theme);
}
