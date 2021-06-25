import 'package:flutter/material.dart';


class IdValue with ChangeNotifier{
  String _email;
  String _nickname;

  IdValue(this._email, this._nickname);

  getEmail() => _email;
  getNickname() => _nickname;

  setEmail(String email) => _email = email;
  setNickname(String nickname) => _nickname = nickname;

}
