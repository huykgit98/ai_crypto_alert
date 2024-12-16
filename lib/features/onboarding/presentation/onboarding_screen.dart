import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/onboarding/onboarding.dart';
import 'package:ai_crypto_alert/features/onboarding/presentation/widgets/top_row_widget.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: AppBar(
        actions: [
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
          const SizedBox(width: 16),
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      backgroundColor: context.moonColors!.goku,
      extendBodyBehindAppBar: true,
      body: CosmicGradientBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            maxContentWidth: 450,
            padding: const EdgeInsets.all(Sizes.p16),
            child: Stack(
              children: [
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
                                  BorderBeam(
                            duration: 7,
                            colorFrom: context.moonColors!.piccolo,
                            colorTo: context.moonColors!.chichi,
                            // staticBorderColor: const Color.fromARGB(
                            //     255, 39, 39, 42), //rgb(39 39 42)
                            borderRadius: BorderRadius.circular(20),

                            padding: const EdgeInsets.all(16),
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
                      selectedColor: context.moonColors!.piccolo,
                    ),
                    const SizedBox(height: 16),
                    AnimatedText(
                      text: context.l10n.welcomeToITree,
                      style: context.moonTypography?.heading.text24.copyWith(
                        color: context.moonColors!.goten,
                      ),
                      delay: 0,
                    ),
                    const SizedBox(height: 16),
                    AnimatedText(
                      text: context.l10n.onBoardingSubtitle1,
                      style: context.moonTypography?.body.text14.copyWith(
                        color: context.moonColors!.goten,
                      ),
                      delay: 300,
                    ),
                    const SizedBox(height: 8),
                    AnimatedText(
                      text: context.l10n.onBoardingSubtitle2,
                      style: context.moonTypography?.body.text14.copyWith(
                        color: context.moonColors!.goten,
                      ),
                      delay: 300,
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        AnimatedButton(
                          label: context.l10n.logIn,
                          delay: 600,
                          gradientColors: [
                            context.moonColors!.jiren,
                            context.moonColors!.piccolo,
                            context.moonColors!.jiren,
                          ],
                          onTap: state.isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(
                                        onboardingControllerProvider.notifier,
                                      )
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
                                        onboardingControllerProvider.notifier,
                                      )
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
