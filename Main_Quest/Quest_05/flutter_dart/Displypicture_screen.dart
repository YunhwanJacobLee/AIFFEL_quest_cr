import 'package:flutter/material.dart';
import 'dart:io';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("촬영된 사진")),
      body: Center(
        child: Image.file(File(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}
