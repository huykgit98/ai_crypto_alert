// ignore_for_file: public_member_api_docs, sort_constructors_firstmport 'package:flutter/material.dart';
import 'package:ai_crypto_alert/core/routes/main_navigation/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavigationBar(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
  }
}

class ScaffoldWithNavigationBar extends ConsumerStatefulWidget {
  const ScaffoldWithNavigationBar({
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  ConsumerState<ScaffoldWithNavigationBar> createState() =>
      _ScaffoldWithNavigationBarState();
}

class _ScaffoldWithNavigationBarState
    extends ConsumerState<ScaffoldWithNavigationBar>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> _rotationAngle =
      Tween<double>(begin: 0, end: 0.5).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );

  late final Animation<Color?> _centerIconBackgroundColor = ColorTween(
    begin: const Color(0xFFFF3841),
    end: const Color(0xFFEAEAEA),
  ).animate(_controller);

  late final Animation<Color?> _centerIconForegroundColor = ColorTween(
    begin: Colors.white,
    end: Colors.black,
  ).animate(_controller);

  late final Animation<double?> _bottomBarActionMenuTopPosition = Tween<double>(
    begin: 800,
    end: 600,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _handleTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_controller.isCompleted) _controller.reverse();

    widget.onDestinationSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {
        'icon': MingCute.home_1_line,
        'selectedIcon': MingCute.home_1_fill,
        'label': context.l10n.home,
      },
      {
        'icon': MingCute.exchange_dollar_line,
        'selectedIcon': MingCute.exchange_dollar_fill,
        'label': context.l10n.transactions,
      },
      {
        'isAddButton': true, // Mark the 3rd tab as AddButton
      },
      {
        'icon': MingCute.pig_money_line,
        'selectedIcon': MingCute.pig_money_fill,
        'label': context.l10n.budgets,
      },
      {
        'icon': MingCute.settings_1_line,
        'selectedIcon': MingCute.settings_1_fill,
        'label': context.l10n.settings,
      },
    ];

    final tabWidth = MediaQuery.of(context).size.width / tabs.length;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent, // Capture taps anywhere outside
        onTap: () {
          if (_controller.isCompleted) {
            _controller.reverse(); // Hide BottomBarActionMenuRow
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                child!,
                // Animated Floating Action Menu
                BottomBarActionMenuRow(
                  topPosition: _bottomBarActionMenuTopPosition.value,
                  controller: _controller,
                ),
                // Bottom Navigation Bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: context.moonColors?.goku,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      children: tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tab = entry.value;

                        if (tab.containsKey('isAddButton') &&
                            tab['isAddButton'] == true) {
                          return SizedBox(
                              width: tabWidth); // Leave space for AddButton
                        }

                        return SizedBox(
                          width: tabWidth,
                          child: _buildNavTab(
                            context,
                            index,
                            tab['icon'] as IconData,
                            tab['selectedIcon'] as IconData,
                            tab['label'] as String,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AddButton(
                        onTap: () {
                          if (_currentIndex == 2) {
                            _controller.isCompleted
                                ? _controller.reverse()
                                : _controller.forward();
                            return;
                          }
                          _handleTap(2);
                        },
                        onLongTap: () {
                          _controller.isCompleted
                              ? _controller.reverse()
                              : _controller.forward();
                        },
                        label: 'Vi',
                        isSelected: _currentIndex == 2),
                  ),
                ),
              ],
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: kBottomNavigationBarHeight +
                  MediaQuery.of(context).padding.bottom,
            ),
            child: widget.body,
          ),
        ),
      ),
    );
  }

  Widget _buildNavTab(BuildContext context, int index, IconData icon,
      IconData selectedIcon, String label) {
    return NavTab(
      text: label,
      isSelected: _currentIndex == index,
      icon: FaIcon(icon, size: 24),
      selectedIcon: FaIcon(selectedIcon, size: 24),
      onTap: () => _handleTap(index),
    );
  }
}
