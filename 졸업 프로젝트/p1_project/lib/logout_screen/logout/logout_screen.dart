import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1_project/components/rounded_button.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants.dart';

class LogOutPage extends StatefulWidget {
  //로그인 정보를 이전 페이지에서 전달 받기 위한 변수
  final String id;
  final String pass;
  final String token;
  final String uid;

  LogOutPage({this.id, this.pass, this.token, this.uid});
  @override
  _LogOutPage createState() => _LogOutPage();
}

class _LogOutPage extends State<LogOutPage> {
  static final storage = FlutterSecureStorage();
  //데이터를 이전 페이지에서 전달 받은 정보를 저장하기 위한 변수
  String id;
  String pass;
  String token;
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //widget.id는 LogOutPage에서 전달받은 id를 의미한다.
    pass = widget.pass; //widget.pass LogOutPage에서 전달받은 pass 의미한다.
    token = widget.token;
    uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logout Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID : " + id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 15,
            ),
            Text("로그인 중입니다. 로그아웃 하시겠습니까 ?", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(
              height: 35,
            ),
            RoundedButton(
              text : 'Logout',
              color: kPrimaryColor,
              wid: 0.8,

              press: () {
                //delete 함수를 통하여 key 이름이 login인것을 완전히 폐기 시켜 버린다.
                //이를 통하여 다음 로그인시에는 로그인 정보가 없어 정보를 불러 올 수가 없게 된다.
                storage.delete(key: "login");
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName, (route)=> false,
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
