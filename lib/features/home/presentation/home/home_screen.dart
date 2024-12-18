import 'package:ai_crypto_alert/core/utils/utils.dart';
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

  static const pageSize = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CustomSliverAppBar(
            title: Text(
              'Home'.hardcoded,
              style: context.moonTypography?.heading.text20.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CoolMode(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('LONG PRESS!'),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
