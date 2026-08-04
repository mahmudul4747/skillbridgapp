import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../applications/presentation/providers/application_provider.dart';

class ManageApplicationsPage extends ConsumerWidget {
  const ManageApplicationsPage({super.key});

  void _showStatusDialog(BuildContext context, WidgetRef ref, String appId, String currentStatus) {
    showDialog(
      context: context,
      builder: (context) {
        final statuses = ['Applied', 'Under Review', 'Shortlisted', 'Accepted', 'Rejected'];
        return SimpleDialog(
          title: const Text('Update Status'),
          children: statuses.map((status) {
            return SimpleDialogOption(
              onPressed: () async {
                await ref.read(applicationRepositoryProvider).updateApplicationStatus(appId, status);
                if (context.mounted) Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  status,
                  style: TextStyle(
                    fontWeight: status == currentStatus ? FontWeight.bold : FontWeight.normal,
                    color: status == currentStatus ? AppTheme.primaryBlue : AppTheme.darkText,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsAsync = ref.watch(allApplicationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Applications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: appsAsync.when(
        data: (apps) {
          if (apps.isEmpty) {
            return const Center(child: Text('No job applications submitted yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(app.jobTitle.isNotEmpty ? app.jobTitle : 'Job Application', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${app.company} • Status: ${app.status}'),
                  trailing: TextButton(
                    onPressed: () => _showStatusDialog(context, ref, app.id, app.status),
                    child: const Text('Change'),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
