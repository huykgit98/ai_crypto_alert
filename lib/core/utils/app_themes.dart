import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

extension BuildContextX on BuildContext {
  /// Whether the dark mode is currently active.
  bool get darkMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}

// Light Theme
final lightTokens = MoonTokens.light.copyWith(
  typography: MoonTypography.typography.copyWith(
    heading: MoonTypography.typography.heading.apply(fontFamily: "Roboto"),
    body: MoonTypography.typography.body.apply(fontFamily: "Roboto"),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: Colors.green,
  // ),
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(tokens: lightTokens).copyWith(
      accordionTheme: MoonAccordionTheme(tokens: lightTokens).copyWith(
        colors: MoonAccordionTheme(tokens: lightTokens).colors.copyWith(
              backgroundColor: Colors.white,
            ),
      ),
      // toastTheme: MoonToastTheme(tokens: darkTokens).copyWith(
      //   colors: MoonToastTheme(tokens: darkTokens).colors.copyWith(
      //         darkVariantBackgroundColor: Colors.black.withOpacity(0.8),
      //         darkVariantTextColor: Colors.white,
      //         darkVariantIconColor: Colors.white,
      //       ),
      // ),
    ),
  ],
);

// Dark Theme
final darkTokens = MoonTokens.dark.copyWith(
  typography: MoonTypography.typography.copyWith(
    heading: MoonTypography.typography.heading.apply(fontFamily: "Roboto"),
    body: MoonTypography.typography.body.apply(fontFamily: "Roboto"),
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: Colors.green,
  //   brightness: Brightness.dark,
  // ),
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(tokens: darkTokens).copyWith(
      accordionTheme: MoonAccordionTheme(tokens: darkTokens).copyWith(
        colors: MoonAccordionTheme(tokens: darkTokens).colors.copyWith(
              backgroundColor: Colors.black,
            ),
      ),
      // toastTheme: MoonToastTheme(tokens: darkTokens).copyWith(
      //   colors: MoonToastTheme(tokens: darkTokens).colors.copyWith(
      //         darkVariantBackgroundColor: Colors.black.withOpacity(0.8),
      //         darkVariantTextColor: Colors.white,
      //         darkVariantIconColor: Colors.white,
      //       ),
      // ),
    ),
  ],
);
