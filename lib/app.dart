import 'package:ai_crypto_alert/core/providers/providers.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(customThemeProvider);

    // Update status bar style when theme changes
    ref.listen<AsyncValue<ThemeMode?>>(customThemeProvider, (_, nextTheme) {
      if (nextTheme.hasValue && nextTheme.value != null) {
        final isDarkMode = nextTheme.value == ThemeMode.dark ||
            (nextTheme.value == ThemeMode.system && context.isDarkMode);

        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
            statusBarBrightness:
                isDarkMode ? Brightness.dark : Brightness.light, // For iOS
          ),
        );
      }
    });

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      routerConfig: goRouter,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode.value,
      locale: language.value,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        for (final currentLocale in supportedLocales) {
          if (currentLocale.languageCode == locale?.languageCode) {
            if (language.hasValue) {
              _setNewLanguage(ref, language.value, currentLocale);
            }
            return currentLocale;
          }
        }

        final firstLanguage = supportedLocales.first;
        if (language.hasValue) {
          _setNewLanguage(ref, language.value, supportedLocales.first);
        }
        return firstLanguage;
      },
      debugShowCheckedModeBanner: false,
    );
  }

  void _setNewLanguage(WidgetRef ref, Locale? current, Locale next) {
    if (current?.languageCode != next.languageCode) {
      ref.read(languageProvider.notifier).setLanguage(next.languageCode);
    }
  }
}
