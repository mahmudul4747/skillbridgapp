import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/application_repository_impl.dart';
import '../../domain/entities/application_entity.dart';
import '../../domain/repositories/application_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  return ApplicationRepositoryImpl(FirebaseFirestore.instance);
});

final userApplicationsProvider = StreamProvider<List<ApplicationEntity>>((ref) {
  final userAsync = ref.watch(authProvider);
  final user = userAsync.value;
  if (user == null) return Stream.value([]);
  return ref.watch(applicationRepositoryProvider).getUserApplications(user.uid);
});

final allApplicationsProvider = StreamProvider<List<ApplicationEntity>>((ref) {
  return ref.watch(applicationRepositoryProvider).getAllApplications();
});
