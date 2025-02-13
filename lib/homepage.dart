import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/display.dart';
import 'package:flutter_application_1/screen/formscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [FormScreen(),DisplayScreen()]),
          backgroundColor: Color.fromARGB(255, 42, 7, 88),
          bottomNavigationBar: TabBar(tabs: [
            Tab(
              text: 'บันทึกคะแนนสอบ',
              icon: Icon(Icons.youtube_searched_for),
            ),
            Tab(
              
              text: 'รายชื่อนักศึกษา',
              icon: Icon(Icons.face),
            ),
          ]),
      ),
    );
  }
}