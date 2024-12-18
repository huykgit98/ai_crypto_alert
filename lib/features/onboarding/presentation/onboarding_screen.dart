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
  bool _isVisible = true; // For text animations
  bool _showButtons =
      true; // Ensure buttons remain visible after the first load

  // Content for each carousel page
  final List<String> titles = [
    "Welcome to Vega - AI Money Tracker 💰",
    "Track Your Spending 🧾",
    "Achieve Your Financial Goals 🚀",
  ];

  final List<String> subtitles1 = [
    "Your personal AI-powered assistant for managing money.",
    "Easily monitor expenses, income, and savings in real time.",
    "Set goals and watch your savings grow efficiently.",
  ];

  final List<String> subtitles2 = [
    "AI insights to help you take control of your finances.",
    "Track every dollar to make smarter spending decisions.",
    "Turn your dreams into reality with focused budgeting.",
  ];

  void _onCarouselIndexChanged(int index) {
    setState(() {
      _isVisible = false; // Fade out text
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        selectedDot = index; // Update selected carousel index
        _isVisible = true; // Fade-in text
      });
    });
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Carousel
                    SizedBox(
                      height: 300,
                      child: OverflowBox(
                        maxWidth: MediaQuery.of(context).size.width,
                        child: MoonCarousel(
                          gap: 32,
                          itemCount: 3,
                          itemExtent: MediaQuery.of(context).size.width - 32,
                          physics: const PageScrollPhysics(),
                          onIndexChanged: _onCarouselIndexChanged,
                          itemBuilder:
                              (BuildContext context, int itemIndex, int _) =>
                                  BorderBeam(
                            duration: 7,
                            colorFrom: context.moonColors!.piccolo,
                            colorTo: context.moonColors!.chichi,
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
                    const SizedBox(height: 32),

                    // BlurFade synced with carousel for titles and subtitles
                    BlurFade(
                      isVisible: _isVisible,
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        titles[selectedDot],
                        style: context.moonTypography?.heading.text20.copyWith(
                          color: context.moonColors!.goten,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    BlurFade(
                      delay: const Duration(milliseconds: 400),
                      isVisible: _isVisible,
                      child: Text(
                        subtitles1[selectedDot],
                        style: context.moonTypography?.body.text14.copyWith(
                          color: context.moonColors!.goten,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlurFade(
                      delay: const Duration(milliseconds: 600),
                      isVisible: _isVisible,
                      child: Text(
                        subtitles2[selectedDot],
                        style: context.moonTypography?.body.text14.copyWith(
                          color: context.moonColors!.goten,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Buttons (only animate once on initial load)
                    Column(
                      children: [
                        BlurFade(
                          isVisible: _showButtons,
                          delay: const Duration(milliseconds: 600),
                          child: PrimaryButton(
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
                            label: Text(
                              context.l10n.logIn,
                              style:
                                  TextStyle(color: context.moonColors!.goten),
                            ),
                            gradientColors: [
                              context.moonColors!.piccolo,
                              context.moonColors!.jiren,
                              context.moonColors!.chichi10,
                            ],
                            isFullWidth: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlurFade(
                          isVisible: _showButtons,
                          delay: const Duration(milliseconds: 800),
                          child: MoonOutlinedButton(
                            buttonSize: MoonButtonSize.lg,
                            borderColor: context.moonColors!.textSecondary,
                            borderRadius: BorderRadius.circular(16),
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
                            label: Text(
                              context.l10n.signUp,
                              style:
                                  TextStyle(color: context.moonColors!.goten),
                            ),
                            isFullWidth: true,
                          ),
                          // ElevatedButton(
                          //   onPressed: state.isLoading
                          //       ? null
                          //       : () async {
                          //           await ref
                          //               .read(
                          //                 onboardingControllerProvider.notifier,
                          //               )
                          //               .completeOnboarding();
                          //           if (context.mounted) {
                          //             context.goNamed(AppRoute.signUp.name);
                          //           }
                          //         },
                          //   style: ElevatedButton.styleFrom(
                          //     minimumSize: const Size(double.infinity, 48),
                          //   ),
                          //   child: Text(context.l10n.signUp),
                          // ),
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
