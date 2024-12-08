import 'dart:async';

import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  String get email => _textController.text;

  Timer? _resubmitTimer; // Timer for resubmission delay
  bool _canSubmit = true; // Boolean to track if resubmission is allowed

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _resubmitTimer
        ?.cancel(); // Dispose of the timer when the widget is disposed
    super.dispose();
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_canSubmit && _validateAndSaveForm()) {
      setState(() {
        _canSubmit = false; // Disable further submissions for 2 minutes
      });

      // final controller = ref.read(authControllerProvider.notifier);
      // final success = await controller.sendEmailResetPassword(email);

      // Show dialog to inform the user to check their email
      _showEmailSentDialog(context);

      // Start the resubmission delay timer
      _startResubmissionTimer();
    } else if (!_canSubmit) {
      // Show a dialog telling the user they need to wait to resubmit
      _showWaitToResubmitDialog(context);
    }
  }

  void _startResubmissionTimer() {
    _resubmitTimer = Timer(const Duration(minutes: 2), () {
      setState(() {
        _canSubmit = true; // Allow form submission after 2 minutes
      });
    });
  }

  // Show dialog when the email is successfully sent
  void _showEmailSentDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AdaptiveConfirmDialog(
          title: 'Email sent successfully'.hardcoded,
          content: 'Please check your email to reset your password'.hardcoded,
          confirmLabel: 'OK'.hardcoded,
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // Show dialog when the user tries to resubmit before the wait time is over
  void _showWaitToResubmitDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AdaptiveConfirmDialog(
          title: 'Please wait'.hardcoded,
          content: 'You need to wait before resubmitting'.hardcoded,
          confirmLabel: 'OK'.hardcoded,
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppBar(context),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final errorColor = colorTable(context)[40];

    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren(context),
        ),
      ),
    );
  }

  List<Widget> _buildFormChildren(BuildContext context) {
    return [
      Text(context.l10n.enterEmailAddress,
          style: context.moonTypography?.heading.text24),
      gapH8,
      Text(context.l10n.enterEmailAddressNotes),
      gapH32,
      Text(
        context.l10n.emailAddress,
        style: context.moonTypography?.heading.text12
            .copyWith(color: context.moonColors?.textPrimary),
      ),
      gapH8,
      MoonFormTextInput(
        textInputSize: MoonTextInputSize.lg,
        controller: _textController,
        errorColor: colorTable(context)[40],
        borderRadius: BorderRadius.circular(16),
        hintText: context.l10n.signInWithEmailHintText,
        validator: (String? value) => EmailValidator.validate(value)
            ? null
            : context.l10n.emailValidatorMessage,
        onTapOutside: (PointerDownEvent _) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        leading: const Icon(
          MoonIcons.mail_email_stats_24_light,
          size: 24,
        ),
      ),
      gapH16,
      PrimaryButton(
        onTap:
            _submit, // Allow submission, and handle inside the _submit method
        label: Text(
          _canSubmit
              ? context.l10n.verifyEmailAddress
              : 'Please wait'.hardcoded,
          style: TextStyle(
            color: context.moonColors?.textPrimary,
          ),
        ),
      ),
    ];
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
