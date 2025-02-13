import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCTOqO0eEyVTPVdGwSCWYWs1HFIu7hqTP8",
        authDomain: "my-app-flutter-c23e5.firebaseapp.com",
        projectId: "my-app-flutter-c23e5",
        storageBucket: "my-app-flutter-c23e5.firebasestorage.app",
        messagingSenderId: "29952811754",
        appId: "1:29952811754:web:487ec412fa96abb6d42d93",
        measurementId: "G-WQZNEDEDEX"
    ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 42, 7, 88),
      )),
      home: HomePage(),
    );
  }
}
