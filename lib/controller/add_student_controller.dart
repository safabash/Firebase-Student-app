import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/students_model.dart';

class AddStudentController with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  StudentModel? studentModel;
  void createUser({
    required String name,
    required String age,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('students').doc();
    final user = StudentModel(name: name, age: age);
    final json = user.toJson();
    await docUser.set(json);
    notifyListeners();
  }

  Stream<List<StudentModel?>> readUser() => FirebaseFirestore.instance
      .collection('students')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList);

  notifyListeners();
}
