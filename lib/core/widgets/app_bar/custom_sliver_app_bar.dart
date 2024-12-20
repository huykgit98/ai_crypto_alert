import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    this.trailing,
    this.leading,
    this.gradient,
    this.padding = EdgeInsets.zero,
    this.pinned = true,
  });

  final Widget? title;
  final Widget? trailing;
  final Widget? leading;
  final List<Color>? gradient;
  final EdgeInsetsGeometry padding;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned,
      backgroundColor: context.moonColors!.gohan,
      scrolledUnderElevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: title,
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient ??
                    [
                      context.moonColors!.frieza60,
                      context.moonColors!.jiren,
                    ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      leading: leading,
      actions: [if (trailing != null) trailing!],
    );
  }
}
