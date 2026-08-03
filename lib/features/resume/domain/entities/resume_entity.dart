class ResumeEntity {
  final String id;
  final String userId;
  final String title;
  final String fileUrl;
  final String fileName;
  final int atsScore;
  final DateTime createdAt;

  const ResumeEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.fileUrl,
    required this.fileName,
    required this.atsScore,
    required this.createdAt,
  });
}