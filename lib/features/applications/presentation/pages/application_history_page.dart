import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/application_provider.dart';

class ApplicationHistoryPage extends ConsumerWidget {
  const ApplicationHistoryPage({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'shortlisted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'under review':
        return Colors.orange;
      default:
        return AppTheme.primaryBlue;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsAsync = ref.watch(userApplicationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: applicationsAsync.when(
        data: (applications) {
          if (applications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.assignment_outlined, size: 64, color: AppTheme.grayText),
                  SizedBox(height: 16),
                  Text(
                    'No Job Applications Yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Apply to jobs to track your progress here.',
                    style: TextStyle(color: AppTheme.grayText),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final app = applications[index];
              final statusColor = _getStatusColor(app.status);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    child: const Icon(Icons.work_outline_rounded, color: AppTheme.primaryBlue),
                  ),
                  title: Text(
                    app.jobTitle.isNotEmpty ? app.jobTitle : 'Job Application',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(app.company.isNotEmpty ? app.company : 'SkillBridge Partner'),
                      const SizedBox(height: 4),
                      Text(
                        'Applied on ${app.appliedAt.day}/${app.appliedAt.month}/${app.appliedAt.year}',
                        style: const TextStyle(fontSize: 12, color: AppTheme.grayText),
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      app.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Failed to load applications: $err'),
        ),
      ),
    );
  }
}
