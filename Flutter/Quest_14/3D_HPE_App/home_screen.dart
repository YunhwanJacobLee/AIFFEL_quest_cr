import 'package:flutter/material.dart';
import 'package:flutter_lab/3D_HPE_App/Category_detail_screen.dart';
import 'package:flutter_lab/3D_HPE_App/Analysis_screen.dart';
import 'package:flutter_lab/3D_HPE_App/Record_screen.dart';
import 'package:flutter_lab/3D_HPE_App/Profile_screen.dart';
import 'package:flutter_lab/3D_HPE_App/workout_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  HomeScreen({required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // 각 탭에 표시될 화면 리스트
  final List<Widget> _screens = [
    WorkoutScreen(), // Workout이 홈 화면 역할
    AnalysisScreen(),
    RecordScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 현재 선택된 탭 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 뒤로가기 버튼 막음
      child: Scaffold(
        body: _screens[_selectedIndex], // 선택된 탭의 화면을 표시
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workout'),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analysis'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Record'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
