// ignore_for_file: unnecessary_null_comparison

import 'package:app_ghi_chu/views/createNote_Screen.dart';
import 'package:app_ghi_chu/views/editNote_Screen.dart';
import 'package:app_ghi_chu/views/login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Đặt màu nền của AppBar thành màu xanh dương
        title: const Text("Ghi Chú"), // Sửa tiêu đề của AppBar
        actions: [
          PopupMenuButton<int>(
            color: Colors.white, // Màu nền của menu
            onSelected: (item) {
              if (item == 0) {
                FirebaseAuth.instance.signOut();
                Get.off(() => const LoginScreen());
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red), // Đặt màu và icon cho nút logout
                    SizedBox(width: 10), // Khoảng cách giữa icon và text
                    Text('Logout', style: TextStyle(color: Colors.black)), // Đặt màu chữ và kiểu chữ cho text
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("notes")
                  .where("userId", isEqualTo: userId?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Có lỗi xảy ra!");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Không có dữ liệu!"));
                }
                if (snapshot != null && snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var note = snapshot.data!.docs[index]['note'];
                      var noteId = snapshot.data!.docs[index]['userId'];
                      var docId = snapshot.data!.docs[index].id;
                      return Card(
                        child: ListTile(
                            title: Text(
                              note,
                            ),
                            subtitle: Text(noteId),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => EditNoteScreen(), arguments: {
                                      'note': note,
                                      'docId': docId,
                                    });
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      FirebaseFirestore.instance
                                          .collection("notes")
                                          .doc(docId)
                                          .delete();
                                    },
                                    child: const Icon(Icons.delete)),
                              ],
                            )),
                      );
                    },
                  );
                }
                return Container();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateNoteScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
