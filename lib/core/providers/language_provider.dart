import 'dart:ui';

import 'package:ai_crypto_alert/core/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_provider.g.dart';

@riverpod
class Language extends _$Language {
  @override
  FutureOr<Locale?> build() async {
    final languageCode =
        await ref.read(languageRepositoryProvider).getLanguage();
    if (languageCode != null) {
      return Locale(languageCode);
    }

    return Locale(languageCode ?? 'en');
  }

  Future<void> getLanguage() async {
    final language = await ref.read(languageRepositoryProvider).getLanguage();
    if (language != null) state = AsyncValue.data(Locale(language));
  }

  Future<void> setLanguage(String language) async {
    await ref.read(languageRepositoryProvider).setLanguage(language);
    state = AsyncValue.data(Locale(language));
  }
}
