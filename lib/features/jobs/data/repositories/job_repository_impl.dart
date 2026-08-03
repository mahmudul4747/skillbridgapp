import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_datasource.dart';
import '../models/job_model.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remote;

  JobRepositoryImpl(this.remote);

  @override
  Stream<List<JobEntity>> getJobs() {
    return remote.jobs.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (e) => JobModel.fromMap(
              e.data() as Map<String, dynamic>,
              e.id,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<JobEntity> getJobById(String id) async {
    final doc = await remote.jobs.doc(id).get();

    return JobModel.fromMap(
      doc.data() as Map<String, dynamic>,
      doc.id,
    );
  }

  @override
  Future<void> saveJob(String jobId) async {}

  @override
  Future<void> applyJob(String jobId) async {}
}