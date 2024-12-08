import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({
    required this.text,
    this.paddingTop = 48,
    this.paddingBottom = 32,
    this.gradientColors = const [Color(0xFF952DCA), Color(0xFFC78FED)],
    super.key,
  });

  final String text;

  final double paddingTop;

  final double paddingBottom;
  final List<Color> gradientColors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: gradientColors.isNotEmpty
                    ? LinearGradient(
                        colors: gradientColors,
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
            child: Text(
              text,
              style: context.moonTypography?.body.text12
                  .copyWith(color: context.moonColors?.trunks),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: gradientColors.isNotEmpty
                    ? LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
