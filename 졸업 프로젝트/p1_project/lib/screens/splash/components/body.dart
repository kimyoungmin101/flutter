import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/screens/splash/components/splash_content.dart';
import 'package:p1_project/size_config.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';

import '../../../id_nickname_value.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  String userInfo = ""; //user의 정보를 저장하기 위한 변수
  String email = "";
  String password = "";
  String uid = "";
  String token = "";
  String nickname = "";

  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");
    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.


    if (userInfo != null) {
      email = userInfo.split(" ")[1];
      password = userInfo.split(" ")[3];
      uid = userInfo.split(" ")[5];
      token = userInfo.split(" ")[7];

      Navigator.pop(context);

      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName, (route)=> false,
      );
    }
  }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/splash_1.png"
    },
    {
      "image": "assets/images/splash_2.png"
    },
    {
      "image": "assets/images/splash_3.png"
    },

  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SizedBox(

        child: Column(

          children: [
            Expanded(

              flex: 3, // 차지하는 공간 크기
              child: PageView.builder(

                // 페이지를 슬라이드로 볼 수 있는 PageView 선언
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length, // splashData가 3개이기 때문에 크기가 3이다.
                itemBuilder: (context, index) => SplashContent( // 따로 Splashcontent 클래스 생성하여 주었음. text와 image를 입력값으로 받음
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(

                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [

                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(splashData.length, (index) => BuildDot(index : index)),
                      ),
                      Spacer(flex: 3),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        },
                      ),                      Spacer(),
                    ],
                  ),
                )),

          ],
        ),
      ),
    );
  }

  AnimatedContainer BuildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 7),
      height: 6,
      width: currentPage == index ? 10 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.deepOrange : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.deepOrange,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

