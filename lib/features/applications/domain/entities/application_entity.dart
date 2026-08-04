class ApplicationEntity {
  final String id;
  final String jobId;
  final String userId;
  final String jobTitle;
  final String company;
  final String resumeUrl;
  final String status;
  final DateTime appliedAt;

  const ApplicationEntity({
    required this.id,
    required this.jobId,
    required this.userId,
    this.jobTitle = '',
    this.company = '',
    required this.resumeUrl,
    required this.status,
    required this.appliedAt,
  });
}