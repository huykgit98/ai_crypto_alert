import 'package:ai_crypto_alert/core/utils/string_utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moon_design/moon_design.dart';

class NotificationsSettingScreen extends HookWidget {
  const NotificationsSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const expandedBarHeight = 180.0;

    final scrollController = useScrollController();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          CustomAnimatedAppBar(
            title: 'Notifications'.hardcoded,
            expandedHeight: expandedBarHeight,
            scrollController: scrollController,
            flexibleSpaceContent: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MoonMenuItem(
                  onTap: () {},
                  label: const Text('Menu Item'),
                  leading: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: context.moonColors?.frieza10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(MoonIcons.arrows_boost_24_light),
                  ),
                  content: const Text('Content '),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Item $index'),
              ),
              childCount: 20, // Number of mock items
            ),
          ),
        ],
      ),
    );
  }
}
