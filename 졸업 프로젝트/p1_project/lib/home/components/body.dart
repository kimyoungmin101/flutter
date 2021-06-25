import 'package:flutter/material.dart';
import 'package:p1_project/addLink/addLink.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/home/components/item_card2.dart';
import 'package:p1_project/models/Product.dart';
import 'package:p1_project/models/Product2.dart';
import 'package:p1_project/my_arr.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../value.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  String token = "";
  String randomLink = "";

  Future<dynamic> getRandomLink(token) async {
    return await http.get(
        Uri.parse("http://neuro.iptime.org:3080/product/randomLink"),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      //      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      Map<String, dynamic> map = json.decode(response.body);
      randomLink = map["randomLink"];
      print("!@!@!@!@!@!@!@:  " + randomLink);
    });
  }

  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Align(alignment: Alignment.topCenter, child: Categories()),
        ),
        Positioned(
          child: Container(
              margin: const EdgeInsets.only(top: 35.0, left: 10, right: 10),
              child: value.getResultIndex() ? bodywidget1() : bodywidget2()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              child: FloatingActionButton(
            child: Icon(Icons.add_circle_outline_outlined),
            backgroundColor: Colors.black26,
            onPressed: () async {
              await getRandomLink(value.getToken());
              await value.setRandLink(randomLink);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLink(),
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}

class bodywidget1 extends StatefulWidget {
  @override
  State<bodywidget1> createState() => _bodywidget1State();
}

class _bodywidget1State extends State<bodywidget1> {
  List<dynamic> map_arr;
  int next;

  Future<Body> getrecentproduct() async {
    final http.Response response = await http
        .get(Uri.parse('http://neuro.iptime.org:3080/product/recent'));

    setState(() {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        map_arr = map["products"];
        next = map["next_index"];

        // print(map["products"][0]);
      } else {
        throw Exception('Failed to search.');
      }
    });
  }

  Future<dynamic> getmorerecentproduct(next) async {
    var endpointUrl = 'http://neuro.iptime.org:3080/product/recent';
    Map<String, int> queryParams = {
      'startIn': next,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl +
        '?' +
        queryString; // result - http://neuro.iptime.org:3080/product/recent?startin=next

    return await http.get(Uri.parse(requestUrl),
        headers: {"Accept": "application/json"}).then(
      (http.Response response) {
        //      print(response.body);
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }

        setState(() {
          Map<String, dynamic> map = json.decode(response.body);

          map_arr = map["products"];
          next = map["next_index"];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);

    getrecentproduct();

    List<Product> products = [];

    if (map_arr != null) {
      for (int i = 0; i < map_arr.length; i++) {
        Product product = new Product(
            id: map_arr[i]["products_id"],
            title: map_arr[i]["product_name"],
            brand: map_arr[i]["brand"],
            img_path: map_arr[i]["img_path"],
            url: "http://ec2-54-83-112-148.compute-1.amazonaws.com:8080/${map_arr[i]["product_link"]}"
        );

        products.add(product);
      }
    }

    return Container(
      child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPaddin,
            crossAxisSpacing: kDefaultPaddin,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ItemCard(
                product: products[index],
              )),
    );
  }
}

class bodywidget2 extends StatefulWidget {
  @override
  State<bodywidget2> createState() => _bodywidget2State();
}

class _bodywidget2State extends State<bodywidget2> {
  List<dynamic> map_arr;

  Future<Body> getmyproduct(token, context) async {
    final http.Response response = await http
        .get(Uri.parse('http://neuro.iptime.org:3080/product/my'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    setState(() {
      if (response.statusCode == 200) {
        List<dynamic> map = json.decode(response.body);

        map_arr = map;
      } else {
        throw Exception('Failed to search.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);
    getmyproduct(value.getToken(), context);

    List<Product2> products2 = [];

    if (map_arr != null) {
      for (int i = 0; i < map_arr.length; i++) {
        Product2 product2 = new Product2(
            id: map_arr[i]["products_id"],
            title: map_arr[i]["product_name"],
            brand: map_arr[i]["brand"],
            img_path: map_arr[i]["img_path"],
            url: "http://ec2-54-83-112-148.compute-1.amazonaws.com:8080/${map_arr[i]["product_link"]}"
        );

        products2.add(product2);
      }
    }

    return GridView.builder(
      itemCount: products2.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kDefaultPaddin,
        crossAxisSpacing: kDefaultPaddin,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => ItemCard2(
        product: products2[index],
      ),
    );
  }
}
