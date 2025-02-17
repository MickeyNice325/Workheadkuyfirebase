import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/screen/login.dart';
// import 'package:flutter_firebase/screen/home.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text("Error")),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text("Create Accout")),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email:",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator: MultiValidator([
                          EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                          RequiredValidator(errorText: "กรุณากรอกอีเมล")
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) {
                          profile.email = email;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Password:",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกพาสเวริด"),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (String? password) {
                          profile.password = password;
                        },
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState?.save();
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: profile.email.toString(),
                                        password: profile.password.toString())
                                    .then((value) {
                                  formkey.currentState!.reset();
                                  Fluttertoast.showToast(
                                      msg:
                                          "The user acount has been created successfully.",
                                      gravity: ToastGravity.CENTER);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                });
                              } on FirebaseAuthException catch (e) {
                                //e.code รูปแบบ exception
                                //e.message ข้อความแสดง error
                                String message = "";
                                if (e.code == "email-already-in-use") {
                                  message =
                                      "มีอีเมล์ในระบบแล้วโปรดใช้อีเมล์อื่นแทน";
                                } else if (e.code == "weak-password") {
                                  message =
                                      "กรุณาใช้รหัสผ่านที่มีความยาวเกิน 6 ตัวอักษรขึ้นไป";
                                } else {
                                  message = e.message!;
                                }
                                Fluttertoast.showToast(
                                    msg: message, gravity: ToastGravity.CENTER);
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
