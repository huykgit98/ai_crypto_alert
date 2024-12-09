import 'package:ai_crypto_alert/features/authentication/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    required this.title,
    required this.backgroundColor,
    super.key,
  });
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [
        CloseButtonWidget(),
      ],
      title: Text(title),
      backgroundColor: backgroundColor,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
