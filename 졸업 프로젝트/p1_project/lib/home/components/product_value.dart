import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p1_project/home/components/webview.dart';

class Product_Value extends StatefulWidget {
  static String routeName = "/product_value";

  final int id;
  final String token, img_path;

  const Product_Value({Key key, this.id, this.token, this.img_path})
      : super(key: key);

  @override
  State<Product_Value> createState() =>
      _Product_ValueState(id, token, img_path);
}

class _Product_ValueState extends State<Product_Value> {
  int id;
  String token, img_path;

  String product_name;
  String product_link;
  String brand;
  List<dynamic> urls;

  String coupang_url;
  String eleven_st_url;
  String gmarket_url;
  String wemakeprice_url;
  String ssg_url;
  String tmon_url;
  String other_url;

  _Product_ValueState(int id, String token, String img_path) {
    this.id = id;
    this.token = token;
    this.img_path = img_path;
  }

  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    product_get(id, token);
  }

  Future<Product_Value> product_get(product_id, token) async {
    final http.Response response = await http.get(
        Uri.parse('http://neuro.iptime.org:3000/product/$product_id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).then((http.Response response) {
      //      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      setState(() {
        Map<String, dynamic> map = json.decode(response.body);

        product_name = map["product_name"];
        product_link = map["product_link"];
        brand = map["brand"];
        urls = map["urls"];

        print(urls);

        for (int i = 0; i < urls.length; i++) {
          if (urls[i].contains('coupang')) {
            print('cupang');
            print(urls[i]);
            coupang_url = urls[i];
          } else if (urls[i].contains('11st')) {
            print('11st');
            print(urls[i]);
            eleven_st_url = urls[i];
          } else if (urls[i].contains('gmarket')) {
            print('gmarket');
            print(urls[i]);
            gmarket_url = urls[i];
          } else if (urls[i].contains('wemakeprice')) {
            print('wemakeprice');
            print(urls[i]);
            wemakeprice_url = urls[i];
          } else if (urls[i].contains('ssg')) {
            print('ssg');
            print(urls[i]);
            ssg_url = urls[i];
          } else if (urls[i].contains('tmon')) {
            print('tmon');
            print(urls[i]);
            tmon_url = urls[i];
          } else {
            print('다른쇼핑몰');
            print(urls[i]);
            other_url = urls[i];
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상품 보기"),
        elevation: 0.0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 20),
              child: Column(
                children: [
                  img_path.contains('http')
                      ? Image.network(img_path)
                      : Image.network('http://neuro.iptime.org:3080/$img_path'),
                ],
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      flex: 5,
                      child: Text(
                        "브랜드명 : ",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        brand != null ? brand : 'Default Value',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                ])),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      flex: 5,
                      child: Text(
                        "상 품 명  : ",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        product_name != null ? product_name : 'Default Value',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                ])),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      flex: 5,
                      child: Text(
                        "상품링크 : ",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        product_link != null ? product_link : 'Default Value',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                ])),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                coupang_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/cupang.jpeg'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: coupang_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                eleven_st_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/11st.png'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: eleven_st_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                gmarket_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/gmarket.png'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: gmarket_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                ssg_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/ssg.png'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: ssg_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                tmon_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/tmon.jpeg'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: tmon_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                wemakeprice_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/wemakeprice.png'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: wemakeprice_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                other_url != null
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/images/shopping.png'),
                          iconSize: 100,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AplicativoB2b(
                                  url: other_url,
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
