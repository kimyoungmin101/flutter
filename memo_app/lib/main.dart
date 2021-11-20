import 'package:flutter/material.dart';
import 'package:memo_app/provider/memo_provider.dart';
import 'package:provider/provider.dart';
import 'package:memo_app/view/memo_view.dart';

import 'models/memo_model.dart';
Future<void> main() async{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MemoProvider>(create: (BuildContext context) => MemoProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const Memo_view();
  }
}

