class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String role;
  final bool isEmailVerified;
  final List<String> savedJobIds;
  final String? photoUrl;
  final String? careerGoal;
  final String? experienceLevel;
  final DateTime? createdAt;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.role = 'user',
    this.isEmailVerified = false,
    this.savedJobIds = const [],
    this.photoUrl,
    this.careerGoal,
    this.experienceLevel,
    this.createdAt,
  });
}