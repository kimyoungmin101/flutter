import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/setting/components/delete_Id.dart';
import 'package:p1_project/setting/components/log_modify.dart';
import 'package:p1_project/setting/components/logout_Setting.dart';
import 'package:p1_project/setting/components/terms.dart';
import 'package:p1_project/setting/components/term_2.dart';
import 'package:p1_project/setting/components/version.dart';
class Body extends StatefulWidget {
  final String id;
  final String pass;
  Body({this.id, this.pass});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static final storage = FlutterSecureStorage();
  //데이터를 이전 페이지에서 전달 받은 정보를 저장하기 위한 변수
  String id;
  String pass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //widget.id는 LogOutPage에서 전달받은 id를 의미한다.
    pass = widget.pass; //widget.pass LogOutPage에서 전달받은 pass 의미한다.
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.black12,
            height: 40,
            alignment: Alignment.centerLeft,
            child: Text('서비스 정보', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('이용약관'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
                  context,  // 기본 파라미터, SecondRoute로 전달
                  MaterialPageRoute(builder: (context)=>Terms()) // SecondRoute를 생성하여 적재
              );
            },
          ),
          ListTile(
            title: Text('개인정보 처리방침'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Term_2()),
              );
            },
          ),
          ListTile(
            title: Text('버전정보'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => version()),
              );
            },
          ),
          ListTile(
            title: Text('회원탈퇴'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeleteID(
                    )),
              );
            },
          ),
          ListTile(
            title: Text('회원정보 수정'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Modify_Log()
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.black12,
            height: 40,
            alignment: Alignment.centerLeft,
          ),
          ListTile(
            title: Text('로그아웃'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Logout_Setting(
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
