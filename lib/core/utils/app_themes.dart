import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    heading: MoonTypography.typography.heading.apply(fontFamily: "Inter"),
    body: MoonTypography.typography.body.apply(fontFamily: "Inter"),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xFFF6F7F9), // Gohan light.
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  textTheme: GoogleFonts.interTextTheme(), // Apply Inter font globally
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(
      tokens: MoonTokens.light.copyWith(
        colors: mdsLightColors,
        typography: MoonTypography.typography.copyWith(
          heading: MoonTypography.typography.heading.apply(
            fontFamily: "Inter",
            fontWeightDelta: -1,
            fontVariations: [const FontVariation('wght', 500)],
          ),
          body: MoonTypography.typography.body.apply(
            fontFamily: "Inter",
          ),
        ),
      ),
      // effects: MoonEffectsTheme(
      //   tokens: lightTokens,
      //   controlHoverEffect: MoonEffectsTheme(tokens: lightTokens)
      //       .controlHoverEffect
      //       .copyWith(primaryHoverColor: Colors.white.withOpacity(0.3)),
      // ),
    ),
  ],
);

// Dark Theme
final darkTokens = MoonTokens.dark.copyWith(
  typography: MoonTypography.typography.copyWith(
    heading: MoonTypography.typography.heading.apply(fontFamily: "Inter"),
    body: MoonTypography.typography.body.apply(fontFamily: "Inter"),
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF1F1F1F), // Gohan dark.
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

  hoverColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  textTheme: GoogleFonts.interTextTheme().apply(
    bodyColor: Colors.white, // Apply white text color for body
    displayColor: Colors.white, // Apply white text color for headings
  ),
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(
      tokens: MoonTokens.dark.copyWith(
        colors: mdsDarkColors,
        typography: MoonTypography.typography.copyWith(
          heading: MoonTypography.typography.heading.apply(
            fontFamily: "Inter",
            fontWeightDelta: -1,
            fontVariations: [const FontVariation('wght', 500)],
          ),
          body: MoonTypography.typography.body.apply(
            fontFamily: "Inter",
          ),
        ),
      ),
      // effects: MoonEffectsTheme(
      //   tokens: lightTokens,
      //   controlHoverEffect: MoonEffectsTheme(tokens: lightTokens)
      //       .controlHoverEffect
      //       .copyWith(primaryHoverColor: Colors.white.withOpacity(0.3)),
      // ),
    ),
  ],
);
