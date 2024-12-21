import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

extension GradientUtils on BuildContext {
  // Linear gradient for buttons
  LinearGradient buttonLinearGradient({
    Alignment begin = Alignment.centerLeft,
    Alignment end = Alignment.centerRight,
  }) {
    return LinearGradient(
      colors: [
        moonColors!.frieza60,
        moonColors!.jiren,
      ],
      begin: begin,
      end: end,
    );
  }

  // Radial gradient for buttons
  RadialGradient buttonRadialGradient({
    Alignment center = Alignment.center,
    double radius = 1.0,
  }) {
    return RadialGradient(
      colors: [
        moonColors!.frieza60,
        moonColors!.jiren,
      ],
      radius: radius,
      center: center,
    );
  }

  // Linear gradient for backgrounds
  LinearGradient backgroundLinearGradient({
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: [
        moonColors!.bulma,
        moonColors!.heles,
      ],
      begin: begin,
      end: end,
    );
  }

  // Radial gradient for backgrounds
  RadialGradient backgroundRadialGradient({
    Alignment center = Alignment.center,
    double radius = 1.5,
  }) {
    return RadialGradient(
      colors: [
        moonColors!.bulma,
        moonColors!.heles,
      ],
      radius: radius,
      center: center,
    );
  }

  // Gradient for text (Shader-based linear gradient)
  Shader textLinearGradient({
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
    Rect rect = const Rect.fromLTWH(0, 0, 200, 70),
  }) {
    return LinearGradient(
      colors: [
        moonColors!.frieza60,
        moonColors!.jiren,
      ],
      begin: begin,
      end: end,
    ).createShader(rect);
  }

  // Gradient for text (Shader-based radial gradient)
  Shader textRadialGradient({
    Alignment center = Alignment.center,
    double radius = 1.0,
    Rect rect = const Rect.fromLTWH(0, 0, 200, 70),
  }) {
    return RadialGradient(
      colors: [
        moonColors!.frieza60,
        moonColors!.jiren,
      ],
      radius: radius,
      center: center,
    ).createShader(rect);
  }

  RadialGradient get topLeftRadialGradient => RadialGradient(
        radius: 0.9,
        center: Alignment.topLeft,
        colors: [
          moonColors!.piccolo.withValues(alpha: .2),
          moonColors!.goku.withValues(alpha: 0),
        ],
      );

  RadialGradient get bottomRightRadialGradient => RadialGradient(
        center: Alignment.bottomRight,
        colors: [
          moonColors!.frieza10.withValues(alpha: .2),
          moonColors!.frieza10.withValues(alpha: .1),
          moonColors!.goku.withValues(alpha: 0),
        ],
      );

  RadialGradient get centerRightRadialGradient => RadialGradient(
        center: Alignment.centerRight,
        colors: [
          moonColors!.piccolo.withValues(alpha: .2),
          moonColors!.goku.withValues(alpha: 0),
        ],
      );

  RadialGradient get topCenterRadialGradient => RadialGradient(
        radius: 0.8,
        center: Alignment.topCenter,
        colors: [
          moonColors!.piccolo.withValues(alpha: .2),
          moonColors!.goku.withValues(alpha: 0),
        ],
      );

  RadialGradient get bottomCenterRadialGradient => RadialGradient(
        center: Alignment.bottomCenter,
        colors: [
          moonColors!.piccolo.withValues(alpha: .2),
          moonColors!.goku.withValues(alpha: 0),
        ],
      );

  RadialGradient get topRightRadialGradient => RadialGradient(
        radius: 0.8,
        center: Alignment.topRight,
        colors: [
          moonColors!.frieza10,
          moonColors!.frieza10,
          moonColors!.goku.withValues(alpha: 0),
        ],
      );
}
