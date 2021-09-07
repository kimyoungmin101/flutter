import 'package:flutter/material.dart';
import 'package:pickle_intern_2021/models/user_model.dart';

class Product {
  final String title;
  final String id;
  final List<dynamic> imageList;
  final User user;

  const Product({
    @required this.title,
    @required this.id,
    @required this.imageList,
    @required this.user,
  });
}

