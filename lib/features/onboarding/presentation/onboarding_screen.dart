import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/enums/enums.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/onboarding/onboarding.dart';
import 'package:ai_crypto_alert/gen/assets.gen.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          _buildUI(context, ref),
        ],
      ),
    );
  }

  Widget _buildUI(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ResponsiveCenter(
        maxContentWidth: 450,
        padding: const EdgeInsets.all(Sizes.p16),
        child: Stack(
          children: [
            _buildTopRow(context, ref),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text Sections with Animation
                _buildAnimatedText(
                  text: context.l10n.welcomeToITree,
                  style: context.moonTypography?.heading.text24.copyWith(
                    color: Colors.white,
                  ),
                  delay: 0,
                ),
                const SizedBox(height: 16),
                _buildAnimatedText(
                  text: context.l10n.onBoardingSubtitle1,
                  style: context.moonTypography?.body.text14.copyWith(
                    color: Colors.white70,
                  ),
                  delay: 300,
                ),
                const SizedBox(height: 8),
                _buildAnimatedText(
                  text: context.l10n.onBoardingSubtitle2,
                  style: context.moonTypography?.body.text14.copyWith(
                    color: Colors.white70,
                  ),
                  delay: 300,
                ),
                const SizedBox(height: 32),
                _buildButtons(context, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);

    return Positioned(
      top: 0,
      right: 0,
      child: Row(
        children: [
          MoonButton(
            buttonSize: MoonButtonSize.sm,
            onTap: state.isLoading
                ? null
                : () => bottomSheetBuilder(
                      context: context,
                      child: const LanguageSettingSheet(),
                    ),
            leading: Image.asset(
              context.l10n.localeName == LanguageCode.en.name
                  ? Assets.icons.usFlag.path
                  : Assets.icons.vnFlag.path,
              width: 24,
              height: 24,
            ),
            label: Text(
              context.l10n.localeName == LanguageCode.en.name
                  ? context.l10n.english
                  : context.l10n.vietnamese,
            ),
          ),
          const SizedBox(width: 8),
          MoonButton.icon(
            buttonSize: MoonButtonSize.sm,
            onTap: state.isLoading
                ? null
                : () => bottomSheetBuilder(
                      context: context,
                      child: const ThemeSettingSheet(),
                    ),
            icon: const Icon(MingCute.brightness_line),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText({
    required String text,
    required TextStyle? style,
    required int delay,
  }) {
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms, delay: delay.ms),
        ScaleEffect(
            duration: 500.ms, delay: delay.ms, begin: const Offset(0.8, 0.8)),
      ],
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Button 1: Login
        _buildAnimatedButton(
          context: context,
          label: context.l10n.logIn,
          gradientColors: [
            context.moonColors?.whis ?? Colors.green,
            context.moonColors?.gohan ?? Colors.green,
          ],
          delay: 600, // Delay for the first button
          onTap: state.isLoading
              ? null
              : () async {
                  await ref
                      .read(onboardingControllerProvider.notifier)
                      .completeOnboarding();
                  if (context.mounted) {
                    context.goNamed(AppRoute.signIn.name);
                  }
                },
        ),
        gapH16,

        // Button 2: Sign Up
        _buildAnimatedButton(
          context: context,
          label: context.l10n.signUp,
          borderColor: const Color(0xFF52C234),
          delay: 800, // Delay for the second button
          onTap: state.isLoading
              ? null
              : () async {
                  await ref
                      .read(onboardingControllerProvider.notifier)
                      .completeOnboarding();
                  if (context.mounted) {
                    context.goNamed(AppRoute.signUp.name);
                  }
                },
        ),
        gapH16,
      ],
    );
  }

  Widget _buildAnimatedButton({
    required BuildContext context,
    required String label,
    required VoidCallback? onTap,
    required int delay,
    List<Color>? gradientColors,
    Color? borderColor,
  }) {
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms, delay: delay.ms),
        ScaleEffect(
            duration: 500.ms, delay: delay.ms, begin: const Offset(0.8, 0.8)),
      ],
      child: gradientColors != null
          ? PrimaryButton(
              onTap: onTap,
              label: Text(label),
              gradientColors: gradientColors,
            )
          : MoonOutlinedButton(
              buttonSize: MoonButtonSize.lg,
              borderColor: borderColor ?? Colors.white,
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              label: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
