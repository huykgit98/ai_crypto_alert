import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/momo_app_bar/momo_app_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const SliverAppBarDelegate({
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  final double minExtent;

  @override
  final double maxExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  double get deltaExtent => maxExtent - minExtent;

  double transform(double begin, double end, double t, [double x = 1]) {
    return Tween<double>(begin: begin, end: end)
        .transform(x == 1 ? t : min(1, t * x));
  }

  Color transformColor(Color? begin, Color? end, double t, [double x = 1]) {
    return ColorTween(begin: begin, end: end)
            .transform(x == 1 ? t : min(1, t * x)) ??
        Colors.transparent;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final currentExtent = max(minExtent, maxExtent - shrinkOffset);
    final t =
        clampDouble(1.0 - (currentExtent - minExtent) / deltaExtent, 0, 1);
    CollapsingNotification(t).dispatch(context);

    final isDarkMode = context.darkMode;

    final gradientColors = isDarkMode
        ? [const Color(0xFF5c9c10), const Color(0xFF005433)]
        : [const Color(0xFFe7fc83), const Color(0xFFc4febe)];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final children = <Widget>[];
        final splashColoredBox = ColoredBox(
          color: transformColor(
            null,
            isDarkMode ? Colors.black87 : Colors.white,
            t,
            3,
          ),
        );

        var gradientHeight = maxExtent;

        // Gradient background
        if (constraints.maxHeight > gradientHeight) {
          gradientHeight = constraints.maxHeight;
        }
        children
          ..add(
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: gradientHeight - deltaExtent / 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          )

          // Splash transform color bottom
          ..add(
            Positioned(
              bottom: 0,
              width: constraints.maxWidth,
              height: deltaExtent,
              child: splashColoredBox,
            ),
          );

        if (Platform.isIOS) {
          children.add(
            Positioned(
              top: minExtent,
              left: 0,
              right: 0,
              child: Container(
                height: 48,
                color: Colors.transparent,
                child: const HeaderLocator(
                  clearExtent: false,
                ),
              ),
            ),
          );
        }

        // Card
        const cardPadding = 16.0;
        const cardMarginHorizontal = 16.0;

        children
          ..add(
            Positioned(
              left: cardMarginHorizontal,
              right: cardMarginHorizontal,
              bottom: 0,
              height: deltaExtent,
              child: ActionsCard(
                contentPadding: const EdgeInsets.all(cardPadding),
                borderRadius: BorderRadius.circular(transform(12, 0, t, 2)),
              ),
            ),
          )

          // Splash transform color top
          ..add(
            Positioned(
              top: 0,
              height: minExtent,
              width: constraints.maxWidth,
              child: splashColoredBox,
            ),
          );

        // App bar
        const appBarPadding = SizedBox(width: 8);
        final appBarContentWidth =
            constraints.maxWidth - (appBarPadding.width! * 2);
        const totalIconImgButtonSize = IconImgButton.tapTargetSize * 7;
        final appBarSpace = SizedBox(
          width: (appBarContentWidth - totalIconImgButtonSize) / 6,
        );

        //App bar fixed position
        var iconBgrColor = transformColor(
          isDarkMode ? Colors.black54 : Colors.black12,
          null,
          t,
          4,
        );

        var iconTextColor = transformColor(
          isDarkMode ? Colors.white : Colors.black,
          null,
          t,
          4,
        );
        children.add(
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: minExtent,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    appBarPadding,
                    Hero(
                      tag: 'homeSearchBar',
                      child: Material(
                        type: MaterialType.transparency,
                        child: SearchArea(
                            appBarContentWidth: appBarContentWidth,
                            appBarSpace: appBarSpace,
                            iconBgrColor: iconBgrColor,
                            iconTextColor: iconTextColor,
                            onTap: () {
                              // context.goNamed(AppRoute.plantsSearch.name);
                            }),
                      ),
                    ),
                    appBarSpace,
                    const Spacer(),
                    appBarSpace,
                    IconImgButton(
                      MingCute.heart_fill,
                      backgroundColor: iconBgrColor,
                      onTap: () => context.goNamed(AppRoute.favorite.name),
                    ),
                    appBarSpace,
                    IconImgButton(
                      MingCute.notification_fill,
                      backgroundColor: iconBgrColor,
                      onTap: () => context.goNamed(AppRoute.notifications.name),
                    ),
                    appBarPadding,
                  ],
                ),
              ),
            ),
          ),
        );

        // App bar transform position
        iconBgrColor = transformColor(
          isDarkMode
              ? const Color(0xFF5c9c10).withOpacity(0.7)
              : const Color(0xFFe7fc83).withOpacity(0.7),
          null,
          t,
          2,
        );

        final iconSize = transform(48, 32, t, 3);
        final iconPadding = transform(8, 4, t, 3);

        final cardWidth = constraints.maxWidth - (cardMarginHorizontal * 2);
        final cardSpace = (cardWidth - (IconImgButton.tapTargetSize * 4)) / 5;

        children.add(
          Positioned(
            left: transform(
              cardSpace + cardPadding,
              appBarPadding.width! +
                  IconImgButton.tapTargetSize +
                  appBarSpace.width!,
              t,
              2,
            ),
            right: transform(
              cardSpace + cardPadding,
              appBarPadding.width! +
                  IconImgButton.tapTargetSize * 2 +
                  appBarSpace.width! * 2,
              t,
              2,
            ),
            top: constraints.maxHeight > maxExtent
                ? null
                : transform(
                    minExtent + cardPadding,
                    minExtent - IconImgButton.tapTargetSize - 4,
                    t,
                    2,
                  ),
            bottom: constraints.maxHeight < maxExtent
                ? null
                : deltaExtent - IconImgButton.tapTargetSize - cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconImgButton(
                  MingCute.rake_fill,
                  onTap: () => null,
                  size: iconSize,
                  padding: iconPadding,
                  backgroundRadius: 16,
                  backgroundColor: iconBgrColor,
                ),
                IconImgButton(
                  MingCute.tree_2_fill,
                  onTap: () => null,
                  size: iconSize,
                  padding: iconPadding,
                  backgroundRadius: 16,
                  backgroundColor: iconBgrColor,
                ),
                IconImgButton(
                  MingCute.shopping_cart_2_fill,
                  onTap: () => null,
                  size: iconSize,
                  padding: iconPadding,
                  backgroundRadius: 16,
                  backgroundColor: iconBgrColor,
                ),
                IconImgButton(
                  MingCute.map_fill,
                  onTap: () {
                    // context.goNamed(AppRoute.guide.name);
                  },
                  size: iconSize,
                  padding: iconPadding,
                  backgroundRadius: 16,
                  backgroundColor: iconBgrColor,
                ),
              ],
            ),
          ),
        );
        return Stack(children: children);
      },
    );
  }
}

class SearchArea extends StatelessWidget {
  const SearchArea({
    required this.appBarContentWidth,
    required this.appBarSpace,
    required this.iconBgrColor,
    required this.onTap,
    required this.iconTextColor,
    super.key,
  });

  final double appBarContentWidth;
  final SizedBox appBarSpace;
  final Color iconBgrColor;
  final Color iconTextColor;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = 'hehhehehhe';
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: appBarContentWidth -
                IconImgButton.tapTargetSize * 2 -
                appBarSpace.width! * 3 -
                4,
            height: 40,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: iconBgrColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: DefaultTextStyle(
                  style: context.moonTypography!.body.text14.copyWith(
                    color: iconTextColor,
                  ),
                  child: AnimatedTextKit(
                    key: ValueKey(title),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        title,
                      ),
                    ],
                    onTap: onTap,
                  ),
                ),
              ),
            ),
          ),
          IconImgButton(MingCute.search_2_fill,
              backgroundColor: Colors.transparent, onTap: () {
            // context.goNamed(AppRoute.plantsSearch.name);
          }),
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  RectClipper(this.maxHeight);
  final double maxHeight;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, maxHeight);
  }

  @override
  bool shouldReclip(RectClipper oldClipper) =>
      oldClipper.maxHeight != maxHeight;
}
