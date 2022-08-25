import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/models.dart';

class TeacherManager extends ChangeNotifier {
  late Teacher _teacher;

  Teacher get teacher => _teacher;

  Future<bool> getData(uid) async {
    final teacherData = await FirebaseFirestore.instance
        .collection('teacher')
        .doc(uid)
        .get()
        .then((doc) => doc.data()!);

    List<Student> students = [];
    for (final studentID in teacherData['students']) {
      final studentData = await FirebaseFirestore.instance
          .collection('student')
          .doc(studentID)
          .get()
          .then((doc) => doc.data()!);

      final List<Chapter> chapters = [];
      for (final chapterID in studentData['chapters']) {
        final chapterData = await FirebaseFirestore.instance
            .collection('chapter')
            .doc(chapterID)
            .get()
            .then((doc) => doc.data()!);
        chapters.add(Chapter.fromJSON(chapterData));
      }

      Student studentObject = Student.fromJSON(studentData);
      studentObject = studentObject.copyWith(chapter: chapters);
      students.add(studentObject);
    }

    Teacher teacherObject = Teacher.fromJSON(teacherData);
    _teacher = teacherObject.copyWith(userStudents: students);

    return true;
  }
}
