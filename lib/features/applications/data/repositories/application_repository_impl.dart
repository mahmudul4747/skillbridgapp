import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/application_entity.dart';
import '../../domain/repositories/application_repository.dart';
import '../models/application_model.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final FirebaseFirestore _firestore;

  ApplicationRepositoryImpl(this._firestore);

  @override
  Future<void> submitApplication({
    required String jobId,
    required String jobTitle,
    required String company,
    required String userId,
    required String resumeUrl,
  }) async {
    final docRef = _firestore.collection('applications').doc();
    final model = ApplicationModel(
      id: docRef.id,
      jobId: jobId,
      jobTitle: jobTitle,
      company: company,
      userId: userId,
      resumeUrl: resumeUrl,
      status: 'Applied',
      appliedAt: DateTime.now(),
    );
    await docRef.set(model.toFirestore());
  }

  @override
  Stream<List<ApplicationEntity>> getUserApplications(String userId) {
    return _firestore
        .collection('applications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ApplicationModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Stream<List<ApplicationEntity>> getAllApplications() {
    return _firestore.collection('applications').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ApplicationModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Future<void> updateApplicationStatus(String applicationId, String status) async {
    await _firestore
        .collection('applications')
        .doc(applicationId)
        .update({'status': status});
  }
}
