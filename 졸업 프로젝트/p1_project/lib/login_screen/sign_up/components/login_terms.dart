import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/login_screen/sign_up/components/complete.dart';
import 'package:http/http.dart' as http;

class Login_terms extends StatefulWidget {
  static String routeName = "/Login_terms";

  final String email;
  final String nickname;
  final String password;

  const Login_terms({
    Key key,
    this.email,
    this.nickname,
    this.password,
  }) : super(key: key);

  @override
  _Login_termsState createState() => _Login_termsState(email, nickname, password);

  }

class _Login_termsState extends State<Login_terms> {
  String _nickname;
  String _password;
  String _name;

  bool status_reusult = false;

  _Login_termsState(String nickname, String password, String name){
    _nickname = nickname;
    _password = password;
    _name = name;
  }


  bool _allValue = false;
  bool _serviceValue = false;
  bool _dataValue = false;
  bool _adValue = false;


  void _allValueChanged(bool value) =>
      setState(() {
        _allValue = value;
        _serviceValue = value;
        _dataValue = value;
        _adValue = value;
      });

  void _serviceValueChanged(bool value) =>
      setState(() {
        if (_allValue == true) {
          _allValue = value;
          _serviceValue = value;
        } else {
          _serviceValue = value;
        }
      });

  void _dataValueChanged(bool value) =>
      setState(() {
        if (_allValue == true) {
          _allValue = value;
          _dataValue = value;
        } else {
          _dataValue = value;
        }
      });

  void _adValueChanged(bool value) =>
      setState(() {
        if (_allValue == true) {
          _allValue = value;
          _adValue = value;
        } else {
          _adValue = value;
        }
      });

  Function _buttonController() {
    return (){
      Navigator.pushNamed(context, Complete.routeName);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '약관 동의',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(),
              child: Text(
                '저희 NeuroAsociates는 회원님의 개인 정보를 안전하게 보호하고 있습니다. 회원 가입을 위해 아래 약관을 확인하시고 동의해 주세요.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40,),
            ListTile(
              title: Text('모두 동의'),
              trailing: Checkbox(
                value: _allValue,
                onChanged: _allValueChanged,
                activeColor: Colors.black,
              ),
            ),
            ListTile(
              title: Text('서비스 약관(필수)'),
              subtitle: InkWell(
                child: Text(
                  '자세히 보기',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                onTap: () {},
              ),
              trailing: Checkbox(
                  value: _serviceValue,
                  onChanged: _serviceValueChanged,
                  activeColor: Colors.black),
            ),
            ListTile(
              title: Text('데이터 정책(필수)'),
              subtitle: InkWell(
                child: Text(
                  '자세히 보기',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                onTap: () {},
              ),
              trailing: Checkbox(
                  value: _dataValue,
                  onChanged: _dataValueChanged,
                  activeColor: Colors.black),
            ),
            ListTile(
              title: Text('광고 및 이벤트 알림(선택)'),
              subtitle: InkWell(
                child: Text(
                  '자세히 보기',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                onTap: () {},
              ),
              trailing: Checkbox(
                  value: _adValue,
                  onChanged: _adValueChanged,
                  activeColor: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, left: 15, top: 30),
              width: 700,
              height: 50,
                child: ElevatedButton(
                child: Text('다음'),
                onPressed:
                    _serviceValue && _dataValue ? _buttonController() : null,

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return kPrimaryLightColor;
                      }
                      return kPrimaryColor;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}