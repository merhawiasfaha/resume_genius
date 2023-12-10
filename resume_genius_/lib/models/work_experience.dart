class WorkExperience {
  final String company;
  final String position;
  final String startDate;
  final String endDate;

  WorkExperience({
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

List<Map<String, dynamic>> workExperiencesToMaps(List<WorkExperience> workExperiences) {
    return workExperiences.map((workExp) => workExp.toMap()).toList();
}