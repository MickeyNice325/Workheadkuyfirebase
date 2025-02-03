import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Student.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Student myStudent = Student();
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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ชื่อ', style: TextStyle(fontSize: 20)),
                  TextFormField(onSaved: (String? fname) {
                    myStuden.fname = fname;
                  }),
                  SizedBox(height: 16),
                  Text('นามสกุล', style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),
                  Text('ห้อง', style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),
                  Text('อีเมล', style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(height: 16),
                  Text('คะแนนสอบ', style: TextStyle(fontSize: 20)),
                  TextFormField(),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child:
                          Text('บันทึกคะแนน', style: TextStyle(fontSize: 20)),
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
