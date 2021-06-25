import 'package:flutter/material.dart';
import 'package:p1_project/screens/splash/components/body.dart';
import 'package:p1_project/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // You have to call it on your starting screen
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepOrange,
      ),
      body: Body(),
    );
  }
}
