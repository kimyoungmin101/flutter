import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/home/components/product2_value.dart';
import 'package:p1_project/home/components/webview.dart';
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/setting/link_value.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:p1_project/url_list.dart';
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';

class PrintURL extends StatelessWidget {
  final int index;
  final Function(PrintURL) removeURL;

  const PrintURL(this.removeURL, {Key key, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinkValue linkvalue = Provider.of<LinkValue>(context);

    return Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: TextFormField(
          initialValue: linkvalue.getUrl(),
          decoration: InputDecoration(
            hintText: 'URL',
            border: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black)),
          ),
        ));
  }
}

class ModifyLink extends StatefulWidget {
  static String routeName = "/modifyLink";

  final int id;
  final String token;
  final String img_path;

  const ModifyLink({Key key, this.id, this.token, this.img_path})
      : super(key: key);

  static final storage = new FlutterSecureStorage();

  @override
  State createState() => _ModifyLinkState(id, token, img_path);
}

class _ModifyLinkState extends State<ModifyLink> {
  _ModifyLinkState(int id, String token, String img_path) {
    this.products_id = id;
    this.token = token;
    this.img_path = img_path;
  }

  dynamic products_id;
  String product_name;
  String product_link;
  String brand;
  String img_path;
  String _filename;
  File _image;
  List<dynamic> urls;

  String coupang_url;
  String eleven_st_url;
  String gmarket_url;
  String wemakeprice_url;
  String ssg_url;
  String tmon_url;
  String other_url;
  int count;

  void initState() {
    super.initState();
    count = 0;
    product_get(products_id, token);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _formKey = new GlobalKey<ScaffoldState>();

  FocusNode titleFocusNode;
  FocusNode textFocusNode;

  String token = "";
  String randomLink = "";

  TextEditingController BrandTextController = TextEditingController();
  TextEditingController ProductTextController = TextEditingController();
  TextEditingController URLTextController = TextEditingController();

  Future<Product2_Value> product_get(product_id, token) async {
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
        img_path = map["img_path"];
      });
    });
  }

  Future<dynamic> modifyProduct(token, product_name, brand, link_type,
      product_link, image, sales_place_urls, id) async {
    Map data = {
      "product_name": product_name,
      "brand": brand,
      "product_link": product_link,
      "sales_place_urls": sales_place_urls
    };
    String body = json.encode(data);
    return await http.put(Uri.parse("http://neuro.iptime.org:3080/product/$id"),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("!!!!!!!!!code!!!!!!!!! $statusCode");
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        products_id = map["products_id"];

        print("#########");
        print(products_id);
        print("############");
      });
    });
  }

  Future _getImage() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    String filename = image.path.split("/").last;
    print("filename               " + filename);
    File imgfile = File(image.path);
    setState(() {
      _image = imgfile;
      _filename = filename;
    });
  }

  Future<dynamic> uploadImage(token, imagePath, pid, filename) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://neuro.iptime.org:3080/product/$pid/image"));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath,
        contentType: MediaType('image', 'jpeg'), filename: filename));
    request.headers.addAll(headers);
    print("imagePath:             " + imagePath);
    print("filename  of  uploadImage:             " + filename);

    http.StreamedResponse response = await request.send();
    var response1 = await http.Response.fromStream(response);

    setState(() {
      Map<String, dynamic> map = json.decode(response1.body);
      img_path = map["img_path"];
    });

    print("!!!!!!!!!!!!!!!!!!!!!!img upload !!!");
    print(response1.body);
    print(response.reasonPhrase);
    print(response.statusCode);
    print("!!!!!!!!!!!!!!!!!!!!!!img upload !!!");
  }

  List<PrintURL> URLList = [];
  List urllist = [];

  void removeURL(index) {
    setState(() {
      URLList.remove(index);
    });
  }

  void addURL(url_list, url) {
    setState(() {
      URLList.add(PrintURL(removeURL, index: URLList.length));

      count += 1;

      List arr_L = url_list.getUrlList();
      arr_L.add(url);
      url_list.setUrlList(arr_L);
      print("#**#*#*#*#*");
      print(arr_L);
    });
  }

  @override
  Widget build(BuildContext context) {
    LinkValue linkvalue = Provider.of<LinkValue>(context);
    Url_List url_list = Provider.of<Url_List>(context);
    Value value = Provider.of<Value>(context);

    if (count == 0) {
      urllist = [];
      url_list.setUrlList(urllist);
    } else {
      urllist = url_list.getUrlList();
    }
    token = value.getToken();
    randomLink = value.getRandLink();

    print("dsfdsfdsf");
    print(urllist);
    print("dsfdsfdsf");

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("상품 등록"),
          elevation: 0.0,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/back.svg"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(fontSize: 16),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
              onPressed: () async {
                await modifyProduct(
                    token,
                    ProductTextController.text,
                    BrandTextController.text,
                    0,
                    product_link,
                    _image,
                    urllist,
                    products_id);
                if (_image != null) {
                  await uploadImage(token, _image.path, products_id, _filename);
                }

                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName,
                  (route) => false,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Product2_Value(
                      id: products_id,
                      token: token,
                      img_path: img_path,
                    ),
                  ),
                );
              },
              child: Text("수정"),
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 180,
              child: Center(
                child: _image == null
                    ? Container(
                        margin: EdgeInsets.all(5),
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: InkWell(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                'http://neuro.iptime.org:3080/$img_path',
                                fit: BoxFit.cover,
                              )),
                          onTap: _getImage,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(5),
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: InkWell(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              )),
                          onTap: _getImage,
                        )),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Text(
                    "브랜드명 ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                        focusNode: textFocusNode,
                        controller: BrandTextController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: brand,
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                        ),
                      )),
                ])),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Text(
                    "상품명 ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                        focusNode: textFocusNode,
                        controller: ProductTextController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: product_name,
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                        ),
                      )),
                ])),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Text(
                    "상품링크 ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        product_link != null ? product_link : 'Default Value',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      )),
                ])),
            Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        "구매처 URL ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        flex: 4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...URLList,
                              Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 9),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                (AplicativoB2b(
                                              url: "http://www.google.com",
                                            )),
                                          ),
                                        );
                                        addURL(url_list, linkvalue.getUrl());
                                      },
                                      child: Text("추가"),
                                      style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor,
                                      )),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        URLList.removeLast();
                                        List arr_L = url_list.getUrlList();
                                        arr_L.removeLast();
                                        url_list.setUrlList(arr_L);
                                      });
                                    },
                                    child: Text("삭제"),
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor,
                                    )),
                              ])
                            ]),
                      )
                    ])),
          ],
        ));
  }
}
