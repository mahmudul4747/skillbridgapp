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
      deadline: map['deadline'].toDate(),
      createdAt: map['createdAt'].toDate(),
      isRemote: map['isRemote'] ?? false,
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