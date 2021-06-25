import 'package:flutter/widgets.dart';
import 'package:p1_project/home/components/product2_value.dart';
import 'package:p1_project/screens/splash/splash_screen.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/login_screen/sign_in/sign_in_screen.dart';
import 'package:p1_project/setting/setting_screen.dart';
import 'package:p1_project/login_screen/welcome/welcome_screen.dart';
import 'package:p1_project/login_screen/sign_up/sign_up_screen.dart';
import 'package:p1_project/login_screen/sign_up/components/login_terms.dart';
import 'package:p1_project/login_screen/sign_up/components/complete.dart';
import 'package:p1_project/addLink/addLink.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  Setting.routeName: (context) => Setting(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  Login_terms.routeName: (context) => Login_terms(),
  Complete.routeName: (context) => Complete(),
  AddLink.routeName: (context) => AddLink(),
  Product2_Value.routeName: (context) => Product2_Value(),
};
