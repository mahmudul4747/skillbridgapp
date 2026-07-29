/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/job_remote_datasource.dart';
import '../../data/repositories/job_repository_impl.dart';

final firestoreProvider =
    Provider((ref) => FirebaseFirestore.instance);

final jobRemoteProvider = Provider(
  (ref) => JobRemoteDataSource(
    ref.read(firestoreProvider),
  ),
);

final jobRepositoryProvider = Provider(
  (ref) => JobRepositoryImpl(
    ref.read(jobRemoteProvider),
  ),
);

final jobsProvider = StreamProvider(
  (ref) {
    return ref
        .read(jobRepositoryProvider)
        .getJobs();
  },
);*/