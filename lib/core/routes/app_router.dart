import 'package:ai_crypto_alert/core/routes/routes.dart';
import 'package:ai_crypto_alert/features/authentication/authentication.dart';
import 'package:ai_crypto_alert/features/home/home.dart';
import 'package:ai_crypto_alert/features/onboarding/onboarding.dart';
import 'package:ai_crypto_alert/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

// NavigationSheet requires a special NavigatorObserver in order to
// smoothly change its extent during a route transition.
final sheetTransitionObserver = NavigationSheetTransitionObserver();

enum AppRoute {
  onboarding,

  signIn,
  signUp,
  forgotPassword,

  home,

  notifications,
  favorite,

  profile,
  myDetails,
  notificationSettings,
  termsOfService,
  faq,
  helpCenter,
}

@riverpod
GoRouter goRouter(Ref ref) {
  final appStartupState = ref.watch(appStartupProvider);
  // final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/onboarding',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }
      final onboardingRepository =
          ref.read(onboardingRepositoryProvider).requireValue;
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;
      if (!didCompleteOnboarding) {
        if (path != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }
      // final isLoggedIn = authRepository.currentUser != null;
      final isLoggedIn = false;

      if (isLoggedIn) {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/signIn')) {
          return '/home';
        }
      } else {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/home') ||
            path.startsWith('/account')) {
          return '/onboarding';
        }
      }
      return null;
    },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            onLoaded: (_) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.white,
                  ],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const OnboardingScreen(),
            transitionsBuilder: _defaultTransitionsBuilder,
          );
        },
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const CustomSignInScreen(),
            transitionsBuilder: _defaultTransitionsBuilder,
          );
        },
        routes: [
          GoRoute(
            path: 'forgotPassword',
            name: AppRoute.forgotPassword.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: ForgotPasswordScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/signUp',
        name: AppRoute.signUp.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const CustomSignUpScreen(),
            transitionsBuilder: _defaultTransitionsBuilder,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}

Widget _defaultTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
    child: child,
  );
}
