import 'package:flutter/material.dart';
import 'package:p1_project/components/rounded_button.dart';
import 'package:p1_project/login_screen/sign_in/sign_in_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:p1_project/login_screen/sign_up/components/login_terms.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isGoodId = false; //ID형식 맞는지?
  bool isClicked = false;

  bool _isGoodName = false;
  bool isNameClicked = false;

  bool checkIdValue = true; //중복 ID 확인
  bool checkNameValue = true; //중복 이름 확인

  bool hidepassword = true;
  bool hidepassword2 = true;
  bool is_Login_Result = false; // Login 조건 만족시

  dynamic _email = '';
  String _passworld = '';
  String _passworldCheck = '';
  String _name = '';

  TextEditingController controlleremail = TextEditingController();
  TextEditingController passwordId = TextEditingController();
  TextEditingController nameValue = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    controlleremail.dispose();
    passwordId.dispose();
    nameValue.dispose();
    super.dispose();
  }

  Future<dynamic> _checkId() async {
    var endpointUrl = 'http://neuro.iptime.org:3080/auth/check';
    Map<String, String> queryParams = {
      'email': controlleremail.text,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    final find = '%40';
    final replaceWith = '@';
    queryString = queryString.replaceAll(find, replaceWith);

    var requestUrl = endpointUrl +
        '?' +
        queryString; // result - http://neuro.iptime.org:3080/user/check?nickname=_email

    return await http.get(Uri.parse(requestUrl),
        headers: {"Accept": "application/json"}).then(
      (http.Response response) {
        //      print(response.body);
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }

        setState(() {
          Map<String, dynamic> map = json.decode(response.body);
          if (map['ok'] == true) {
            checkIdValue = true;
          } else {
            checkIdValue = false;
          }
        });
      },
    );
  }

  Future<dynamic> _checkName() async {
    var endpointUrl = 'http://neuro.iptime.org:3080/auth/check';
    Map<String, String> queryParams = {
      'nickname': nameValue.text,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl +
        '?' +
        queryString; // result - http://neuro.iptime.org:3080/user/check?nickname=_email

    return await http.get(Uri.parse(requestUrl),
        headers: {"Accept": "application/json"}).then(
      (http.Response response) {
        //      print(response.body);
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }

        setState(() {
          Map<String, dynamic> map = json.decode(response.body);
          if (map['ok'] == true) {
            checkNameValue = true;
          } else {
            checkNameValue = false;
          }
        });
      },
    );
  }

  Future<http.Response> postRequest(
      String id, String pass, String nameV) async {
    var url = 'http://neuro.iptime.org:3080/user';

    Map data = {'email': id, 'password': pass, 'nickname': nameV, 'role': 1};

    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");

    return response;
  }

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();

  void validdateAndSave() {
    final form = formKey.currentState;
    final form2 = formKey2.currentState;
    final form3 = formKey3.currentState;
    final form4 = formKey4.currentState;

    if (form.validate()) {
      form.save();
    }
    if (form2.validate()) {
      form2.save();
    }
    if (form3.validate()) {
      form3.save();
    }
    if (form4.validate()) {
      form4.save();
    }
    if (form.validate() == true &&
        form2.validate() == true &&
        form3.validate() == true &&
        form4.validate() == true) {
      setState(() {
        is_Login_Result = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),

              build_id(size),

              _isGoodId
                  ? isClicked
                      ? Text(
                          checkIdValue ? '사용가능한 아이디 입니다.' : '이미 사용중인 아이디 입니다.')
                      : SizedBox(height: 0)
                  : SizedBox(height: 0), // 중복체크

              SizedBox(height: size.height * 0.02),

              build_password(size), // 패스워드 창

              build_password_check(size), // 패스워드 체크 창

              build_name(size),

              _isGoodName
                  ? isNameClicked
                      ? Text(
                          checkNameValue ? '사용가능한 이름 입니다.' : '이미 사용중인 이름 입니다.')
                      : SizedBox(height: 0)
                  : SizedBox(height: 0), // 중복체크

              SizedBox(
                height: 10,
              ),

              RoundedButton(
                text: "가입하기",
                color: kPrimaryColor,
                wid: 0.8,
                press: () {
                  validdateAndSave();

                  postRequest(
                      controlleremail.text, passwordId.text, nameValue.text);

                  if (is_Login_Result == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login_terms(
                            email: controlleremail.text,
                            password: passwordId.text,
                            nickname: nameValue.text),
                      ),
                    );
                  }
                },
              ),

              Align(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('이미 가입 하셨나요 ?  '),
                  InkWell(
                    child: Text(
                      '로그인 하기',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
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

  Container build_password_check(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Form(
        key: formKey3,
        child: TextFormField(
          onSaved: (value) => _passworldCheck = value,
          validator: (value) {
            if (value.isEmpty == true) {
              return '패스워드를 입력해주세요';
            } else if (_passworld != value) {
              return '패스워드를 확인해주세요';
            }
          },
          obscureText: hidepassword2,
          cursorColor: kPrimaryColor,
          controller: passwordId,
          decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidepassword2 = !hidepassword2;
                });
              },
              color: kPrimaryColor,
              icon:
                  Icon(hidepassword2 ? Icons.visibility_off : Icons.visibility),
            ),
            hintText: '비밀번호 확인',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container build_password(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Form(
        key: formKey2,
        child: TextFormField(
          onSaved: (value) => _passworld = value,
          validator: (value) {
            if (value.isEmpty == true) {
              return '패스워드를 입력해주세요';
            } else if (value.length < 8) {
              return '8글자 이상 입력해주세요';
            } else if (!RegExp(r'^[a-z0-9!@#$%^&*()_+=-]').hasMatch(value)) {
              return '소문자, 숫자, 특수문자를 사용해주세요';
            }
          },
          obscureText: hidepassword,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
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
              icon:
                  Icon(hidepassword ? Icons.visibility_off : Icons.visibility),
            ),
            hintText: '비밀번호',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container build_id(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Form(
        key: formKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
            final regExp = RegExp(pattern);

            if (value.isEmpty == true) {
              _isGoodId = false;
              return '이메일 주소를 입력해주세요';
            } else if (value.length < 8) {
              _isGoodId = false;
              return '8글자 이상 입력해주세요';
            } else if (!regExp.hasMatch(value)) {
              _isGoodId = false;
              return '올바른 이메일 형식을 입력해주세요!';
            } else {
              _isGoodId = true;
            }
          },
          onSaved: (value) => _email = value,
          controller: controlleremail,
          // Id입력값 나옴
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.all(3),
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    //버튼을 둥글게 처리
                    borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                  color: Colors.orangeAccent,
                  child: Text(
                    '중복확인',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    validdateAndSave();
                    _checkId();
                    isClicked = true;
                  },
                ),
              ),
            ),
            hintText: '이메일 주소',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container build_name(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Form(
        key: formKey4,
        child: TextFormField(
          onSaved: (value) => _name = value,
          validator: (value) {
            if (value.isEmpty == true) {
              _isGoodName = false;
              return '사용자 이름을 입력해주세요';
            } else if (!RegExp(r'^[a-z0-9@.]').hasMatch(value)) {
              _isGoodName = false;
              return '올바른 이름 형식을 입력해주세요!';
            } else if (value.length < 4) {
              _isGoodName = false;
              return '4글자 이상으로 입력해주세요';
            } else {
              _isGoodName = true;
            }
          },
          controller: nameValue,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
              Icons.nature_sharp,
              color: kPrimaryColor,
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.all(3),
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    //버튼을 둥글게 처리
                    borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                  color: Colors.orangeAccent,
                  child: Text(
                    '중복확인',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    validdateAndSave();
                    _checkName();
                    isNameClicked = true;
                  },
                ),
              ),
            ),
            hintText: '판매자 이름',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
