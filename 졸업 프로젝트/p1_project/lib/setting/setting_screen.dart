import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/setting/components/body.dart';

class Setting extends StatefulWidget {
  static String routeName = "/setting";
  final String id;
  final String pass;
  Setting({this.id, this.pass});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
    return Scaffold(
        appBar: AppBar(
        title: Text(
        'SETTINGS',
        style: TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    elevation: 0,
    ),
      body: Body(),
    );
  }
}

