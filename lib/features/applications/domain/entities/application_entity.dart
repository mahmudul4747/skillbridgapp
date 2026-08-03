class ApplicationEntity {
  final String id;
  final String jobId;
  final String userId;
  final String resumeUrl;
  final String status;
  final DateTime appliedAt;

  const ApplicationEntity({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.resumeUrl,
    required this.status,
    required this.appliedAt,
  });
}