import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/core/utils/string_utils.dart';
import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/settings/settings.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
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
    // final user =
    //     ref.watch(settingsControllerProvider.notifier).getCurrentUser();
    // final userProfile = ref.watch(profileFutureProvider).value;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CustomSliverAppBar(
          title: Text(
            context.l10n.settings,
            style: context.moonTypography?.heading.text20
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: 16),
              _buildSection(
                title: context.l10n.account,
                items: [
                  _menuItem(
                      context, context.l10n.myDetails, MingCute.user_3_fill,
                      onTap: () {
                    context.goNamed(AppRoute.myDetails.name);
                  }, content: 'wibu'),
                  _menuItem(context, context.l10n.manageBilling,
                      MingCute.wallet_3_fill, onTap: () {
                    context.goNamed(AppRoute.manageBilling.name);
                  }),
                  _menuItem(context, context.l10n.friendInvitation,
                      Icons.group_add_rounded, onTap: () {
                    context.goNamed(AppRoute.inviteFriends.name);
                  }),
                  _menuItem(
                    context,
                    context.l10n.signOut,
                    MingCute.exit_fill,
                    onTap: state.isLoading
                        ? null
                        : () async {
                            await _showSignOutDialog(context);
                          },
                    color: Colors.red,
                  ),
                ],
              ),
              gapH16,
              _buildSection(
                title: context.l10n.contentAndDisplay,
                items: [
                  _menuItem(context, context.l10n.languageSettingTitle,
                      Icons.language, onTap: () {
                    bottomSheetBuilder(
                        context: context, child: const LanguageSettingSheet());
                  }),
                  _menuItem(context, context.l10n.darkMode, MingCute.moon_fill,
                      onTap: () {
                    bottomSheetBuilder(
                        context: context, child: const ThemeSettingSheet());
                  }),
                  _menuItem(context, context.l10n.notifications,
                      MingCute.notification_fill, onTap: () {
                    context.pushNamed(AppRoute.notificationSettings.name);
                  }),
                ],
              ),
              gapH16,
              _buildSection(
                title: context.l10n.about,
                items: [
                  _menuItem(context, context.l10n.termOfService,
                      Icons.description_rounded, onTap: () {
                    context.goNamed(AppRoute.termsOfService.name);
                  }),
                  _menuItem(context, context.l10n.faqPage,
                      Icons.question_answer_rounded, onTap: () {
                    context.goNamed(AppRoute.faq.name);
                  }),
                  _menuItem(
                      context, context.l10n.helpCenter, Icons.help_rounded,
                      onTap: () {
                    context.goNamed(AppRoute.helpCenter.name);
                  }),
                  _menuItem(context, context.l10n.version, Icons.info_rounded,
                      trailing: Text('1.1.0'.hardcoded)),
                ],
              ),
              gapH16,
              _buildHeaderSection(context.l10n.dangerousZone,
                  color: Colors.red),
              _menuItem(context, context.l10n.deleteAccount, Icons.delete,
                  color: Colors.red, trailing: const SizedBox()),
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
      color: context.moonColors?.gohan,
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
        color: context.moonColors?.goku,
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
          content: l10n.signOutConfirmation,
          cancelLabel: l10n.cancel,
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
