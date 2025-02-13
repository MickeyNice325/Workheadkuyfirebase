import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore import

class DisplayDataScreen extends StatelessWidget {
  const DisplayDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลนักเรียน'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // ดึงข้อมูลจาก Firestore Collection ที่ชื่อ "student"
        stream: FirebaseFirestore.instance.collection('student').snapshots(),
        builder: (context, snapshot) {
          // กรณีที่กำลังโหลดข้อมูล
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // กรณีมีข้อผิดพลาดในการดึงข้อมูล
          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }

          // กรณีข้อมูลถูกดึงสำเร็จ
          if (!snapshot.hasData) {
            return Center(child: Text('ไม่มีข้อมูล'));
          }

          // แสดงข้อมูลใน ListView
          var data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var student = data[index];
              return ListTile(
                title: Text('${student['fname']} ${student['lname']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ห้อง: ${student['room']}'),
                    Text('อีเมล: ${student['email']}'),
                    Text('คะแนน: ${student['score']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
