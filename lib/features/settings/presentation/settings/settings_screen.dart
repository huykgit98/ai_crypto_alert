import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/utils/string_utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/settings/data/profile_repository.dart';
import 'package:ai_crypto_alert/features/settings/presentation/settings_controller.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsControllerProvider);
    final userProfile = ref.watch(profileFutureProvider).value;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CustomSliverAppBar(
          title: Text(
            'Settings'.hardcoded,
            style: context.moonTypography?.heading.text20
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: 16),
              _buildSection(
                title: 'account',
                items: [
                  // _menuItem(
                  //     context, context.l10n.myDetails, MingCute.user_3_fill,
                  //     onTap: () {
                  //   context.goNamed(AppRoute.myDetails.name);
                  // }, content: userProfile?.displayName ?? user?.email ?? ''),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(title),
        _buildItems(child: Column(children: items)),
      ],
    );
  }

  Widget _buildHeaderSection(String title, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      color: context.moonColors?.beerus,
      child: Text(
        title,
        style: context.moonTypography?.heading.text16.copyWith(
          fontWeight: FontWeight.bold,
          color: color ?? context.moonColors?.textPrimary,
        ),
      ),
    );
  }

  Widget _buildItems({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: context.moonColors?.raditz,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _menuItem(BuildContext context, String label, IconData icon,
      {VoidCallback? onTap, String? content, Color? color, Widget? trailing}) {
    return MoonMenuItem(
      onTap: onTap,
      label: Text(
        label,
        style: context.moonTypography?.body.textDefault.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      content: content != null
          ? Text(
              content,
              style: context.moonTypography?.body.textDefault
                  .copyWith(fontSize: 14),
            )
          : null,
      leading: Icon(icon, color: color),
      trailing:
          trailing ?? const Icon(MoonIcons.controls_chevron_right_24_light),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    final l10n = context.l10n;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AdaptiveConfirmDialog(
          title: l10n.signOut,
          content: 'Are you sure you want to sign out?'.hardcoded,
          cancelLabel: 'Cancel'.hardcoded,
          confirmLabel: l10n.signOut,
          onConfirm: () async {
            await ref.read(settingsControllerProvider.notifier).signOut();
            if (context.mounted) {
              context.goNamed(AppRoute.onboarding.name);
            }
          },
        );
      },
    );
  }
}
