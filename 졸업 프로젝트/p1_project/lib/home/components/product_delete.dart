import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Product_Delete extends StatefulWidget {
  final int id;
  final String token;

  const Product_Delete({
    Key key,
    this.id,
    this.token,
  }) : super(key: key);


  @override
  _Product_DeleteState createState() => _Product_DeleteState(id, token);
}

class _Product_DeleteState extends State<Product_Delete> {
  int id;
  String token;

  _Product_DeleteState(int id, String token) {
    this.id = id;
    this.token = token;
  }

  Future<Product_Delete> deleteId(id, token) async {
    final http.Response response = await http.delete(

        Uri.parse('http://neuro.iptime.org:3080/user/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }

    else {
      throw Exception('Failed to delete album.');
    }
  }

      @override
  Widget build(BuildContext context) {
    return Container();
  }
}
