import 'package:flutter/material.dart';
import 'package:p1_project/login_screen/welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
