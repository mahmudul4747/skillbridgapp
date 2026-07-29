import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skillbridg/features/auth/presentation/pages/register_page.dart';
import 'package:skillbridg/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:skillbridg/features/navigation/presentation/pages/main_navigation_page.dart';
import 'package:skillbridg/features/onboarding/presentation/pages/career_setup_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',

    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return const SplashPage();
        },
      ),

      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) {
          return const OnboardingPage();
        },
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
  path: '/register',
  name: 'register',
  builder: (context, state) {
    return const RegisterPage();
  },
),

GoRoute(
  path: '/career-setup',
  name: 'career-setup',
  builder: (context, state) {
    return const CareerSetupPage();
  },
),

GoRoute(
  path: '/dashboard',
  name: 'dashboard',
  builder: (context, state) {
    return const MainNavigationPage();
  },
),
    ],
  );
});