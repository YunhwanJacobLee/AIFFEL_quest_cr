import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video_player_screen.dart';

const String SERVER_URL = "https://2072-119-204-54-208.ngrok-free.app"; 
const String GET_VIDEO_URL = "$SERVER_URL/get_3d_hpe_video"; // ✅ 동영상 API URL

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String? _videoUrl;  
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchVideo();
  }

  // 📌 API에서 동영상 가져오기
  Future<void> _fetchVideo() async {
    try {
      final response = await http.get(Uri.parse(GET_VIDEO_URL));

      if (response.statusCode == 200) {
        setState(() {
          _videoUrl = GET_VIDEO_URL; // ✅ API에서 받은 URL 그대로 사용
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "🚨 서버 오류: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "🚨 네트워크 오류: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📹 분석된 동영상")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // ✅ 로딩 화면
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red))) // ✅ 오류 메시지 표시
              : _videoUrl == null
                  ? Center(child: Text("🔍 동영상을 찾을 수 없습니다."))
                  : ListTile(
                      leading: Icon(Icons.video_library, size: 40, color: Colors.blue), // ✅ 아이콘 표시
                      title: Text("3D HPE 동영상"),
                      subtitle: Text(_videoUrl!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(videoUrl: _videoUrl!),
                          ),
                        );
                      },
                    ),
    );
  }
}
