import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/login_screen/sign_in/sign_in_screen.dart';
import 'package:p1_project/logout_screen/logout/logout_screen.dart';

class Logout_Setting extends StatefulWidget {
  @override
  _Logout_SettingState createState() => _Logout_SettingState();
}

class _Logout_SettingState extends State<Logout_Setting> {
  static final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });

  }

  String userInfo = ""; //user의 정보를 저장하기 위한 변수

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");
    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LogOutPage(
                id: userInfo.split(" ")[1],
                pass: userInfo.split(" ")[3],
                uid: userInfo.split(" ")[5],
                token: userInfo.split(" ")[7],
              )));
    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
              )));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
