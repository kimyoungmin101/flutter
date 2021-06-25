import 'package:flutter/material.dart';

class LinkValue with ChangeNotifier{
  String _url;

  getUrl() => _url;

  setUrl(String url) => _url = url;

}

