import '../entities/application_entity.dart';

abstract class ApplicationRepository {
  Future<void> submitApplication({
    required String jobId,
    required String jobTitle,
    required String company,
    required String userId,
    required String resumeUrl,
  });

  Stream<List<ApplicationEntity>> getUserApplications(String userId);

  Stream<List<ApplicationEntity>> getAllApplications();

  Future<void> updateApplicationStatus(String applicationId, String status);
}
