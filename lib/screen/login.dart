import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/register2.dart';
// import 'package:flutter_firebase/screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              appBar: AppBar(title: Text("Login Page")),
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
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState?.save();
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: profile.email.toString(),
                                        password: profile.password.toString())
                                    .then((value) {
                                  formkey.currentState!.reset();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Homescreen(),
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
                      ),
                      SizedBox(height: 15), // Add spacing
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterScreen1()), // Navigate to SignUpScreen
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ),
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

class LogoutScreen extends StatelessWidget {
  //const LogoutScreen({super.key});
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("ยินดีต้อนรับ " + auth.currentUser!.email.toString()),
          Container(
            child: SizedBox(
                child: ElevatedButton.icon(
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Homescreen();
                  }));
                });
              },
            )),
          ),
        ],
      ),
    );
  }
}
