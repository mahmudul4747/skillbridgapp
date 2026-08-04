import 'package:skillbridg/features/jobs/domain/entities/job_entity.dart';

abstract class JobRepository {
  Stream<List<JobEntity>> getJobs();

  Future<JobEntity> getJobById(String id);

  Future<void> saveJob(String jobId);

  Future<void> applyJob(String jobId);

  Future<void> createJob(JobEntity job);

  Future<void> updateJob(JobEntity job);

  Future<void> deleteJob(String id);

  Future<void> toggleSaveJob(String userId, String jobId);
}