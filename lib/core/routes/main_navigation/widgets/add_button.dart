import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class AddButton extends StatefulWidget {
  const AddButton({
    required this.onTap,
    this.onLongTap,
    this.label = '',
    this.rotationAngle = 0.5,
    this.centerIconBackgroundColor,
    this.centerIconForegroundColor,
    this.showAnimatedFabMenu = false,
    this.isSelected = false, // New isSelected param
    super.key,
  });

  final void Function()? onTap;
  final void Function()? onLongTap;
  final String label;
  final double? rotationAngle;
  final Color? centerIconBackgroundColor;
  final Color? centerIconForegroundColor;
  final bool showAnimatedFabMenu;
  final bool? isSelected; // Indicates selection state

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
    if (widget.onTap != null) {
      widget.onTap?.call();
    }
  }

  void _onLongPressStart(LongPressStartDetails details) {
    if (widget.onLongTap != null) {
      HapticFeedback.selectionClick();

      widget.onLongTap?.call();
    }
    _controller.forward(); // Scale up
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    _controller.reverse(); // Reverse the scale effect
  }

  LinearGradient _buildGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        context.moonColors!.frieza,
        context.moonColors!.whis,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onLongPressStart: _onLongPressStart, // Start long press
      onLongPressEnd: _onLongPressEnd, // End long press
      child: Transform.scale(
        scale: _scale,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: context.moonColors?.goku,
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
            // Label
            Text(
              widget.label,
              style: GoogleFonts.zillaSlab(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.moonColors?.piccolo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
