import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';

class IconImgButton extends StatelessWidget {
  const IconImgButton(
    this.iconData, {
    required this.onTap,
    super.key,
    this.size = 32,
    this.padding = 4,
    this.backgroundColor = Colors.black26,
    this.backgroundRadius,
  });

  final IconData iconData;
  final double size;
  final double padding;
  final Color? backgroundColor;
  final double? backgroundRadius;
  final VoidCallback onTap;

  static const double tapTargetSize = kMinInteractiveDimension;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: context.darkMode ? Colors.white70 : const Color(0xFF556B2F),
      ),
      iconSize: size - padding * 2,
      padding: EdgeInsets.all(padding),
      constraints: BoxConstraints(
        maxWidth: size,
        maxHeight: size,
      ),
      style: IconButton.styleFrom(
        // Expands the minimum tap target size to 48px by 48px.
        tapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: backgroundColor,
        shape: backgroundRadius == null
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(backgroundRadius!),
              ),
      ),
      onPressed: onTap,
    );
  }
}
