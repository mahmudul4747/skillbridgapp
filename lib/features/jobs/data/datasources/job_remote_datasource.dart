import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';

class JobRemoteDataSource {
  final FirebaseFirestore firestore;

  JobRemoteDataSource(this.firestore);

  CollectionReference get jobs => firestore.collection('jobs');

  Future<void> createJob(JobModel job) async {
    await jobs.doc(job.id.isNotEmpty ? job.id : null).set(job.toMap());
  }

  Future<void> updateJob(JobModel job) async {
    await jobs.doc(job.id).update(job.toMap());
  }

  Future<void> deleteJob(String jobId) async {
    await jobs.doc(jobId).delete();
  }

  Future<void> toggleSaveJob(String userId, String jobId) async {
    final userRef = firestore.collection('users').doc(userId);
    final doc = await userRef.get();
    final List<dynamic> currentSaved = doc.data()?['savedJobIds'] ?? [];

    if (currentSaved.contains(jobId)) {
      await userRef.update({
        'savedJobIds': FieldValue.arrayRemove([jobId]),
      });
    } else {
      await userRef.update({
        'savedJobIds': FieldValue.arrayUnion([jobId]),
      });
    }
  }
}