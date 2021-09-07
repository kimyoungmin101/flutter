import 'dart:io';

import 'package:flutter/material.dart';

class PickImageProvider extends ChangeNotifier{
  List<File> _pickedImageList = [];
  File _selectImage;

  void addImage (File image) {
    _pickedImageList.add(image);
    notifyListeners();
  }

  void removeImage (File image) {
    _pickedImageList.remove(image);
    notifyListeners();
  }

  void updateImageList (List<File> images) {
    _pickedImageList = images;
    notifyListeners();
  }

  void resetImage () {
    _pickedImageList = [];
    notifyListeners();
  }

  void selectImage(File images){
    _selectImage = images;
    notifyListeners();
  }

  List<File> get getImageList => _pickedImageList;
  File get getselectImage => _selectImage;
}