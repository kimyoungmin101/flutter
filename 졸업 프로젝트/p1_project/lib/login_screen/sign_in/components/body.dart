import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1_project/components/rounded_button.dart';
import 'package:p1_project/login_screen/sign_up/sign_up_screen.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p1_project/logout_screen/logout/logout_screen.dart';
import 'package:p1_project/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final String email;
  final String password;

  const Body({
    Key key,
    this.email,
    this.password,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState(email, password);
}

class _BodyState extends State<Body> {
  dynamic token;
  dynamic uid;
  bool _islogin = false;

  String _email;
  String _password;

  String name = "";
  String email = "";
  String url = "";
  bool checkIdValue = true; //중복 ID 확인

  static final storage =
      new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  _BodyState(String email, String password) {
    _email = email;
    _password = password;
  }

  TextEditingController controllerId;
  TextEditingController passwordId;

  void initState() {
    super.initState();
    controllerId = TextEditingController();
    passwordId = TextEditingController();
  }

  bool result = false;
  bool realresult = false;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerId.dispose();
    passwordId.dispose();
    super.dispose();
  }

  Future<dynamic> post(controllerId, passwordId) async {
    return await http.post(Uri.parse("http://neuro.iptime.org:3080/auth/neuro"),
        body: <String, String>{"email": controllerId, "password": passwordId},
        headers: {"Accept": "application/json"}).then((http.Response response) {
      //      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        token = map["token"];
        uid = map["uid"];
        print(token);
        print(uid);

        if (token != null) {
          result = true;

          Navigator.pop(context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
          // 이전화면들 모두 삭제하기
        }
      });
    });
  }

  bool hidepassword = true; // 비밀번호 visible 변경을 위한 변수
  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "로그인",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              Image.asset(
                "assets/images/dancer.png",
                height: size.height * 0.35,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  cursorColor: kPrimaryColor,
                  controller: controllerId,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: '아이디',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  obscureText: hidepassword,
                  controller: passwordId,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidepassword = !hidepassword;
                        });
                      },
                      color: kPrimaryColor,
                      icon: Icon(hidepassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      //비밀번호가 보이게하기, 안보이게하기 클릭으로 아이콘 모양 변경
                    ),
                    hintText: '비밀번호',
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoundedButton(
                text: "로그인",
                color: kPrimaryColor,
                wid: 0.8,
                press: () async {
                  await post(controllerId.text, passwordId.text);

                  // write 함수를 통하여 key에 맞는 정보를 적게 됩니다.
                  //{"login" : "id id_value password password_value"}
                  //와 같은 형식으로 저장이 됨
                  value.setUid(uid);
                  value.setToken(token);

                  print("!!!!!!!!!!!!!!!!!!!!token!!!!!!!: " + token);

                  await storage.write(
                      key: "login",
                      value: "id " +
                          controllerId.text.toString() +
                          " " +
                          "password " +
                          passwordId.text.toString() +
                          " " +
                          "token " +
                          token.toString() +
                          " " +
                          "uid " +
                          uid.toString());

                  if (result == false) {
                    realresult = true;
                  }
                },
              ),
              Text(
                realresult ? '로그인정보를 확인해주세요' : '',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: size.height * 0.04),
              Align(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('계정이 없으신가요 ?  '),
                  InkWell(
                    child: Text(
                      '가입하기',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
