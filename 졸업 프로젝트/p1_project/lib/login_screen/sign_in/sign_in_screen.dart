import 'package:flutter/material.dart';

import 'package:p1_project/login_screen/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  final String nickname;
  final String password;

  const SignInScreen({
    Key key,
    this.nickname,
    this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Body(email: nickname, password: password),

    );
  }
}
