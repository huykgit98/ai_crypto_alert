import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  // Simulated premium status (replace this with actual logic)
  final bool isPremium = false;

  final premiumCardHeight = kToolbarHeight; // Height of the premium card

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.9,
                center: Alignment.topLeft,
                colors: [
                  context.moonColors!.piccolo.withValues(alpha: .2),
                  context.moonColors!.goku.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.9,
                center: Alignment.centerRight,
                colors: [
                  context.moonColors!.piccolo.withValues(alpha: .2),
                  context.moonColors!.goku.withValues(alpha: 0),
                ],
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.9,
                center: Alignment.bottomCenter,
                colors: [
                  context.moonColors!.piccolo.withValues(alpha: .2),
                  context.moonColors!.goku.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomAnimatedAppBar(
                title: context.l10n.home,
                scrollController: _scrollController,
                expandedHeight: kToolbarHeight + 50,
                flexibleSpaceContent: Padding(
                  padding: const EdgeInsets.only(
                      top: kToolbarHeight, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Negan',
                        style: context.moonTypography?.heading.text20,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome to AI Crypto Alert',
                        style: context.moonTypography?.body.text14.copyWith(
                          color: context.moonColors?.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Get real-time alerts on your favorite cryptocurrencies',
                        style: context.moonTypography?.body.text12.copyWith(
                          color: context.moonColors?.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SliverPadding(
              //   padding: const EdgeInsets.only(top: kToolbarHeight),
              //   sliver: SliverToBoxAdapter(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 16, vertical: 16),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Hey Negan',
              //             style: context.moonTypography?.heading.text24,
              //           ),
              //           const SizedBox(height: 16),
              //           Text(
              //             'Welcome to AI Crypto Alert',
              //             style: context.moonTypography?.body.text14.copyWith(
              //               color: context.moonColors?.textSecondary,
              //             ),
              //           ),
              //           const SizedBox(height: 8),
              //           Text(
              //             'Get real-time alerts on your favorite cryptocurrencies',
              //             style: context.moonTypography?.body.text14.copyWith(
              //               color: context.moonColors?.textSecondary,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: CoolMode(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('LONG PRESS!'),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const ListTile(
                    title: Text('Item \$index'),
                  ),
                  childCount: 20,
                ),
              ),
              // Only add padding if the user is not premium
              if (!isPremium)
                SliverPadding(
                  padding: EdgeInsets.only(bottom: premiumCardHeight + 8),
                  sliver: const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
                ),
            ],
          ),

          // Show "Get Premium" card only if the user is not premium
          if (!isPremium)
            Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.moonColors!.piccolo,
                        context.moonColors!.chichi,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.moonColors!.jiren,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MoonMenuItem(
                    backgroundColor: Colors.transparent,
                    onTap: () {},
                    label: Text(
                      'Get premium to unlock more features',
                      style: context.moonTypography?.body.text14.copyWith(
                        color: context.moonColors?.goten,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading:
                        const Icon(MingCute.gift_2_fill, color: Colors.white),
                  ),
                )),
        ],
      ),
    );
  }
}
