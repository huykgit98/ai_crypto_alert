import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/repositories/authentication/auth_repository.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends ConsumerWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            MoonButton(
              onTap: () {
                // final isLoggedIn =
                //     ref.watch(authRepositoryProvider).currentUser != null;
                // context.goNamed(
                //     isLoggedIn ? AppRoute.home.name : AppRoute.signIn.name);
              },
              label: Text(
                'Go back to home'.hardcoded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
