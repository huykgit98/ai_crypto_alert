import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/authentication/presentation/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class CustomSignUpScreen extends ConsumerStatefulWidget {
  const CustomSignUpScreen({
    super.key,
  });

  @override
  ConsumerState<CustomSignUpScreen> createState() => _CustomSignUpState();
}

class _CustomSignUpState extends ConsumerState<CustomSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        return false;
      }
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    // if (_validateAndSaveForm()) {
    //   final controller = ref.read(authControllerProvider.notifier);
    //   final success = await controller.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //     formType: EmailPasswordSignInFormType.register,
    //   );
    //
    //   if (success) {
    //     if (!mounted) return;
    //     context.goNamed(AppRoute.home.name);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(authControllerProvider);
    // ref.listen<AsyncValue>(
    //   authControllerProvider,
    //   (_, state) => state.showToastOnError(context),
    // );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _buildContents(context),
          // if (state.isLoading) const OverlayLoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final systemTopPadding = MediaQuery.of(context).padding.top;
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: ColoredBox(
          color: context.moonColors!.goku,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthAppBar(
                title: context.l10n.signUp,
                backgroundColor: context.moonColors!.goku,
              ),
              Container(
                height: screenHeight - appBarHeight - systemTopPadding,
                decoration: BoxDecoration(
                  gradient: context.topLeftRadialGradient,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: Particles(
                        ease: 80,
                        color: Colors.white,
                        key: ValueKey(Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 48,
                      child: Transform.rotate(
                        angle: 180,
                        child: Icon(
                          MingCute.bling_fill,
                          size: 32,
                          color: context.moonColors?.frieza60,
                        ).animate().scale(
                              duration: 2500.ms,
                              begin: Offset.zero,
                              end: const Offset(1, 1),
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      right: 60,
                      child: Transform.rotate(
                        angle: 90,
                        child: Icon(
                          MingCute.bling_fill,
                          size: 32,
                          color: context.moonColors?.frieza60,
                        ).animate().scale(
                              duration: 1000.ms,
                              begin: Offset.zero,
                              end: const Offset(1, 1),
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      left: 60,
                      child: Transform.rotate(
                        angle: 180,
                        child: Icon(
                          Icons.auto_awesome,
                          size: 48,
                          color: context.moonColors?.frieza60,
                        ).animate().scale(
                              duration: 1500.ms,
                              begin: Offset.zero,
                              end: const Offset(1.5, 1.5),
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                    Positioned(
                      bottom: 260,
                      right: 60,
                      child: Transform.rotate(
                        angle: 90,
                        child: Icon(
                          Icons.auto_awesome,
                          size: 32,
                          color: context.moonColors?.frieza60,
                        ).animate().scale(
                              duration: 1500.ms,
                              begin: Offset.zero,
                              end: const Offset(1.2, 1.2),
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.p16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SignInLogoWidget(),
                          gapH16,
                          _buildForm(context),
                          Expanded(
                            child: AuthPrompt(
                              promptText: context.l10n.signInPrompt,
                              actionText: context.l10n.signIn,
                              routeName: AppRoute.signIn.name,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(context),
      ),
    );
  }

  List<Widget> _buildFormChildren(BuildContext context) {
    final errorColor = context.moonColors?.chichi60;

    return [
      Text(
        context.l10n.emailAddress,
        style: context.moonTypography?.heading.text12
            .copyWith(color: context.moonColors?.textPrimary),
      ),
      gapH8,
      MoonFormTextInput(
        textInputSize: MoonTextInputSize.lg,
        controller: _emailController,
        errorColor: errorColor,
        borderRadius: BorderRadius.circular(16),
        hintText: context.l10n.signInWithEmailHintText,
        validator: (String? value) => EmailValidator.validate(value)
            ? null
            : context.l10n.emailValidatorMessage,
        onTapOutside: (PointerDownEvent _) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        leading: const Icon(MingCute.at_line, size: 20),
      ),
      gapH16,
      Text(
        context.l10n.password,
        style: context.moonTypography?.heading.text12
            .copyWith(color: context.moonColors?.textPrimary),
      ),
      gapH8,
      MoonFormTextInput(
        textInputSize: MoonTextInputSize.lg,
        borderRadius: BorderRadius.circular(16),
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _hidePassword,
        errorColor: errorColor,
        hintText: context.l10n.passwordHintText,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return context.l10n.passwordValidatorEmptyMessage;
          } else if (value.length < 8) {
            return context.l10n.passwordValidatorLengthMessage;
          } else if (!RegExp(
                  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
              .hasMatch(value)) {
            return context.l10n.passwordValidatorComplexityMessage;
          }
          return null;
        },
        onTapOutside: (PointerDownEvent _) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        leading: const Icon(MingCute.key_1_line, size: 20),
        trailing: GestureDetector(
          onTap: () => setState(() => _hidePassword = !_hidePassword),
          child: Icon(
            _hidePassword
                ? MoonIcons.controls_eye_crossed_24_light
                : MoonIcons.controls_eye_24_light,
            size: 24,
          ),
        ),
      ),
      gapH16,
      Text(
        context.l10n.confirmPassword,
        style: context.moonTypography?.heading.text12
            .copyWith(color: context.moonColors?.textPrimary),
      ),
      gapH8,
      MoonFormTextInput(
        textInputSize: MoonTextInputSize.lg,
        borderRadius: BorderRadius.circular(16),
        controller: _confirmPasswordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _hideConfirmPassword,
        errorColor: errorColor,
        hintText: context.l10n.passwordHintText,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return context.l10n.passwordValidatorEmptyMessage;
          } else if (value != _passwordController.text) {
            return context.l10n.passwordValidatorMatchMessage;
          }
          return null;
        },
        onTapOutside: (PointerDownEvent _) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        leading: const Icon(MingCute.key_1_line, size: 20),
        trailing: GestureDetector(
          onTap: () =>
              setState(() => _hideConfirmPassword = !_hideConfirmPassword),
          child: Icon(
            _hideConfirmPassword
                ? MoonIcons.controls_eye_crossed_24_light
                : MoonIcons.controls_eye_24_light,
            size: 24,
          ),
        ),
      ),
      gapH32,
      PrimaryButton(
        onTap: _submit,
        label: Text(
          context.l10n.signUp,
          style: TextStyle(color: context.moonColors?.textPrimary),
        ),
      ),
      TextDivider(text: 'OR'.hardcoded),
      SocialButtons(
        onAppleTap: () async {
          // final success =
          //     await ref.read(authControllerProvider.notifier).signInWithApple();
          // if (success) {
          //   if (!mounted) return;
          //   context.goNamed(AppRoute.home.name);
          // }
        },
        onGoogleTap: () async {
          // final success = await ref
          //     .read(authControllerProvider.notifier)
          //     .signInWithGoogle();
          // if (success) {
          //   if (!mounted) return;
          //   context.goNamed(AppRoute.home.name);
          // }
        },
      ),
    ];
  }
}
