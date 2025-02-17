import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_application_1/screen/register2.dart';
//import 'package:flutter_firebase/screen/register.dart';

//import 'package:flutter_firebase/screen/studentscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/236/236831.png',
              height: 450,
            ),
            //Image.asset("assets/man.png"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("เข้าสู่ระบบ"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text("สร้างบัญชีผู้ใช้"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterScreen1();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
