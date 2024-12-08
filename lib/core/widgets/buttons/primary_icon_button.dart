import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moon_design/moon_design.dart';

class PrimaryIconButton extends StatefulWidget {
  const PrimaryIconButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final void Function()? onTap;

  @override
  State<PrimaryIconButton> createState() => _PrimaryIconButtonState();
}

class _PrimaryIconButtonState extends State<PrimaryIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
      widget.onTap?.call();
    });
  }

  LinearGradient _buildGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        context.moonColors?.roshi ?? Colors.green,
        context.moonColors?.whis ?? Colors.green,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        VibrationUtil.vibrate(context);
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          SystemSound.play(SystemSoundType.click);
        }
        _handleTap();
      },
      child: SizedBox(
        width: 80,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) =>
                    _buildGradient(context).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: widget.icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
