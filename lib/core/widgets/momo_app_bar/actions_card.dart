import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';

const double _kRadius = 12;

class ActionsCard extends StatelessWidget {
  const ActionsCard({
    required this.contentPadding,
    required this.borderRadius,
    super.key,
  });

  final EdgeInsetsGeometry contentPadding;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardPainter(isDarkMode: context.darkMode),
      child: Padding(
        padding: contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultTextStyle(
              style: TextStyle(
                color: context.darkMode ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'huhuhuhu'.hardcoded,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'huhuhu'.hardcoded,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'huhuhu'.hardcoded,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'huhuhu'.hardcoded,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardPainter extends CustomPainter {
  _CardPainter({required this.isDarkMode});
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    paintActionArea(canvas, size);
  }

  void paintActionArea(Canvas canvas, Size size) {
    final stopX = size.width;
    final stopY = size.height;

    final rrect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, stopX, stopY),
      topLeft: const Radius.circular(_kRadius),
      topRight: const Radius.circular(_kRadius),
      bottomLeft: const Radius.circular(_kRadius),
      bottomRight: const Radius.circular(_kRadius),
    );
    final paint = Paint()
      ..color = isDarkMode ? Colors.black : Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
