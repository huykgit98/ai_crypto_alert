import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moon_design/moon_design.dart';

class CustomAnimatedAppBar extends HookWidget {
  const CustomAnimatedAppBar({
    required this.title,
    this.expandedHeight = kToolbarHeight + 10,
    this.flexibleSpaceContent,
    this.collapsedHeight = kToolbarHeight,
    this.leading,
    this.trailing,
    this.expandedTitle,
    super.key,
    this.scrollController,
    this.onBackButtonPressed,
    this.gradientBackground,
    this.pinned = true,
    this.showCollapsedAppBar = true,
  });

  final String title;
  final String? expandedTitle;
  final Widget? leading;
  final Widget? trailing;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget? flexibleSpaceContent;
  final ScrollController? scrollController;
  final VoidCallback? onBackButtonPressed;
  final Gradient? gradientBackground;
  final bool pinned;
  final bool showCollapsedAppBar;

  @override
  Widget build(BuildContext context) {
    final controller = scrollController ?? useScrollController();
    final isCollapsed = useState(false);

    useEffect(
      () {
        void listener() {
          isCollapsed.value = controller.hasClients &&
              controller.offset > (expandedHeight - collapsedHeight);
        }

        controller.addListener(listener);
        return () => controller.removeListener(listener);
      },
      [controller],
    );

    return SliverAppBar(
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      centerTitle: true,
      pinned: pinned,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isCollapsed.value && showCollapsedAppBar ? 1 : 0,
        child: Text(
          title,
          style: context.moonTypography?.heading.text18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: context.moonColors?.goku.withValues(
        alpha: isCollapsed.value && showCollapsedAppBar ? 1 : 0,
      ),
      scrolledUnderElevation: 0,
      leading: leading,
      actions: trailing != null ? [trailing!] : [],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: gradientBackground ??
                    LinearGradient(
                      colors: [
                        context.moonColors!.piccolo.withValues(alpha: .3),
                        context.moonColors!.piccolo.withValues(alpha: .2),
                        context.moonColors!.piccolo.withValues(alpha: .1),
                        context.moonColors!.gohan.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.4, 0.6, 1.0],
                    ),
              ),
            ),
            if (expandedTitle != null && expandedTitle!.isNotEmpty)
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  expandedTitle!,
                  style: context.moonTypography?.heading.text24.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.moonColors?.textPrimary,
                  ),
                ),
              ),
            if ((expandedTitle == null || expandedTitle!.isEmpty) &&
                flexibleSpaceContent != null)
              flexibleSpaceContent!,
          ],
        ),
      ),
    );
  }
}
