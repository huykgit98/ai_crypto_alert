// ignore_for_file: public_member_api_docs, sort_constructors_firstmport 'package:flutter/material.dart';
import 'package:ai_crypto_alert/core/routes/main_navigation/widgets/widgets.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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

class ScaffoldWithNavigationBar extends ConsumerWidget {
  const ScaffoldWithNavigationBar({
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  void _handleTap(int index) {
    onDestinationSelected(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseColor = context.moonColors!.heles;
    final highlightColor = context.moonColors!.heles.withOpacity(0.1);
    final itemColor = context.moonColors!.heles.withOpacity(0.5);

    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavTab(context, 0, FontAwesomeIcons.house, 'home'.hardcoded),
            _buildNavTab(
                context, 1, FontAwesomeIcons.userLarge, 'account'.hardcoded),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(
      BuildContext context, int index, IconData icon, String label) {
    return NavTab(
      text: label,
      isSelected: currentIndex == index,
      icon: FaIcon(icon, size: 18),
      selectedIcon: FaIcon(icon, size: 18),
      onTap: () => _handleTap(index),
    );
  }
}
