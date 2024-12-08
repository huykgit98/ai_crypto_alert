import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    this.size = 24.0,
    this.color,
  });
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator.adaptive(
        backgroundColor: color ?? context.moonColors?.piccolo,
      ),
    );
  }
}
