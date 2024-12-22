import 'package:ai_crypto_alert/core/utils/vibration_util.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class MenuItem {
  const MenuItem({required this.text, required this.icon});
  final String text;
  final IconData icon;
}

List<MenuItem> dataSet = [
  const MenuItem(text: 'Thêm ngân sách', icon: MingCute.currency_dollar_2_line),
  const MenuItem(text: 'Ghi chép GD', icon: MingCute.edit_4_line),
  const MenuItem(text: 'Thêm danh mục', icon: MingCute.list_ordered_line),
];

class BottomBarActionMenuRow extends StatelessWidget {
  const BottomBarActionMenuRow({
    required this.controller,
    super.key,
    this.topPosition,
  });
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
            final index = dataSet.indexOf(item);
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1.0 + (3 * index)),
                end: const Offset(0, -0.2),
              ).animate(controller),
              child: PIconButton(
                item: item,
                onTap: () {
                  print("HUYHUY tapped ${item.text}");
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PIconButton extends StatefulWidget {
  const PIconButton({required this.item, required this.onTap, super.key});
  final MenuItem item;
  final VoidCallback onTap;

  @override
  State<PIconButton> createState() => _PIconButtonState();
}

class _PIconButtonState extends State<PIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.85,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    VibrationUtil.vibrate(context);

    await _controller.reverse(); // Shrink animation
    await _controller.forward(); // Return to normal
    widget.onTap(); // Trigger the original callback
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
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
                child: Icon(
                  widget.item.icon,
                  color: context.moonColors?.bulma,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.item.text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.moonColors?.goten,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
