import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบฟอมร์บันทึกคะแนนสอบ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ชื่อ',style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),  
                  Text('นามสกุล',style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),
                  Text('ห้อง',style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),
                  Text('อีเมล',style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),
                  Text('คะแนนสอบ',style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('บันทึกคะแนน', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blue[50],
    );
  }
}
