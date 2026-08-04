import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../jobs/domain/entities/job_entity.dart';
import '../../../jobs/presentation/providers/job_provider.dart';

class ManageJobsPage extends ConsumerWidget {
  const ManageJobsPage({super.key});

  void _showAddJobDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final salaryController = TextEditingController();
    final categoryController = TextEditingController(text: 'Technology');
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Post New Job'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Job Title')),
                TextField(controller: companyController, decoration: const InputDecoration(labelText: 'Company Name')),
                TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
                TextField(controller: salaryController, decoration: const InputDecoration(labelText: 'Salary Range')),
                TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category')),
                TextField(controller: descriptionController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;

                final newJob = JobEntity(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text.trim(),
                  company: companyController.text.trim(),
                  companyLogo: '',
                  location: locationController.text.trim(),
                  jobType: 'Full-time',
                  category: categoryController.text.trim(),
                  salary: salaryController.text.trim(),
                  experience: 'Mid-Level',
                  description: descriptionController.text.trim(),
                  requirements: ['Relevant industry experience', 'Strong communication skills'],
                  skills: ['Flutter', 'Dart', 'Firebase'],
                  deadline: DateTime.now().add(const Duration(days: 30)),
                  createdAt: DateTime.now(),
                  isRemote: true,
                );

                await ref.read(jobRepositoryProvider).createJob(newJob);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Post Job'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Jobs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddJobDialog(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Job'),
        backgroundColor: AppTheme.primaryBlue,
      ),
      body: jobsAsync.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return const Center(child: Text('No jobs listed yet. Tap + to post a job.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${job.company} • ${job.location}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                    onPressed: () async {
                      await ref.read(jobRepositoryProvider).deleteJob(job.id);
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading jobs: $err')),
      ),
    );
  }
}
