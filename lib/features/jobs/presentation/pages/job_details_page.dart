import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../applications/presentation/providers/application_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/job_entity.dart';
import '../providers/job_provider.dart';

class JobDetailsPage extends ConsumerWidget {
  final JobEntity job;

  const JobDetailsPage({
    super.key,
    required this.job,
  });

  void _showApplyDialog(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).value;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to apply for this job')),
      );
      return;
    }

    final resumeController = TextEditingController(
      text: 'https://skillbridge.app/resumes/${user.uid}.pdf',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Apply for ${job.title}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Applying as ${user.name} (${user.email})'),
              const SizedBox(height: 16),
              TextField(
                controller: resumeController,
                decoration: const InputDecoration(
                  labelText: 'Resume URL',
                  prefixIcon: Icon(Icons.link_rounded),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final nav = Navigator.of(context);

                await ref.read(applicationRepositoryProvider).submitApplication(
                      jobId: job.id,
                      jobTitle: job.title,
                      company: job.company,
                      userId: user.uid,
                      resumeUrl: resumeController.text.trim(),
                    );

                nav.pop();
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('Application submitted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Submit Application'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final isSaved = user?.savedJobIds.contains(job.id) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
        actions: [
          IconButton(
            onPressed: () async {
              if (user == null) return;
              await ref.read(jobRepositoryProvider).toggleSaveJob(user.uid, job.id);
              ref.invalidate(authProvider);
            },
            icon: Icon(
              isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isSaved ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () => _showApplyDialog(context, ref),
            child: const Text("Apply Now"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              job.company,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Chip(label: Text(job.location)),
                Chip(label: Text(job.jobType)),
                Chip(label: Text(job.salary)),
                Chip(label: Text(job.experience)),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(job.description),
            const SizedBox(height: 30),
            const Text(
              "Requirements",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...job.requirements.map(
              (e) => ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                title: Text(e),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Skills",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: job.skills
                  .map(
                    (e) => Chip(
                      label: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}