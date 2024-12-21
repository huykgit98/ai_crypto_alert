import 'package:ai_crypto_alert/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeMeshRadialGradientBackground(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Negan',
                        style: context.moonTypography?.heading.text24,
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
                        style: context.moonTypography?.body.text14.copyWith(
                          color: context.moonColors?.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          ],
        ),
      ),
    );
  }
}
