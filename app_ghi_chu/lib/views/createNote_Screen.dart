import 'package:app_ghi_chu/views/home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Đặt màu nền của AppBar thành màu xanh dương
        title: Text(
          "Thêm Ghi Chú", // Sửa tiêu đề của AppBar
          style: TextStyle(
            color:
                Colors.white, // Đặt màu chữ của tiêu đề AppBar thành màu trắng
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Thêm Ghi Chú",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var note = noteController.text.trim();
                if (note != "") {
                  try {
                    await FirebaseFirestore.instance
                        .collection('notes')
                        .doc()
                        .set({
                      "createAt": DateTime.now(),
                      "note": note,
                      "userId": userId?.uid,
                    });
                  } catch (e) {
                    print("Error $e");
                  }
                }
                Get.offAll(() => HomeScreen());
              },
              child: const Text("Thêm Ghi Chú"),
            )
          ],
        ),
      ),
    );
  }
}
