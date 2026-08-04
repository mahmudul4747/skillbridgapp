import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/job_entity.dart';
import '../pages/job_details_page.dart';
import '../providers/job_provider.dart';

class JobCard extends ConsumerWidget {
  final JobEntity job;

  const JobCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final isSaved = user?.savedJobIds.contains(job.id) ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          child: Text(
            job.company.isNotEmpty ? job.company[0].toUpperCase() : "?",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "${job.company} • ${job.location}",
          style: const TextStyle(height: 1.4),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(job.salary, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                if (job.isRemote)
                  const Text(
                    "Remote",
                    style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                color: isSaved ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () async {
                if (user == null) return;
                await ref.read(jobRepositoryProvider).toggleSaveJob(user.uid, job.id);
                ref.invalidate(authProvider);
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JobDetailsPage(
                job: job,
              ),
            ),
          );
        },
      ),
    );
  }
}