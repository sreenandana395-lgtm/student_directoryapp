import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_directoryapp/firebase_options.dart';
import 'package:student_directoryapp/splash.dart';
import 'package:student_directoryapp/studentdirectory.dart';

void main()async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    home: Splash()
    );
  }
}
