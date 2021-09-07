import 'package:flutter/material.dart';
import 'package:pickle_intern_2021/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(
    name: 'kimYoungmin',
    profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
  );

  User get getUser => _user;
}