import 'package:flutter/material.dart';
import 'package:flutter_lab/3D_HPE_App/login_screen.dart';
import 'package:flutter_lab/3D_HPE_App/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
