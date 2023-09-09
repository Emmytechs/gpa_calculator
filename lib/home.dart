import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_gpa/bottom_sheet.dart';
import 'package:new_gpa/course_list.dart';
import 'package:new_gpa/providers/course_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() {
    return _HomeState();
  }
}

Widget floatingActionBar(context) {
  return Material(
    borderRadius: BorderRadius.circular(40),
    color: Colors.lightBlueAccent,
    child: InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          builder: (context) {
            return const ModalBottomSheet();
          },
        );
      },
      splashColor: Colors.white,
      child: const SizedBox(
        height: 60,
        width: 60,
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    ),
  );
}

class _HomeState extends ConsumerState<Home> {
  double gpaScore = 0.00;
  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(courseProvider);

    Widget bottomBar() {
      return Container(
        height: 40,
        width: double.infinity,
        color: const Color.fromARGB(148, 73, 71, 71),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'GPA:',
              style: GoogleFonts.plusJakartaSans().copyWith(fontSize: 20),
            ),
            Text(
              gpaScore.toStringAsFixed(2),
              style: GoogleFonts.plusJakartaSans().copyWith(fontSize: 20),
            ),
          ],
        ),
      );
    }

    Widget mainScreen() {
      if (courses.isEmpty) {
        return Center(
          child: Text(
            'No Course Added Yet',
            style: GoogleFonts.plusJakartaSans().copyWith(fontSize: 20),
          ),
        );
      }

      return Column(
        children: [
          SizedBox(
            height: 600,
            width: double.infinity,
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseList(course: courses[index]);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              final calculated = ref.read(courseProvider.notifier).calcGpa();
              setState(() {
                gpaScore = calculated;
              });
            },
            child: const Text('Calculate'),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(courseProvider.notifier).cleanCourse();
              setState(() {
                gpaScore = 0.00;
              });
            },
            icon: const Icon(CupertinoIcons.restart),
          )
        ],
        title: Text(
          'GPA CALC.',
          style: GoogleFonts.plusJakartaSans().copyWith(color: Colors.white),
        ),
      ),
      floatingActionButton: floatingActionBar(context),
      bottomNavigationBar: bottomBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mainScreen(),
      ),
    );
  }
}
