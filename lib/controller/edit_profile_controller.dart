import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../model/user_model.dart';

class EditProfileController with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  UserModel? userModel;
  static Future createUser({
    required String name,
    required String age,
  }) async {
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final user = UserModel(name: name, age: age);
    final json = user.toJson();
    await docUser.set(json);
  }

  static Future<UserModel?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
  }

  void displayName({String? name, String? age}) {
    nameController.text = name.toString();
    ageController.text = age.toString();
  }

  static void close(context) {
    Navigator.pop(context);
  }

  File? img;
  UploadTask? uploadTask;
  String? downloadUrl;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future uploadImage(context) async {
    final path = '${FirebaseAuth.instance.currentUser!.uid}images/';
    final file = File(img!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    downloadUrl = await ref.getDownloadURL();
    //uploading to cloud firebase
    final docUser = firebaseFirestore
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final user = UserModel(
        image: downloadUrl, age: ageController.text, name: nameController.text);
    final json = user.toJson();
    await docUser.set(json);

    notifyListeners();
    Navigator.pop(context);
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path);
      img = imageTemporary;
    }
    notifyListeners();
  }
}
