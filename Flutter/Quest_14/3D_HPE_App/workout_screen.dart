import 'package:flutter/material.dart';
import 'package:flutter_lab/3D_HPE_App/Category_detail_screen.dart';
import 'package:video_player/video_player.dart'; // 비디오 플레이어 추가

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/squat1.mp4') // 영상 파일 경로
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
      body: SingleChildScrollView(
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
            SizedBox(height: 10),

            // 3D Pose Estimation 영상
            Text("3D Human Pose Estimation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // 비디오 플레이어 컨테이너
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

                  // 동영상 설명 (테두리 없이)
                  Text(
                    "Medi-3D-Pose는 인공지능 기반의 운동 동작 평가 시스템으로,\n 물리적 마커 없이도 3차원 동작 분석이 가능합니다.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    CategoryCard(imagePath: 'images/chest.jpg', label: 'Chest'),
                    SizedBox(width: 15),
                    CategoryCard(imagePath: 'images/back.png', label: 'Back'),
                    SizedBox(width: 15),
                    CategoryCard(imagePath: 'images/leg.jpg', label: 'Leg'),
                    SizedBox(width: 15),
                    CategoryCard(imagePath: 'images/arm.jpg', label: 'Arm'),
                    SizedBox(width: 15),
                    CategoryCard(imagePath: 'images/shoulder.png', label: 'Shoulder'),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
