import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:p1_project/components/rounded_button.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';

class Modify_Log extends StatefulWidget {
  @override
  Modify_LogState createState() => Modify_LogState();
}

class Modify_LogState extends State<Modify_Log> {
  static final storage = new FlutterSecureStorage();

  TextEditingController controllerId;
  TextEditingController passwordId;
  TextEditingController nicknameId;

  bool hidepassword = true; // 비밀번호 visible 변경을 위한 변수

  void initState() {
    super.initState();

    controllerId = TextEditingController();
    passwordId = TextEditingController();
    nicknameId = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerId.dispose();
    passwordId.dispose();
    nicknameId.dispose();
    super.dispose();
  }

  String userInfo = ""; //user의 정보를 저장하기 위한 변수
  String uid = "";
  String token = "";

  String result_uid = "";
  String result_token = "";

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");

    uid = userInfo.split(" ")[5];
    token = userInfo.split(" ")[7];
  }

  Future<dynamic> modifyProduct(token, uid, email, nickname, password) async {
    Map data = {
      "email": email,
      "nickname": nickname,
      "password": password,
    };
    String body = json.encode(data);
    return await http.put(Uri.parse("http://neuro.iptime.org:3080/user/$uid"),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("!!!!!!!!!code!!!!!!!!! $statusCode");
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        print('수정성공');
        Navigator.pop(context);

        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      });
    });
  }

  Future<dynamic> post(controllerId, passwordId) async {
    return await http.post(Uri.parse("http://neuro.iptime.org:3080/auth/neuro"),
        body: <String, String>{
          "email": controllerId,
          "password": passwordId
        },
        headers: {
          "Accept": "application/json"
        }).then((http.Response response) async {
      //      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        print('성공');
      }
      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        result_token = map["token"];
        result_uid = map["uid"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);
    Size size = MediaQuery.of(context).size;

    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Ok"),
        onPressed: () {
          modifyProduct(value.getToken(), value.getUid(), controllerId.text,
              nicknameId.text, passwordId.text);
          Navigator.pop(context, "Ok");
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Cancle"),
        onPressed: () {
          Navigator.pop(context, "Cancel");
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("정보수정"),
        content: Text("회원정보를 수정합니다."),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("회원정보수정"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: size.height * 0.03),
              Text(
                "아이디 비밀번호 재입력",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: size.height * 0.03),
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
                  cursorColor: kPrimaryColor,
                  controller: nicknameId,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: '닉네임',
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
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "회원정보수정",
                color: kPrimaryColor,
                wid: 0.8,
                press: () async {
                  await post(controllerId.text, passwordId.text);

                  showAlertDialog(context);
                },
              ),
              SizedBox(height: size.height * 0.03),
            ]),
          ),
        ),
      ),
    );
  }
}
