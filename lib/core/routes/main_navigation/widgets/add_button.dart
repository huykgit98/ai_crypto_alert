import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class AddButton extends StatefulWidget {
  const AddButton({
    required this.onTap,
    this.label = '',
    super.key,
  });

  final void Function()? onTap;
  final String label;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    VibrationUtil.vibrate(context);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemSound.play(SystemSoundType.click);
    }
    widget.onTap!();
  }

  LinearGradient _buildGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        context.moonColors!.frieza60,
        context.moonColors!.whis,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;

    final backgroundColor = context.moonColors?.goku;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) =>
                        _buildGradient(context).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: const Icon(
                      OctIcons.copilot,
                      size: 48,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4), // Space between icon and label
            // Label
            Text(
              widget.label,
              style: TextStyle(
                color: context.moonColors?.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
