import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

final authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});

final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource:
        ref.read(authRemoteDataSourceProvider),
  );
});

final authProvider = AsyncNotifierProvider<
    AuthNotifier,
    UserEntity?>(
  AuthNotifier.new,
);

class AuthNotifier
    extends AsyncNotifier<UserEntity?> {
  late final AuthRepository _repository;

  @override
  Future<UserEntity?> build() async {
    _repository =
        ref.read(authRepositoryProvider);

    return await _repository.getCurrentUser();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        return await _repository.register(
          name: name,
          email: email,
          password: password,
        );
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        return await _repository.login(
          email: email,
          password: password,
        );
      },
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AsyncData(null);
  }
}