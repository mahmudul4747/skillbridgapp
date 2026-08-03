import 'package:flutter/material.dart';
import 'package:skillbridg/features/jobs/presentation/pages/job_details_page.dart';

import '../../domain/entities/job_entity.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;

  const JobCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),

      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            job.company.isNotEmpty
                ? job.company[0]
                : "?",
          ),
        ),

        title: Text(job.title),

        subtitle: Text(
          "${job.company} • ${job.location}",
        ),

        trailing: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Text(job.salary),

            if (job.isRemote)
              const Text(
                "Remote",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
          ],
        ),

        onTap: () {
          onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => JobDetailsPage(
        job: job,
      ),
    ),
  );
};
        },
      ),
    );
  }
}