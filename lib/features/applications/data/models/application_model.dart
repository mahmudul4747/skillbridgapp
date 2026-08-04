import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/application_entity.dart';

class ApplicationModel extends ApplicationEntity {
  const ApplicationModel({
    required super.id,
    required super.jobId,
    required super.userId,
    super.jobTitle = '',
    super.company = '',
    required super.resumeUrl,
    required super.status,
    required super.appliedAt,
  });

  factory ApplicationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return ApplicationModel(
      id: doc.id,
      jobId: data['jobId'] ?? '',
      userId: data['userId'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      company: data['company'] ?? '',
      resumeUrl: data['resumeUrl'] ?? '',
      status: data['status'] ?? 'Applied',
      appliedAt: data['appliedAt'] is Timestamp
          ? (data['appliedAt'] as Timestamp).toDate()
          : (DateTime.tryParse(data['appliedAt']?.toString() ?? '') ??
              DateTime.now()),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'jobId': jobId,
      'userId': userId,
      'jobTitle': jobTitle,
      'company': company,
      'resumeUrl': resumeUrl,
      'status': status,
      'appliedAt': Timestamp.fromDate(appliedAt),
    };
  }
}
