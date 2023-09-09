class CourseModel {
  const CourseModel({
    required this.courseName,
    required this.grade,
    required this.unit,
  });

  final String courseName;
  final Grade grade;
  final double unit;
}

enum Grade { A, B, C, D, F }
