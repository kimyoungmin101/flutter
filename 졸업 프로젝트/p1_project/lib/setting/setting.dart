import 'package:p1_project/setting/components/terms.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
      body: Center(
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
                  context,
                  MaterialPageRoute(builder: (context) => Terms()),
                );
              },
            ),
            ListTile(
              title: Text('개인정보 처리방침'),
              trailing: Icon(Icons.navigate_next),
              onTap: (){},
            ),
            ListTile(
              title: Text('버전정보'),
              trailing: Icon(Icons.navigate_next),
              onTap: (){},
            ),
            ListTile(
              title: Text('회원탈퇴'),
              trailing: Icon(Icons.navigate_next),
              onTap: (){},
            ),
            ListTile(
              title: Text('회원정보 수정'),
              trailing: Icon(Icons.person),
              onTap: (){

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
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
