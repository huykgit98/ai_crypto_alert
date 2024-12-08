import 'dart:io';

import 'package:ai_crypto_alert/core/constants/app_sizes.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_design/moon_design.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
    this.onAppleTap,
    this.onGoogleTap,
  });
  final VoidCallback? onAppleTap;
  final VoidCallback? onGoogleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Platform.isIOS)
          MoonFilledButton(
            onTap: () {
              onAppleTap!();
            },
            isFullWidth: true,
            borderRadius: BorderRadius.circular(16),
            buttonSize: MoonButtonSize.lg,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 6),
                  child: FaIcon(
                    FontAwesomeIcons.apple,
                    size: 24,
                    color: context.moonColors?.goku,
                  ),
                ),
                gapW8,
                Text(
                  context.l10n.continueWithApple,
                  style: TextStyle(color: context.moonColors?.goku),
                ),
              ],
            ),
            backgroundColor: context.moonColors?.textPrimary,
          ),
        gapH16,
        MoonOutlinedButton(
          isFullWidth: true,
          borderRadius: BorderRadius.circular(16),
          buttonSize: MoonButtonSize.lg,
          onTap: () {
            onGoogleTap!();
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.icons.google.path,
                width: 24,
                height: 24,
              ),
              gapW8,
              Text(
                context.l10n.continueWithGoogle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
