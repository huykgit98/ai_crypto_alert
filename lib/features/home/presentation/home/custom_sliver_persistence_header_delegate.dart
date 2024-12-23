import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:ai_crypto_alert/core/utils/lottie_decoder.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moon_design/moon_design.dart';

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CustomSliverPersistentHeaderDelegate({required this.statusBarHeight});
  final double statusBarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Interpolation factor
    final t = shrinkOffset / (maxExtent - minExtent);

    // Dynamically interpolate height and horizontal padding
    final currentHeight = math.max(
      kToolbarHeight + statusBarHeight,
      ui.lerpDouble(200, kToolbarHeight + statusBarHeight, t) ?? kToolbarHeight,
    );

    final horizontalPadding = ui.lerpDouble(16, 0, t) ?? 0;

    // Clamp opacity and scale for Income and Expenses
    final incomeExpensesOpacity = (1 - t).clamp(0.0, 1.0);
    final incomeExpensesScale = (1 - t).clamp(0.0, 1.0);

    // Dynamically interpolate position and scaling for Total Balance
    final totalBalanceTop = ui.lerpDouble(statusBarHeight + 60, 48, t) ?? 8;
    final totalBalanceLeft = ui.lerpDouble(48, 32, t) ?? 24;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.moonColors!.piccolo,
                context.moonColors!.goku.withValues(alpha: 0),
              ],
            ),
          ),
        ),

        // Red container for the header background
        Positioned(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: 0, // Stick to the bottom of the header
          child: AnimatedContainer(
            duration: Duration.zero, // Instant update
            height: currentHeight,
            decoration: BoxDecoration(
              color: context.moonColors!.goku,
              borderRadius: const BorderRadius.all(
                Radius.circular(32), // Always rounded
              ),
            ),
          ),
        ),

        // Total Balance with dynamic position and scale
        Positioned(
          left: totalBalanceLeft,
          bottom: totalBalanceTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  fontSize: ui.lerpDouble(16, 14, t),
                  color: context.moonColors!.textSecondary,
                ),
              ),
              Text(
                '\$10000000',
                style: TextStyle(
                  fontSize: ui.lerpDouble(20, 18, t),
                  color: context.moonColors!.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Income and Expenses Section
        Positioned(
          left: 48,
          right: 48,
          bottom: 32, // Stick to the bottom of the header
          child: Transform.scale(
            scale: incomeExpensesScale, // Scale dynamically
            child: Opacity(
              opacity: incomeExpensesOpacity, // Fading effect
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Income',
                        style: context.moonTypography?.body.text16.copyWith(
                          color: context.moonColors!.textSecondary,
                        ),
                      ),
                      Text(
                        '\$10000000',
                        style: context.moonTypography?.body.text18.copyWith(
                          color: context.moonColors!.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expenses',
                        style: context.moonTypography?.body.text16.copyWith(
                          color: context.moonColors!.textSecondary,
                        ),
                      ),
                      Text(
                        '\$10000000',
                        style: context.moonTypography?.body.text18.copyWith(
                          color: context.moonColors!.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 24,
          right: 0,
          top: 32,
          child: Transform.scale(
            scale: incomeExpensesScale, // Scale dynamically
            child: Opacity(
              opacity: incomeExpensesOpacity, // Fading effect
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: context.moonTypography?.body.text16.copyWith(
                          color: context.moonColors!.textPrimary,
                        ),
                      ),
                      Text(
                        'Negan',
                        style: context.moonTypography?.body.text24.copyWith(
                          color: context.moonColors!.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Lottie.asset(
                    Assets.lotties.eRoboWaving,
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                    decoder: customLottieDecoder,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => kToolbarHeight + statusBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // Allow rebuilding during scrolling
  }
}
