import 'package:flutter/material.dart';
import 'login_app/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase login App',
      home: LogIn(),
    );
  }
}
