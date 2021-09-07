import 'package:flutter/material.dart';

class ImageSelectStateProvider extends ChangeNotifier {
  List<bool> _imageStateList = [];

  void initList (int count) {
    _imageStateList = [];
    for (int i = 0; i < count; i ++){
      _imageStateList.add(false);
    }
  }

  void setListFalse (int count) {
    _imageStateList = [];
    for (int i = 0; i < count; i ++){
      _imageStateList.add(false);
    }
    notifyListeners();
  }

  void setSelectState (int index, bool state) {
    _imageStateList[index] = state;
    notifyListeners();
  }

  bool getState (int index) {
    return _imageStateList[index];
  }

  List<bool> get getStateList => _imageStateList;
}