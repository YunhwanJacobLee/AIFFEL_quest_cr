import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isCat = true; // 초기값

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.cat, size: 30, color: Colors.white),
          onPressed: () {
            print("메뉴 클릭");
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isCat = false; // Next 버튼 클릭 시 isCat을 false로 변경
                });

                // isCat 값을 SecondPage로 전달
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage(isCat: isCat)),
                );

                if (result is bool) {
                  setState(() {
                    isCat = result; // SecondPage에서 전달된 값으로 isCat 업데이트
                  });
                }
              },
              child: Text('Next'),
            ),
            SizedBox(height: 20), // 간격 추가
            GestureDetector(
              onTap: () {
                print("isCat 상태: $isCat"); // 콘솔 출력 (isCat 값 유지)
              },
              child: Image.asset(
                'images/cat2.jpg', // 상태에 따라 이미지 변경
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget { //fisrtpage에서 isCat 값을 전달받기 위해 필요.
  final bool isCat;
  SecondPage({required this.isCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.dog, size: 30, color: Colors.white),
          onPressed: () {
            print("메뉴 클릭");
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          children: [
            ElevatedButton(
              onPressed: () {
                // Back 버튼을 누르면 isCat을 true로 변경하여 FirstPage로 전달
                Navigator.pop(context, true);
              },
              child: Text('Back'),
            ),
            SizedBox(height: 20), // 간격 추가
            GestureDetector(
              onTap: () {
                print("isCat 상태: $isCat"); // SecondPage에서 isCat 상태 출력
              },
              child: Image.asset(
                'images/dog.jpg', // 강아지 이미지
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//회고: second에서 first로 다시 돌아갈 때 데이터 전달을 임의로 ture로 주었는데. isCat에서 자동으로 전달하는 방법이 있으면 좋겠다.
// await를 추가하면 다 돌기 전까지 update가 안되는 기능을 처음 알게 되었다.
// first는 변경이 필요해서 statefull, seconde는 값을 변경할 필요가 없어서 stateless