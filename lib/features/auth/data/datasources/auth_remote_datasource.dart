import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth =
            firebaseAuth ?? FirebaseAuth.instance,
        _firestore =
            firestore ?? FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception(
        'Unable to create user account',
      );
    }

    await firebaseUser.updateDisplayName(name);

    final user = UserModel(
      uid: firebaseUser.uid,
      name: name.trim(),
      email: email.trim(),
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(user.toFirestore());

    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception(
        'Unable to login',
      );
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!snapshot.exists) {
      throw Exception(
        'User profile not found',
      );
    }

    return UserModel.fromFirestore(snapshot);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final firebaseUser =
        _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    return UserModel.fromFirestore(snapshot);
  }
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> updateProfile({
    String? name,
    String? photoUrl,
    String? careerGoal,
    String? experienceLevel,
  }) async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception('User is not logged in');
    }

    final Map<String, dynamic> updates = {};
    if (name != null && name.isNotEmpty) {
      updates['name'] = name;
      await firebaseUser.updateDisplayName(name);
    }
    if (photoUrl != null) {
      updates['photoUrl'] = photoUrl;
      await firebaseUser.updatePhotoURL(photoUrl);
    }
    if (careerGoal != null) updates['careerGoal'] = careerGoal;
    if (experienceLevel != null) updates['experienceLevel'] = experienceLevel;

    if (updates.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .update(updates);
    }
  }
}