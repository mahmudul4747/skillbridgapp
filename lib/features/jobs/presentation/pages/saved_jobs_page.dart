import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';

class SavedJobsPage extends ConsumerWidget {
  const SavedJobsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Jobs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: jobsAsync.when(
        data: (allJobs) {
          final savedJobIds = user?.savedJobIds ?? [];
          final savedJobs = allJobs.where((job) => savedJobIds.contains(job.id)).toList();

          if (savedJobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bookmark_outline_rounded, size: 64, color: AppTheme.grayText),
                  SizedBox(height: 16),
                  Text(
                    'No Saved Jobs Yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the bookmark icon on any job card to save it here.',
                    style: TextStyle(color: AppTheme.grayText),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedJobs.length,
            itemBuilder: (context, index) {
              return JobCard(job: savedJobs[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading saved jobs: $err')),
      ),
    );
  }
}
