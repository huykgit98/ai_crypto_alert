import 'package:ai_crypto_alert/features/home/presentation/home/custom_sliver_persistence_header_delegate.dart';
import 'package:ai_crypto_alert/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final double premiumCardHeight = kToolbarHeight;
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
      final difference = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(closeTimestamp))
          .inDays;
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
          _buildGradientBackground(context),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomSliverPersistentHeaderDelegate(
                  statusBarHeight: statusBarHeight,
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SegmentControlWidget(),
                    ],
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
          if (!isPremium && isPremiumCardVisible)
            PremiumCard(
              onClose: _hidePremiumCard,
              onTap: () {
                print("HUYHUY Premium card tapped");
              },
              premiumCardHeight: premiumCardHeight,
            ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground(BuildContext context) {
    return Container(
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
    );
  }
}
