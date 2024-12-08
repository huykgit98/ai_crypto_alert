import 'package:ai_crypto_alert/core/constants/app_sizes.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';

class AuthPrompt extends StatelessWidget {
  final String promptText;
  final String actionText;
  final String routeName;

  const AuthPrompt({
    Key? key,
    required this.promptText,
    required this.actionText,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: TextStyle(
            color: context.moonColors?.textSecondary,
          ),
        ),
        gapW8,
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            VibrationUtil.vibrate(context);
            context.goNamed(routeName);
          },
          child: Text(
            actionText,
            style: context.moonTypography!.heading.textDefault.copyWith(
              color: context.moonColors?.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
