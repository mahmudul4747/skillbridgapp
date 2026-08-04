import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/job_remote_datasource.dart';
import '../../data/repositories/job_repository_impl.dart';

import '../../domain/entities/job_entity.dart';

final firestoreProvider =
    Provider((ref) => FirebaseFirestore.instance);

final jobRemoteProvider = Provider(
  (ref) => JobRemoteDataSource(
    ref.watch(firestoreProvider),
  ),
);

final jobRepositoryProvider = Provider(
  (ref) => JobRepositoryImpl(
    ref.watch(jobRemoteProvider),
  ),
);

final jobsProvider = StreamProvider<List<JobEntity>>(
  (ref) {
    return ref.watch(jobRepositoryProvider).getJobs();
  },
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void setQuery(String query) => state = query;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

class SelectedCategoryNotifier extends Notifier<String> {
  @override
  String build() => 'All';
  void setCategory(String category) => state = category;
}

final selectedCategoryProvider = NotifierProvider<SelectedCategoryNotifier, String>(SelectedCategoryNotifier.new);

final filteredJobsProvider = Provider<AsyncValue<List<JobEntity>>>((ref) {
  final jobsAsync = ref.watch(jobsProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final category = ref.watch(selectedCategoryProvider);

  return jobsAsync.whenData((jobs) {
    return jobs.where((job) {
      final matchesQuery = query.isEmpty ||
          job.title.toLowerCase().contains(query) ||
          job.company.toLowerCase().contains(query) ||
          job.location.toLowerCase().contains(query);

      final matchesCategory =
          category == 'All' || job.category.toLowerCase() == category.toLowerCase();

      return matchesQuery && matchesCategory;
    }).toList();
  });
});