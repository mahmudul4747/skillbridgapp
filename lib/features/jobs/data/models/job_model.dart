import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.title,
    required super.company,
    required super.companyLogo,
    required super.location,
    required super.jobType,
    required super.category,
    required super.salary,
    required super.experience,
    required super.description,
    required super.requirements,
    required super.skills,
    required super.deadline,
    required super.createdAt,
    required super.isRemote,
  });

  factory JobModel.fromMap(Map<String, dynamic> map, String id) {
    return JobModel(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      companyLogo: map['companyLogo'] ?? '',
      location: map['location'] ?? '',
      jobType: map['jobType'] ?? '',
      category: map['category'] ?? '',
      salary: map['salary'] ?? '',
      experience: map['experience'] ?? '',
      description: map['description'] ?? '',
      requirements: List<String>.from(map['requirements'] ?? []),
      skills: List<String>.from(map['skills'] ?? []),
      deadline: map['deadline'] is Timestamp
          ? (map['deadline'] as Timestamp).toDate()
          : (DateTime.tryParse(map['deadline']?.toString() ?? '') ?? DateTime.now()),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : (DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now()),
      isRemote: map['isRemote'] ?? false,
    );
  }

  factory JobModel.fromEntity(JobEntity entity) {
    return JobModel(
      id: entity.id,
      title: entity.title,
      company: entity.company,
      companyLogo: entity.companyLogo,
      location: entity.location,
      jobType: entity.jobType,
      category: entity.category,
      salary: entity.salary,
      experience: entity.experience,
      description: entity.description,
      requirements: entity.requirements,
      skills: entity.skills,
      deadline: entity.deadline,
      createdAt: entity.createdAt,
      isRemote: entity.isRemote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'companyLogo': companyLogo,
      'location': location,
      'jobType': jobType,
      'category': category,
      'salary': salary,
      'experience': experience,
      'description': description,
      'requirements': requirements,
      'skills': skills,
      'deadline': deadline,
      'createdAt': createdAt,
      'isRemote': isRemote,
    };
  }
}