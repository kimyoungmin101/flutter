import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/login_screen/sign_up/sign_up_screen.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/components/rounded_button.dart';
import 'package:p1_project/login_screen/sign_in/sign_in_screen.dart';
import 'package:p1_project/logout_screen/logout/logout_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "WELCOME TO CHAKHANI",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.07),
              Image.asset(
                "assets/images/log.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.1),
              RoundedButton(
                text: "LOGIN",
                color: kPrimaryColor,
                wid: 0.8,
                press: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                wid: 0.8,
                textColor: Colors.black,
                press: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
    );
  }
}
