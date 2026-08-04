import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../jobs/presentation/providers/job_provider.dart';
import '../../../jobs/presentation/widgets/job_card.dart';

class JobsPage extends ConsumerWidget {
  const JobsPage({super.key});

  static const categories = ['All', 'Technology', 'Design', 'Marketing', 'Finance'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredJobsAsync = ref.watch(filteredJobsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Dream Job'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).setQuery(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search jobs, companies, or locations...',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryBlue.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.primaryBlue,
                    onSelected: (selected) {
                      ref.read(selectedCategoryProvider.notifier).setCategory(cat);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredJobsAsync.when(
              data: (jobs) {
                if (jobs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No jobs found matching your criteria.',
                      style: TextStyle(color: AppTheme.grayText),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    return JobCard(job: jobs[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading jobs: $err')),
            ),
          ),
        ],
      ),
    );
  }
}