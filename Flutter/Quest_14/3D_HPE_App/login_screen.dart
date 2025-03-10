import 'package:flutter/material.dart';
import 'package:flutter_lab/3D_HPE_App/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  int emailCounter = 0;
  int passwordCounter = 0;

  String? registeredEmail;
  String? registeredPassword;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        emailCounter = emailController.text.length;
      });
    });
    passwordController.addListener(() {
      setState(() {
        passwordCounter = passwordController.text.length;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("알림"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

  void handleSignUp(BuildContext context) {
    setState(() {
      registeredEmail = emailController.text;
      registeredPassword = passwordController.text;
    });

    showPopup(context, "회원가입이 완료되었습니다.");

    emailController.clear();
    passwordController.clear();
    emailFocus.requestFocus();
  }

  void handleLogin(BuildContext context) {
    String inputEmail = emailController.text;
    String inputPassword = passwordController.text;

    if (inputEmail == registeredEmail && inputPassword == registeredPassword) {
      showPopup(context, "로그인 성공!");
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(email: inputEmail)),
        );
      });
    } else {
      showPopup(context, "로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
    }
  }

  void handleSubmit() {
    print("이메일: ${emailController.text}");
    print("비밀번호: ${passwordController.text}");
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField Counter"),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Image.asset(
                'images/medi.jpg',
                height: 150,
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                focusNode: emailFocus,
                style: TextStyle(fontSize: 15),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'examples@gmail.com',
                  hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                  helperText: 'Input your email address',
                  counterText: "$emailCounter characters",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                focusNode: passwordFocus,
                style: TextStyle(fontSize: 15),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  helperText: 'Input your password',
                  counterText: "$passwordCounter characters",
                  hintText: 'password',
                  hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => handleLogin(context),
                    child: Text("Submit"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => handleSignUp(context),
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
