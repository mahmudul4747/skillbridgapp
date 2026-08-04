import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skillbridg/features/profile/presentation/pages/notifications_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/admin/presentation/pages/manage_applications_page.dart';
import '../../features/admin/presentation/pages/manage_jobs_page.dart';
import '../../features/applications/presentation/pages/application_history_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/jobs/presentation/pages/saved_jobs_page.dart';
import '../../features/navigation/presentation/pages/main_navigation_page.dart';
import '../../features/onboarding/presentation/pages/career_setup_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/career-setup',
        name: 'career-setup',
        builder: (context, state) => const CareerSetupPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const MainNavigationPage(),
      ),
      GoRoute(
        path: '/saved-jobs',
        name: 'saved-jobs',
        builder: (context, state) => const SavedJobsPage(),
      ),
      GoRoute(
        path: '/applications-history',
        name: 'applications-history',
        builder: (context, state) => const ApplicationHistoryPage(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit-profile',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: '/admin/manage-jobs',
        name: 'admin-manage-jobs',
        builder: (context, state) => const ManageJobsPage(),
      ),
      GoRoute(
        path: '/admin/manage-applications',
        name: 'admin-manage-applications',
        builder: (context, state) => const ManageApplicationsPage(),
      ),
    ],
    redirect: (context, state) {
      if (authState.isLoading) return null;

      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/forgot-password';

      if (!isLoggedIn &&
          (state.matchedLocation == '/dashboard' ||
              state.matchedLocation == '/career-setup' ||
              state.matchedLocation.startsWith('/admin') ||
              state.matchedLocation == '/saved-jobs')) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/dashboard';
      }

      return null;
    },
  );
});