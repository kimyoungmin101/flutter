import 'package:flutter/cupertino.dart';

class Todo{
  bool isDone;
  String title;

  Todo(@required this.title, {@required this.isDone = false});
}
