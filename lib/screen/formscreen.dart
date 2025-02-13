import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Student.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Student myStudent = Student();
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _studentCollection = FirebaseFirestore.instance.collection('student');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          //กรณีที่มีerror เกิดขี้นจากการเชื่อมต่อ
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('${snapshot.error}')),
            );
          }
          //ถ้าเข้าได้
          if (snapshot.connectionState == ConnectionState.done) {
return Scaffold(
              appBar: AppBar(
                title: Text("แบบฟอร์มบันทึกคะแนนสอบ"),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ชื่อ",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator:
                                  RequiredValidator(errorText: "กรุณกรอกชื่อ"),
                              onSaved: (String? fname) {
                                myStudent.fname = fname;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "นามสกุล",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณกรอกนามสกุล"),
                              onSaved: (String? lname) {
                                myStudent.lname = lname;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "ห้อง",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator:
                                  RequiredValidator(errorText: "กรุณกรอกห้อง"),
                              onSaved: (String? room) {
                                myStudent.room = room;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "อีเมล",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: MultiValidator([
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                                RequiredValidator(errorText: "กรุณากรอกอีเมล")
                              ]),
                              onSaved: (String? email) {
                                myStudent.email = email;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "คะแนนสอบ",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณกรอกคะแนนสอบ"),
                              onSaved: (String? score) {
                                myStudent.score = score;
                              },
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    await _studentCollection.add({
                                      "fname": myStudent.fname,
                                      "lname": myStudent.lname,
                                      "room": myStudent.room,
                                      "email": myStudent.email,
                                      "score": myStudent.score,
                                    });
                                    formKey.currentState!.reset();
                                  }
                                },
                                child: Text(
                                  "บันทึกคะแนน",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 16, 68, 255)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.blue[50],
            );
          }
          //กรณีที่ไม่เกิด Error ให้โหลดข้อมูลหน้าแอป
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
