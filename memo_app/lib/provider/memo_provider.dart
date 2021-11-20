import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memo_app/models/memo_model.dart';

class MemoProvider extends ChangeNotifier {
  List<Memo> memos = [];
  late int index;

  void addMemo(Memo memo){
    this.memos.add(memo);
    notifyListeners();
  }

  void removeMemo(index){
    this.memos.removeAt(index);
    notifyListeners();
  }

  List<Memo> get getMemo => memos;
}

