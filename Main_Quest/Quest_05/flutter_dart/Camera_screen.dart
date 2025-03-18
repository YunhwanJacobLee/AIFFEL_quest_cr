import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isRecording = false;
  String _serverUrl = "https://2072-119-204-54-208.ngrok-free.app"; // ✅ 서버 주소
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  /// ✅ App Lifecycle 관리 (앱이 백그라운드로 가면 카메라 중지)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  /// ✅ 카메라 초기화
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print("🚨 No cameras available");
      return;
    }

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );

    try {
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      if (mounted) setState(() {});
    } catch (e) {
      print("🚨 카메라 초기화 오류: $e");
    }
  }

  /// ✅ 녹화 시작
  Future<void> _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _controller!.startVideoRecording();
      setState(() {
        _isRecording = true;
      });

      print("📷 녹화 시작");
    } catch (e) {
      print("🚨 녹화 오류: $e");
    }
  }

  /// ✅ 녹화 종료 & 영상 서버 전송
  Future<void> _stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;

    try {
      final videoFile = await _controller!.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      print("✅ 녹화 종료: ${videoFile.path}");

      await _uploadVideo(videoFile.path);
    } catch (e) {
      print("🚨 녹화 종료 오류: $e");
    }
  }

  /// ✅ 영상 서버 전송 (HPE 적용 없음)
  Future<void> _uploadVideo(String videoPath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse("$_serverUrl/upload_video"));
      request.files.add(await http.MultipartFile.fromPath('file', videoPath));

      var response = await request.send();
      if (response.statusCode == 200) {
        print("✅ 영상 전송 완료");
      } else {
        print("🚨 영상 전송 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 영상 전송 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📷 HPE 촬영 (전송만)")),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return Center(child: CircularProgressIndicator()); // ✅ 로딩 표시
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isRecording ? Colors.red : Colors.green,
        onPressed: _isRecording ? _stopRecording : _startRecording,
        child: Icon(_isRecording ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
