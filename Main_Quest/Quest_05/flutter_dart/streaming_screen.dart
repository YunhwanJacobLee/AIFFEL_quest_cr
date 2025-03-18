import 'package:flutter/material.dart';

class StreamingScreen extends StatefulWidget {
  @override
  _StreamingScreenState createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  String _serverUrl = "http://119.204.54.208:5000/upload_video"; // 🔥 서버 스트리밍 URL
  Image? _imageStream;

  void _startStreaming() {
    setState(() {
      _imageStream = Image.network("$_serverUrl");  // 🔥 서버에서 이미지 스트리밍 받기
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📷 실시간 HPE 스트리밍")),
      body: Center(
        child: _imageStream ?? Text("스트리밍을 시작하려면 버튼을 누르세요."),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startStreaming,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
