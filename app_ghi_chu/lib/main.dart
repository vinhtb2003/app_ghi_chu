// main.dart
// ignore_for_file: override_on_non_overriding_member

import 'package:app_ghi_chu/views/home_Screen.dart';
import 'package:app_ghi_chu/views/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Ghi Chu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}
