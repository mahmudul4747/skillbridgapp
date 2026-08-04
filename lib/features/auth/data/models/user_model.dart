import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.role = 'user',
    super.isEmailVerified = false,
    super.savedJobIds = const [],
    super.photoUrl,
    super.careerGoal,
    super.experienceLevel,
    super.createdAt,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? {};

    return UserModel(
      uid: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      isEmailVerified: data['isEmailVerified'] ?? false,
      savedJobIds: List<String>.from(data['savedJobIds'] ?? []),
      photoUrl: data['photoUrl'],
      careerGoal: data['careerGoal'],
      experienceLevel: data['experienceLevel'],
      createdAt: (data['createdAt'] as Timestamp?)
          ?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'isEmailVerified': isEmailVerified,
      'savedJobIds': savedJobIds,
      'photoUrl': photoUrl,
      'careerGoal': careerGoal,
      'experienceLevel': experienceLevel,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }
}