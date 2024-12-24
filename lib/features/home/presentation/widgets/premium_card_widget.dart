import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class PremiumCard extends StatelessWidget {
  const PremiumCard({
    required this.onClose,
    required this.onTap,
    this.premiumCardHeight = kToolbarHeight,
    super.key,
  });

  final VoidCallback onClose;
  final VoidCallback onTap;
  final double premiumCardHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.moonColors!.piccolo,
                  context.moonColors!.chichi,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: context.moonColors!.jiren,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: MoonMenuItem(
              backgroundColor: Colors.transparent,
              onTap: onTap,
              label: Text(
                'Get premium to unlock more features',
                style: context.moonTypography?.body.text14.copyWith(
                  color: context.moonColors?.goten,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(MingCute.gift_2_fill, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: premiumCardHeight - 8,
          child: GestureDetector(
            onTap: onClose,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.close, color: context.moonColors!.trunks),
            ),
          ),
        ),
      ],
    );
  }
}
