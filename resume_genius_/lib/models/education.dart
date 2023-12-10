class Education {
  final String schoolName;
  final String course;
  final String location;
  final String startDate;
  final String endDate;

  Education({
    required this.schoolName,
    required this.course,
    required this.location,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'schoolName': schoolName,
      'course': course,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}