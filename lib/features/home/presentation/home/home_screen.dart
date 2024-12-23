import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:ai_crypto_alert/features/home/presentation/home/custom_sliver_persistence_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moon_design/moon_design.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final bool isPremium = false;
  final premiumCardHeight = kToolbarHeight;

  bool isPremiumCardVisible = true;

  @override
  void initState() {
    super.initState();
    _checkPremiumCardVisibility();
  }

  Future<void> _checkPremiumCardVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    final closeTimestamp = prefs.getInt('premiumCardClosedAt');

    if (closeTimestamp != null) {
      final now = DateTime.now();
      final closedAt = DateTime.fromMillisecondsSinceEpoch(closeTimestamp);
      final difference = now.difference(closedAt).inDays;

      if (difference < 2) {
        setState(() {
          isPremiumCardVisible = false;
        });
      }
    }
  }

  Future<void> _hidePremiumCard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'premiumCardClosedAt', DateTime.now().millisecondsSinceEpoch);
    setState(() {
      isPremiumCardVisible = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradients
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.5,
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
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomSliverPersistentHeaderDelegate(
                  statusBarHeight: statusBarHeight, // Pass status bar height
                ),
              ),
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
              if (!isPremium && isPremiumCardVisible)
                SliverPadding(
                  padding: EdgeInsets.only(bottom: premiumCardHeight + 8),
                  sliver: const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
                ),
            ],
          ),

          if (!isPremium && isPremiumCardVisible) ...[
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
                  onTap: () {
                    print("HUYHUY Premium card tapped");
                  },
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
              ),
            ),
            Positioned(
              right: 0,
              bottom: premiumCardHeight - 8,
              child: GestureDetector(
                onTap: _hidePremiumCard,
                child: Padding(
                  padding:
                      const EdgeInsets.all(8), // Padding for better touch area
                  child: Icon(Icons.close, color: context.moonColors!.trunks),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
