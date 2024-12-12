import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moon_design/moon_design.dart';

class NavTab extends StatefulWidget {
  const NavTab({
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    super.key,
  });

  final String text;
  final bool isSelected;
  final Widget icon;
  final Widget selectedIcon;
  final void Function()? onTap;

  @override
  State<NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> with SingleTickerProviderStateMixin {
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

  LinearGradient _buildGradient(bool isSelected, BuildContext context) {
    return LinearGradient(
      colors: [
        if (isSelected)
          context.moonColors!.frieza60
        else
          context.moonColors!.textPrimary.withOpacity(0.3),
        if (isSelected)
          context.moonColors!.whis
        else
          context.moonColors!.textPrimary.withOpacity(0.5),
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
        // Do nothing if the tapped tab is the current tab
        if (widget.isSelected) return;

        VibrationUtil.vibrate(context);
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          SystemSound.play(SystemSoundType.click);
        }
        _handleTap();
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
          // top: Sizes.p8,
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) =>
                    _buildGradient(widget.isSelected, context)
                        .createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: widget.isSelected ? widget.selectedIcon : widget.icon,
              ),
              gapH4,
              Text(
                widget.text,
                style: context.moonTypography?.heading.textDefault.copyWith(
                  color: context.moonColors?.textPrimary
                      .withOpacity(widget.isSelected ? 1 : 0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
