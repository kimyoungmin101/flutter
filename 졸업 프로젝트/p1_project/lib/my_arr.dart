import 'package:flutter/material.dart';

class My_Arr with ChangeNotifier{
  List<dynamic> _myList;

  My_Arr(this._myList);

  getMyList() => _myList;

  setMyList(List myList) => _myList = myList;

}
