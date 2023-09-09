import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_gpa/models/course_model.dart';

class CourseNotifier extends StateNotifier<List<CourseModel>> {
  CourseNotifier() : super([]);

  double totalScore = 0;
  double totalUnit = 0;
  double obtainableScore = 0;
  double gpa = 0;

  void addCourse(String courseName, Grade grade, double unit) {
    final course =
        CourseModel(courseName: courseName, grade: grade, unit: unit);

    state = [...state, course];
  }

  void cleanCourse() {
    state = [];
  }

  double calcGpa() {
    for (final course in state) {
      if (course.grade == Grade.A) {
        final score = 5 * course.unit;
        totalUnit = totalUnit + course.unit;
        totalScore = totalScore + score;
      } else if (course.grade == Grade.B) {
        final score = 4 * course.unit;
        totalUnit = totalUnit + course.unit;
        totalScore = totalScore + score;
      } else if (course.grade == Grade.C) {
        final score = 3 * course.unit;
        totalUnit = totalUnit + course.unit;
        totalScore = totalScore + score;
      } else if (course.grade == Grade.D) {
        final score = 2 * course.unit;
        totalUnit = totalUnit + course.unit;
        totalScore = totalScore + score;
      } else {
        double score = 0;
        totalUnit = totalUnit + course.unit;
        totalScore = totalScore + score;
      }
    }
    obtainableScore = totalUnit * 5;
    return gpa = (totalScore / obtainableScore) * 5;
  }
}

final courseProvider = StateNotifierProvider<CourseNotifier, List<CourseModel>>(
  (ref) => CourseNotifier(),
);
