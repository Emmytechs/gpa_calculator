import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:new_gpa/models/course_model.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(CupertinoIcons.book_circle),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${course.courseName.toUpperCase()} (Unit: ${course.unit})',
              style: GoogleFonts.plusJakartaSans().copyWith(fontSize: 16),
            ),
            Text(
              'Grade: ${course.grade.name}',
              style: GoogleFonts.plusJakartaSans().copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
