import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl
    implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> sendEmailVerification() async {
    await remoteDataSource.sendEmailVerification();
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? photoUrl,
    String? careerGoal,
    String? experienceLevel,
  }) async {
    await remoteDataSource.updateProfile(
      name: name,
      photoUrl: photoUrl,
      careerGoal: careerGoal,
      experienceLevel: experienceLevel,
    );
  }
}