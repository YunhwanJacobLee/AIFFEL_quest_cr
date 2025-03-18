import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _videoController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  // 📌 네트워크에서 동영상을 직접 로드하여 재생
  Future<void> _loadVideo() async {
    try {
      print("🔹 네트워크에서 동영상 가져오는 중: ${widget.videoUrl}");

      _videoController = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
            _videoController!.setLooping(true); // 🔄 반복 재생 설정
            _videoController!.play(); // ▶ 자동 재생
          });
        }).catchError((e) {
          print("🚨 동영상 재생 오류: $e");
        });
    } catch (e) {
      print("🚨 네트워크 오류: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📹 동영상 재생")),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // ✅ 로딩 중 표시
            : _videoController != null && _videoController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  )
                : const Text("❌ 동영상을 재생할 수 없습니다."),
      ),
    );
  }
}
