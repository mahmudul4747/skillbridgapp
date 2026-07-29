import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import 'ai_page.dart';
import 'jobs_page.dart';
import 'profile_page.dart';
import 'skills_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState
    extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    JobsPage(),
    SkillsPage(),
    AiPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar:
          NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        backgroundColor: Colors.white,

        indicatorColor:
            AppTheme.primaryBlue.withValues(
          alpha: 0.12,
        ),

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            selectedIcon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.work_outline_rounded,
            ),
            selectedIcon: Icon(
              Icons.work_rounded,
            ),
            label: 'Jobs',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.psychology_outlined,
            ),
            selectedIcon: Icon(
              Icons.psychology_rounded,
            ),
            label: 'Skills',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.smart_toy_outlined,
            ),
            selectedIcon: Icon(
              Icons.smart_toy_rounded,
            ),
            label: 'AI',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
            ),
            selectedIcon: Icon(
              Icons.person_rounded,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}