import 'package:flutter/material.dart';
import 'package:flutter_lab/3D_HPE_App/Exercise_detail_screen.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String label;
  CategoryDetailScreen({required this.label});

  final Map<String, List<Map<String, String>>> categoryExercises = {
    'Chest': [
      {'name': '벤치 프레스', 'description': '가슴 근육을 키우는 대표적인 운동.', 'image': 'benchmain.jpg', 'video': 'https://youtube.com/bench_press'},
      {'name': '덤벨 플라이', 'description': '가슴을 스트레칭하고 발달시키는 운동.', 'image': 'fly.jpg', 'video': 'https://youtube.com/dumbbell_fly'},
      {'name': '푸쉬업', 'description': '기본적인 가슴 및 상체 운동.', 'image': 'pushup.jpg', 'video': 'https://youtube.com/push_up'},
      {'name': '풀오버', 'description': '기본적인 가슴 및 상체 운동.', 'image': 'pullover.jpg', 'video': 'https://youtube.com/push_up'}, // 이미지 없음
    ],
    'Back': [
      {'name': '랫풀다운', 'description': '등 근육을 단련하는 기본적인 운동.', 'image': 'lat_pulldown.jpg', 'video': 'https://youtube.com/lat_pulldown'},
      {'name': '바벨 로우', 'description': '등의 두께를 키우는 운동.', 'image': '', 'video': 'https://youtube.com/barbell_row'}, // ✅ 이미지 없음
    ],
  };

  @override
  Widget build(BuildContext context) {
    final exercises = categoryExercises[label] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Image.asset(
                  exercise['image'] != null && exercise['image']!.isNotEmpty
                      ? 'images/${exercise['image']}'
                      : 'images/default.jpg', // ✅ 기본 이미지
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(exercise['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(exercise['description']!),
                trailing: Icon(Icons.fitness_center, color: Colors.blueAccent),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseDetailScreen(
                        exerciseName: exercise['name']!,
                        description: exercise['description']!,
                        videoUrl: exercise['video']!,
                        imagePath: exercise['image'], // ✅ 이미지 경로 추가
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
