import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class MenuItem {
  const MenuItem({required this.text, required this.icon});
  final String text;
  final IconData icon;
}

const List<MenuItem> dataSet = [
  MenuItem(text: 'Add Place', icon: Icons.location_on),
  MenuItem(text: 'Create List', icon: Icons.view_list_rounded),
  MenuItem(text: 'Add Friend', icon: Icons.person_add_alt_1_rounded)
];

class BottomBarActionMenuRow extends StatelessWidget {
  const BottomBarActionMenuRow(
      {super.key, this.topPosition, required this.controller});
  final double? topPosition;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 180,
      top: topPosition,
      left: 0,
      right: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.moonColors!.jiren.withValues(alpha: 0.7),
              context.moonColors!.jiren.withValues(alpha: 0.55),
              context.moonColors!.jiren.withValues(alpha: 0.25),
              context.moonColors!.jiren.withValues(alpha: 0.015),
              context.moonColors!.jiren.withValues(alpha: 0.005),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.55, 0.65, 0.75, 0.85, 0.95],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: dataSet.map((item) {
            int index = dataSet.indexOf(item);
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1.0 + (3 * index)),
                end: const Offset(0, -0.2),
              ).animate(controller),
              child: PIconButton(item: item),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PIconButton extends StatelessWidget {
  const PIconButton({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: context.moonColors?.goku,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(item.icon, color: context.moonColors?.bulma, size: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          item.text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: context.moonColors?.goten,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
