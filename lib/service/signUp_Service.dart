// signUpService.dart
// ignore_for_file: avoid_print

import 'package:app_ghi_chu/views/login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

signUpUser(String userName, String userPhone, String userEmail,
    String userPassword) async {
  User? user = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      'userName': userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'createdAt': DateTime.now(),
    }).then((value) => {
          FirebaseAuth.instance.signOut(),
          Get.to(() => const LoginScreen()),
        });
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
