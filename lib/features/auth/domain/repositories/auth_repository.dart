import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail(String email);

  Future<void> sendEmailVerification();

  Future<void> updateProfile({
    String? name,
    String? photoUrl,
    String? careerGoal,
    String? experienceLevel,
  });

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}