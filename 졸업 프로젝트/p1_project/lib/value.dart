import 'package:flutter/material.dart';

class Value with ChangeNotifier {
  String _token;
  String _uid;
  String _randLink;
  bool _resultIndex;
  int _valueIndex;

  Value(this._token, this._uid, this._randLink, this._resultIndex, this._valueIndex);

  getToken() => _token;
  getUid() => _uid;
  getRandLink() => _randLink;
  getResultIndex() => _resultIndex;
  getValueIndex() => _valueIndex;

  setToken(String token) => _token = token;
  setUid(String uid) => _uid = uid;
  setRandLink(String randLink) => _randLink = randLink;
  setResultIndex(bool resultIndex) => _resultIndex = resultIndex;
  setValueIndex(int valueIndex) => _valueIndex = valueIndex;

}
