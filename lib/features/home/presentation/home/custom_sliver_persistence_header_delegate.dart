import 'dart:math';
import 'dart:ui' as ui;

import 'package:ai_crypto_alert/core/utils/lottie_decoder.dart';
import 'package:ai_crypto_alert/core/widgets/animations/blur_fade_widget.dart';
import 'package:ai_crypto_alert/features/home/presentation/home_screen_notifier.dart';
import 'package:ai_crypto_alert/features/home/presentation/widgets/app_bar/notification_handler.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    const int totalDots = 5;

    return Consumer(
      builder: (context, ref, child) {
        final homeState = ref.watch(homeScreenProvider);
        final isVisible = ref.watch(totalBalanceVisibilityProvider);

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            // Block vertical scroll notifications originating from this area
            return true;
          },
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                final notifier = ref.read(homeScreenProvider.notifier);

                // Check if the position is at the first or last index
                final isAtFirst = notifier.state.selectedDot == 0;
                final isAtLast = notifier.state.selectedDot == totalDots - 1;

                if ((details.primaryVelocity! > 0 &&
                        isAtFirst) || // Left swipe at the first
                    (details.primaryVelocity! < 0 && isAtLast)) {
                  // Right swipe at the last
                  // Do nothing if at boundaries
                  return;
                }

                // Apply BlurFade animation
                ref.read(totalBalanceVisibilityProvider.notifier).state = false;

                Future.delayed(const Duration(milliseconds: 200), () {
                  ref.read(totalBalanceVisibilityProvider.notifier).state =
                      true;
                });

                // Perform swipe action
                notifier.swipeCard(details.primaryVelocity! < 0); // Left swipe
              }
            },
            onVerticalDragStart: (_) {
              // Do nothing; block vertical gestures
            },
            onVerticalDragUpdate: (_) {
              // Do nothing; block vertical gestures
            },
            onVerticalDragEnd: (_) {
              // Do nothing; block vertical gestures
            },
            behavior: HitTestBehavior.opaque,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background gradient
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
                // Swipeable card with blocked vertical scrolling
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
                // Dot indicator
                Positioned(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: 0,
                  child: Transform.scale(
                    scale: incomeExpensesScale,
                    child: Opacity(
                      opacity: incomeExpensesOpacity,
                      child: MoonDotIndicator(
                        size: 8,
                        selectedDot: homeState.selectedDot,
                        dotCount: 5,
                      ),
                    ),
                  ),
                ),

                // Total Balance
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
                      BlurFade(
                        isVisible: isVisible,
                        child: Text(
                          homeState.totalBalance,
                          style: TextStyle(
                            fontSize: ui.lerpDouble(20, 18, t),
                            color: context.moonColors!.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Account info
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
                      BlurFade(
                        isVisible: isVisible,
                        child: Text(
                          homeState.accountName,
                          style: TextStyle(
                            fontSize: ui.lerpDouble(14, 14, t),
                            color: context.moonColors!.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Greeting
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
                              style:
                                  context.moonTypography?.body.text18.copyWith(
                                color: context.moonColors!.goten,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '!',
                              style:
                                  context.moonTypography?.body.text18.copyWith(
                                color: context.moonColors!.goten,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Income and Expenses
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
                              BlurFade(
                                isVisible: isVisible,
                                child: Text(
                                  homeState.income,
                                  style: context.moonTypography?.body.text18
                                      .copyWith(
                                    color: context.moonColors!.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                              BlurFade(
                                isVisible: isVisible,
                                child: Text(
                                  homeState.expenses,
                                  style: context.moonTypography?.body.text18
                                      .copyWith(
                                    color: context.moonColors!.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //eRobo Waving
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
            ),
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }
}
