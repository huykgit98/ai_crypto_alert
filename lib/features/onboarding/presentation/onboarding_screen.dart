import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/onboarding/onboarding.dart';
import 'package:ai_crypto_alert/features/onboarding/presentation/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int selectedDot = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);

    return Scaffold(
      backgroundColor: context.moonColors!.goku,
      body: MeshRadialGradientBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            maxContentWidth: 450,
            padding: const EdgeInsets.all(Sizes.p16),
            child: Stack(
              children: [
                TopRow(
                  isLoading: state.isLoading,
                  onLanguageTap: () => bottomSheetBuilder(
                    context: context,
                    child: const LanguageSettingSheet(),
                  ),
                  onThemeTap: () => bottomSheetBuilder(
                    context: context,
                    child: const ThemeSettingSheet(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 360,
                      child: OverflowBox(
                        maxWidth: MediaQuery.of(context).size.width,
                        child: MoonCarousel(
                          gap: 32,
                          itemCount: 3,
                          itemExtent: MediaQuery.of(context).size.width - 32,
                          physics: const PageScrollPhysics(),
                          onIndexChanged: (int index) =>
                              setState(() => selectedDot = index),
                          itemBuilder:
                              (BuildContext context, int itemIndex, int _) =>
                                  Container(
                            decoration: ShapeDecoration(
                              color: context.moonColors!.heles,
                              shape: MoonSquircleBorder(
                                borderRadius: BorderRadius.circular(12)
                                    .squircleBorderRadius(context),
                              ),
                            ),
                            child: Center(
                              child: Text('${itemIndex + 1}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MoonDotIndicator(
                      selectedDot: selectedDot,
                      dotCount: 3,
                      selectedColor: context.moonColors!.bulma,
                    ),
                    const SizedBox(height: 16),
                    AnimatedText(
                      text: context.l10n.welcomeToITree,
                      style: context.moonTypography?.heading.text24.copyWith(),
                      delay: 0,
                    ),
                    const SizedBox(height: 16),
                    AnimatedText(
                      text: context.l10n.onBoardingSubtitle1,
                      style: context.moonTypography?.body.text14.copyWith(),
                      delay: 300,
                    ),
                    const SizedBox(height: 8),
                    AnimatedText(
                      text: context.l10n.onBoardingSubtitle2,
                      style: context.moonTypography?.body.text14.copyWith(),
                      delay: 300,
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        AnimatedButton(
                          label: context.l10n.logIn,
                          delay: 600,
                          gradientColors: [
                            context.moonColors!.frieza60,
                            context.moonColors!.piccolo,
                          ],
                          onTap: state.isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(
                                          onboardingControllerProvider.notifier)
                                      .completeOnboarding();
                                  if (context.mounted) {
                                    context.goNamed(AppRoute.signIn.name);
                                  }
                                },
                        ),
                        gapH16,
                        AnimatedButton(
                          label: context.l10n.signUp,
                          delay: 800,
                          onTap: state.isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(
                                          onboardingControllerProvider.notifier)
                                      .completeOnboarding();
                                  if (context.mounted) {
                                    context.goNamed(AppRoute.signUp.name);
                                  }
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
