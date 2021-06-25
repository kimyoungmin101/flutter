import 'package:flutter/material.dart';

class Url_List with ChangeNotifier{
  List<dynamic> _UrlList;

  Url_List(this._UrlList);

  getUrlList() => _UrlList;

  setUrlList(List UrlList) => _UrlList = UrlList;
}

