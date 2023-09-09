import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:new_gpa/models/course_model.dart';
import 'package:new_gpa/providers/course_provider.dart';

class ModalBottomSheet extends ConsumerWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController courseName = TextEditingController();
    List<DropdownMenuEntry> items = [
      DropdownMenuEntry(value: Grade.A, label: Grade.A.name),
      DropdownMenuEntry(value: Grade.B, label: Grade.B.name),
      DropdownMenuEntry(value: Grade.C, label: Grade.C.name),
      DropdownMenuEntry(value: Grade.D, label: Grade.D.name),
      DropdownMenuEntry(value: Grade.F, label: Grade.F.name),
    ];

    List<DropdownMenuEntry> units = const [
      DropdownMenuEntry(value: 5, label: '5'),
      DropdownMenuEntry(value: 4, label: '4'),
      DropdownMenuEntry(value: 3, label: '3'),
      DropdownMenuEntry(value: 2, label: '2'),
      DropdownMenuEntry(value: 1, label: '1'),
    ];

    var selectedGrade = Grade.A;

    var selectedUnitG = 3;

    return SizedBox(
      height: 550,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 20,
        ),
        child: Column(
          children: [
            Text(
              'Add A Course',
              style: GoogleFonts.plusJakartaSans().copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 35,
              child: Row(
                children: [
                  const Text('COURSE:'),
                  const SizedBox(
                    width: 135,
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white70),
                      controller: courseName,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const Text('GRADE:'),
                  const Spacer(),
                  DropdownMenu(
                    key: ValueKey(items),
                    dropdownMenuEntries: items,
                    initialSelection: selectedGrade,
                    onSelected: (value) {
                      selectedGrade = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 35,
              child: Row(
                children: [
                  const Text('UNIT:'),
                  const Spacer(),
                  DropdownMenu(
                    key: ValueKey(units),
                    dropdownMenuEntries: units,
                    initialSelection: 3,
                    onSelected: (value) {
                      selectedUnitG = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (courseName.text.trim().isEmpty ||
                    courseName.text.trim().length >= 15) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Kindly Fill in All Credentials Correctly and Try Again..'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          )
                        ],
                      );
                    },
                  );
                  return;
                }
                ref.read(courseProvider.notifier).addCourse(
                      courseName.text,
                      selectedGrade,
                      selectedUnitG.toDouble(),
                    );

                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Course'),
            )
          ],
        ),
      ),
    );
  }
}
