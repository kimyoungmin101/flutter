import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickle_intern_2021/provider/image_select_state_provider.dart';
import 'package:pickle_intern_2021/provider/user_provider.dart';
import 'package:pickle_intern_2021/view/post_make_screen.dart';
import 'package:pickle_intern_2021/view/story_test.dart';
import 'package:provider/provider.dart';
import 'package:pickle_intern_2021/provider/image_provider.dart';

import 'data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PickImageProvider>(create: (BuildContext context) => PickImageProvider()),
        ChangeNotifierProvider<UserProvider>(create: (BuildContext context) => UserProvider()),
        ChangeNotifierProvider<ImageSelectStateProvider>(create: (BuildContext context) => ImageSelectStateProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Pickle Intern',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Story_test(),
    );
  }
}
