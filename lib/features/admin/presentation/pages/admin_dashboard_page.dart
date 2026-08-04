import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../applications/presentation/providers/application_provider.dart';
import '../../../jobs/presentation/providers/job_provider.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsCount = ref.watch(jobsProvider).value?.length ?? 0;
    final appsCount = ref.watch(allApplicationsProvider).value?.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Welcome, Admin 🛡️',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.darkText),
            ),
            const SizedBox(height: 6),
            const Text(
              'Manage jobs, review candidate applications, and monitor metrics.',
              style: TextStyle(color: AppTheme.grayText),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total Jobs',
                    count: '$jobsCount',
                    icon: Icons.work_rounded,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Applications',
                    count: '$appsCount',
                    icon: Icons.assignment_turned_in_rounded,
                    color: AppTheme.secondaryPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Management Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _AdminTile(
              title: 'Manage Jobs',
              subtitle: 'Post new job opportunities or edit existing ones',
              icon: Icons.business_center_rounded,
              color: Colors.blue,
              onTap: () => context.push('/admin/manage-jobs'),
            ),
            const SizedBox(height: 12),
            _AdminTile(
              title: 'Manage Applications',
              subtitle: 'Review candidate resumes and update status',
              icon: Icons.people_alt_rounded,
              color: Colors.purple,
              onTap: () => context.push('/admin/manage-applications'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(count, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.darkText)),
        ],
      ),
    );
  }
}

class _AdminTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AdminTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
      ),
    );
  }
}
