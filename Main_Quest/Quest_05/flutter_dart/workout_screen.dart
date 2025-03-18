import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera_function/3D_HPE_App/Category_detail_screen.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/squat1.mp4') // ✅ 경로 수정
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView( // ✅ 스크롤 가능하도록 변경
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            // AI 트레이너 설명
            Center(
              child: Column(
                children: [
                  Text("Medi-3D-Pose와 함께",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                  Text("자세를 교정해 보세요.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 3D Human Pose Estimation 설명
            Text("3D Human Pose Estimation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // 📌 동영상 재생 영역
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  SizedBox(height: 10),

                  // 📌 동영상 설명
                  Text(
                    "Medi-3D-Pose는 인공지능 기반의 운동 동작 평가 시스템으로,\n 물리적 마커 없이도 3차원 동작 분석이 가능합니다.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 📌 운동 카테고리 추가
            Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // 📌 가로 스크롤 가능한 운동 카테고리 리스트 추가
            SizedBox(
              height: 200, // ✅ 높이 지정
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 10),
                  CategoryCard(imagePath: 'images/chest.jpg', label: 'Chest'),
                  SizedBox(width: 10),
                  CategoryCard(imagePath: 'images/back.png', label: 'Back'),
                  SizedBox(width: 10),
                  CategoryCard(imagePath: 'images/leg.jpg', label: 'Leg'),
                  SizedBox(width: 10),
                  CategoryCard(imagePath: 'images/arm.jpg', label: 'Arm'),
                  SizedBox(width: 10),
                  CategoryCard(imagePath: 'images/shoulder.png', label: 'Shoulder'),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 운동 카테고리 카드 UI
class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;

  CategoryCard({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryDetailScreen(label: label)));
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
