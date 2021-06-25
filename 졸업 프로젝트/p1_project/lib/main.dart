import 'package:flutter/material.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/id_nickname_value.dart';
import 'package:p1_project/routs.dart';
import 'package:p1_project/screens/splash/splash_screen.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/setting/link_value.dart';
import 'package:p1_project/url_list.dart';
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';
import 'package:p1_project/my_arr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool login_re =
      false; // 로그인된 상태를 나타내는 변수 , 로그인이 돼있으면 true로 입력돼서 앱소개 페이지 스킵됨!
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Value('123', '123', '123', true, 0)),
        ChangeNotifierProvider(create: (context) => IdValue('123', '123')),
        ChangeNotifierProvider(create: (context) => LinkValue()),
        ChangeNotifierProvider(create: (context) => Url_List([])),
        ChangeNotifierProvider(create: (context) => My_Arr([])),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '이거루바',
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Muli",
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kTextColor),
            bodyText2: TextStyle(color: kTextColor),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: login_re ? HomeScreen.routeName : SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
