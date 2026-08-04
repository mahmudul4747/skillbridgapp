import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 45,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  user?.name.isNotEmpty == true ? user!.name : 'User Profile',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user?.careerGoal?.isNotEmpty == true
                      ? user!.careerGoal!
                      : (user?.email ?? 'SkillBridge User'),
                  style: const TextStyle(
                    color: AppTheme.grayText,
                  ),
                ),
                if (user?.role == 'admin') ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purple),
                    ),
                    child: const Text(
                      'Admin Account 🛡️',
                      style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 30),
          _ProfileItem(
            icon: Icons.person_outline_rounded,
            title: 'Edit Profile',
            onTap: () => context.push('/edit-profile'),
          ),
          _ProfileItem(
            icon: Icons.bookmark_border_rounded,
            title: 'Saved Jobs',
            onTap: () => context.push('/saved-jobs'),
          ),
          _ProfileItem(
            icon: Icons.assignment_outlined,
            title: 'My Applications',
            onTap: () => context.push('/applications-history'),
          ),
          if (user?.role == 'admin')
            _ProfileItem(
              icon: Icons.admin_panel_settings_outlined,
              title: 'Admin Console',
              onTap: () => context.push('/admin'),
            ),
          _ProfileItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () => context.push('/settings'),
          ),
          _ProfileItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 1,
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: iconColor ?? AppTheme.primaryBlue,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ),
      ),
    );
  }
}