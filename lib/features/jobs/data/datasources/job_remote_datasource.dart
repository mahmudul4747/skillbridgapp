import 'package:cloud_firestore/cloud_firestore.dart';

class JobRemoteDataSource {
  final FirebaseFirestore firestore;

  JobRemoteDataSource(this.firestore);

  CollectionReference get jobs =>
      firestore.collection('jobs');
}