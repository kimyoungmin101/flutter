import 'package:flutter/material.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/login_screen/sign_in/sign_in_screen.dart';

class Complete extends StatelessWidget {
  static String routeName = "/complete";

  final String nickname;
  final String password;

  const Complete({
    Key key,
    this.nickname,
    this.password,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/images/logo.png'),
                  width: 300,
                  height: 250,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('환영합니다!!', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.orangeAccent), ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('회원가입이 완료 됐습니다.', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15, left: 15, top: 30),
                width: 700,
                height: 50,
                child: ElevatedButton(
                  child: Text('로그인하러 가기'),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor, // background
                      onPrimary: Colors.black, // foreground
                    ),
                  onPressed: (){
                    Navigator.pop(context);

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      SignInScreen.routeName, (route)=> false,
                    );
                                }
                ),
              ),
            ],
        ),
      ),
    );
  }
}
