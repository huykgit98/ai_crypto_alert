import 'package:ai_crypto_alert/core/enums/enums.dart';
import 'package:ai_crypto_alert/core/exceptions/app_exceptions.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A helper [AsyncValue] extension to show a toast on error
extension AsyncValueUI on AsyncValue<dynamic> {
  /// show a toast if the current [AsyncValue] has an error and the
  /// state is not loading.
  void showToastOnError(
    BuildContext context,
  ) {
    if (!isLoading && hasError) {
      final message = _errorMessage(context, error);
      AlertNotification.show(
        context,
        title: message,
        variant: AlertVariant.error,
      );
    }
  }

  void showAdaptiveDialogOnError(BuildContext context, DialogType dialogType,
      {String? title}) {
    if (!isLoading && hasError) {
      final message = _errorMessage(
        context,
        error,
      );

      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AdaptiveConfirmDialog(
            title: title,
            dialogType: dialogType,
            content: message,
            confirmLabel: 'OK'.hardcoded,
            onConfirm: () async {},
          );
        },
      );
    }
  }

  String _errorMessage(BuildContext context, Object? error) {
    // if (error is FirebaseAuthException) {
    //   if (error.code == 'invalid-credential') {
    //     return error.message ?? 'Invalid credential'.hardcoded;
    //     // return context.l10n.signUpInvalidCredentialError;
    //   } else if (error.code == 'email-already-in-use') {
    //     return error.message ?? 'Email already in use'.hardcoded;
    //     // return context.l10n.signUpEmailAlreadyInUseError;
    //   }
    //   return error.message ?? error.toString();
    // } else
    if (error is PlatformException &&
        error.code == 'storekit_duplicate_product_object') {
      return 'There is a pending transaction for the product "${error.details['productIdentifier']}". Please wait for it to be completed.'
          .hardcoded;
    } else if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }
}
