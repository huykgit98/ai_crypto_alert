import 'dart:math';
import 'dart:ui' as ui;

import 'package:ai_crypto_alert/core/utils/lottie_decoder.dart';
import 'package:ai_crypto_alert/features/home/presentation/widgets/app_bar/notification_handler.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:moon_design/moon_design.dart';

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CustomSliverPersistentHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  final double minExtent;
  @override
  final double maxExtent;

  double get deltaExtent => maxExtent - minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentExtent = max(minExtent, maxExtent - shrinkOffset);
    final t =
        ui.clampDouble(1.0 - (currentExtent - minExtent) / deltaExtent, 0, 1);
    CollapsingNotification(t).dispatch(context);

    final horizontalPadding = ui.lerpDouble(16, 0, t) ?? 0;
    final incomeExpensesOpacity = (1 - t).clamp(0.0, 1.0);
    final incomeExpensesScale = (1 - t).clamp(0.0, 1.0);
    final incomeExpensesLeft = ui.lerpDouble(48, 32, t) ?? 24;
    final incomeExpensesBottom = ui.lerpDouble(48, 0, t) ?? 24;

    final totalBalanceBottom = ui.lerpDouble(deltaExtent - 60, 8, t) ?? 8;
    final totalBalanceLeft = ui.lerpDouble(48, 32, t) ?? 24;

    final cardBottom = ui.lerpDouble(16, 0, t) ?? 24;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.moonColors!.frieza60,
                context.moonColors!.frieza60,
                context.moonColors!.goku.withValues(alpha: 0),
              ],
            ),
          ),
        ),
        Positioned(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: cardBottom,
          child: Container(
            height: deltaExtent,
            decoration: BoxDecoration(
              color: context.moonColors!.goku,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        Positioned(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: 0,
          child: Transform.scale(
            scale: incomeExpensesScale,
            child: Opacity(
              opacity: incomeExpensesOpacity,
              child: const MoonDotIndicator(
                size: 8,
                selectedDot: 1,
                dotCount: 5,
              ),
            ),
          ),
        ),
        Positioned(
          left: totalBalanceLeft,
          bottom: totalBalanceBottom,
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
        Positioned(
          right: totalBalanceLeft,
          bottom: totalBalanceBottom,
          child: Row(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      context.moonColors!.frieza,
                      context.moonColors!.whis,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Icon(
                  MingCute.wallet_5_fill,
                  size: ui.lerpDouble(24, 20, t),
                  color: Colors
                      .white, // Set the icon color to white to apply the gradient
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'All Accounts',
                style: TextStyle(
                  fontSize: ui.lerpDouble(14, 14, t),
                  color: context.moonColors!.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: incomeExpensesLeft,
          right: incomeExpensesLeft,
          bottom: incomeExpensesBottom,
          child: Transform.scale(
            scale: incomeExpensesScale,
            child: Opacity(
              opacity: incomeExpensesOpacity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.moonColors!.roshi10,
                            ),
                            child: Icon(
                              MingCute.up_small_fill,
                              size: 24,
                              color: context.moonColors!.roshi,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 16,
                              color: context.moonColors!.textSecondary,
                            ),
                          ),
                        ],
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
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.moonColors!.chichi10,
                            ),
                            child: Icon(
                              MingCute.down_small_fill,
                              size: 24,
                              color: context.moonColors!.chichi,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontSize: 16,
                              color: context.moonColors!.textSecondary,
                            ),
                          ),
                        ],
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
          left: 16,
          top: MediaQuery.of(context).padding.top,
          child: Transform.scale(
            scale: incomeExpensesScale,
            child: Opacity(
              opacity: incomeExpensesOpacity,
              child: Text.rich(
                TextSpan(
                  text: 'Good morning, ',
                  style: context.moonTypography?.body.text18.copyWith(
                    color: context.moonColors!.goten,
                  ),
                  children: [
                    TextSpan(
                      text: 'Negan',
                      style: context.moonTypography?.body.text18.copyWith(
                        color: context.moonColors!.goten,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '!',
                      style: context.moonTypography?.body.text18.copyWith(
                        color: context.moonColors!.goten,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 24,
          child: Transform.scale(
            scale: incomeExpensesScale,
            child: Opacity(
              opacity: incomeExpensesOpacity,
              child: Lottie.asset(
                Assets.lotties.eRoboWaving,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
                decoder: customLottieDecoder,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }
}
