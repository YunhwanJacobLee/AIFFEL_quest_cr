import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analysis"),
      automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(child: Text("Analysis Screen")),
    );
  }
}
