import 'dart:io';
import 'dart:math';

import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

import 'home_screen_sliver_app_bar_delegate.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late double minExtent;
  late double maxExtent;
  final ScrollController _scrollController = ScrollController();
  final _indicatorStateListenable = IndicatorStateListenable();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    minExtent = kToolbarHeight + MediaQuery.paddingOf(context).top;
    maxExtent = Platform.isAndroid ? 190 : 216;

    return MeshGradientBackground(
      child: AppBarScrollHandler(
        minExtent: minExtent,
        maxExtent: maxExtent,
        controller: _scrollController,
        child: EasyRefresh(
          onRefresh: _onRefresh,
          header: (Platform.isIOS)
              ? const CupertinoHeader(
                  position: IndicatorPosition.locator,
                  triggerOffset: 0,
                )
              : ListenerHeader(
                  triggerOffset: 100,
                  listenable: _indicatorStateListenable,
                  safeArea: false,
                ),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (Platform.isAndroid)
                SliverToBoxAdapter(
                  child: ValueListenableBuilder<IndicatorState?>(
                    valueListenable: _indicatorStateListenable,
                    builder: (context, state, _) {
                      if (state == null) {
                        return const SizedBox();
                      }
                      final mode = state.mode;
                      final offset = state.offset;
                      final actualTriggerOffset = state.actualTriggerOffset;
                      double? value;
                      if (mode == IndicatorMode.inactive) {
                        value = 0;
                      } else if (mode == IndicatorMode.processing) {
                        value = null;
                      } else if (mode == IndicatorMode.drag ||
                          mode == IndicatorMode.armed) {
                        value = min(offset / actualTriggerOffset, 1) * 0.75;
                      } else if (mode == IndicatorMode.ready ||
                          mode == IndicatorMode.processing) {
                        value = null;
                      } else {
                        value = 1;
                      }
                      Widget indicator;
                      if (value != null && value < 0.1) {
                        indicator = const SizedBox();
                      } else if (value == 1) {
                        indicator = Icon(
                          Icons.done,
                          color: context.moonColors?.whis,
                        );
                      } else {
                        indicator = RefreshProgressIndicator(
                          color: context.moonColors?.whis,
                          value: value,
                        );
                      }
                      return SizedBox(
                        width: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              reverseDuration:
                                  const Duration(milliseconds: 100),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: indicator,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  minExtent: minExtent,
                  maxExtent: maxExtent,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: Sizes.p32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
