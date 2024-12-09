import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInLogoWidget extends StatelessWidget {
  const SignInLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.lotties.eRobo,
      width: 90,
      height: 90,
      fit: BoxFit.contain,
      decoder: customLottieDecoder,
    );
  }
}
