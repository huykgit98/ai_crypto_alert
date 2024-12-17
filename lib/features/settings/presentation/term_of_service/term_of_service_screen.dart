import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moon_design/moon_design.dart';

class TermOfServiceScreen extends HookWidget {
  const TermOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const collapsedBarHeight = 60.0;
    const expandedBarHeight = 180.0;

    final scrollController = useScrollController();
    final isCollapsed = useState(false);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          isCollapsed.value = scrollController.hasClients &&
              scrollController.offset >
                  (expandedBarHeight - collapsedBarHeight);
          return false;
        },
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isCollapsed.value ? 0 : 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.moonColors!.frieza10.withValues(alpha: .3),
                      context.moonColors!.frieza10.withValues(alpha: .1),
                      context.moonColors!.goku.withValues(alpha: 0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.center,
                  ),
                ),
              ),
            ),
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: expandedBarHeight,
                  collapsedHeight: collapsedBarHeight,
                  centerTitle: false,
                  pinned: true,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isCollapsed.value ? 1 : 0,
                    child: const Text(
                      'My Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  backgroundColor: context.moonColors?.goku
                      .withValues(alpha: isCollapsed.value ? 1 : 0),
                  leading: const BackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
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
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const ListTile(
                      title: Text('Item \$index'),
                    ),
                    childCount: 20, // Number of mock items
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
