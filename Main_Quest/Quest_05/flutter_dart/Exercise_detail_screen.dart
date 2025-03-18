import 'package:flutter/material.dart';
import 'package:camera_function/3D_HPE_App/Camera_screen.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String exerciseName;
  final String description;
  final String videoUrl;
  final String? imagePath; // 이미지 경로 추가 (nullable)

  ExerciseDetailScreen({
    required this.exerciseName,
    required this.description,
    required this.videoUrl,
    this.imagePath, // nullable 처리
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  imagePath != null && imagePath!.isNotEmpty
                      ? 'images/$imagePath' // 해당 운동의 이미지
                      : 'images/default.jpg', // 기본 이미지
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'images/default.jpg', // 이미지가 없으면 기본 이미지
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              exerciseName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            Text(
              "추천 동영상",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("유튜브 영상 링크: $videoUrl"),
                  ));
                },
                child: Text("추천 영상 보기"),
              ),
            ),

            SizedBox(height: 30),

            // ✅ 운동 시작 버튼 & 카메라 버튼 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // ✅ CameraScreen으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text("운동 시작", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 10), // 버튼 간격

                // 📌 카메라 아이콘 버튼 추가
                IconButton(
                  icon: Icon(Icons.videocam, color: Colors.blueAccent, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
