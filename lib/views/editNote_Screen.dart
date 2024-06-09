import 'package:app_ghi_chu/views/home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Đặt màu nền của AppBar thành màu xanh dương
        title: Text(
          "Chỉnh Sửa Ghi Chú", // Sửa tiêu đề của AppBar
          style: TextStyle(
            color:
                Colors.white, // Đặt màu chữ của tiêu đề AppBar thành màu trắng
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: noteController
                ..text = "${Get.arguments["note"].toString()}",
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection("notes")
                    .doc(Get.arguments["docId"].toString())
                    .update(
                  {
                    'note': noteController.text.trim(),
                  },
                ).then((value) => {
                          Get.offAll(() => HomeScreen()),
                          print("Data Updated"),
                        });
              },
              child: Text("Cập Nhật"),
            ),
          ],
        ),
      ),
    );
  }
}
