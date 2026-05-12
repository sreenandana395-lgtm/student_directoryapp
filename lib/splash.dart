import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Studentdirectory(),)
      );
    });
    return Scaffold(backgroundColor: Colors.white,
    body: Center(child: Lottie.asset("assets/Student.json"),),);
  }
}
