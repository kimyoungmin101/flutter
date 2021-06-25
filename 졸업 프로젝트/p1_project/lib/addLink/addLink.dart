import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/home/components/webview.dart';
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
import 'package:p1_project/home/home_screen.dart';
import 'package:p1_project/home/components/product2_value.dart';

class AddLink extends StatefulWidget {
  static String routeName = "/addLink";

  static final storage = new FlutterSecureStorage();
  @override
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FocusNode titleFocusNode;
  FocusNode textFocusNode;

  String token = "";
  String randomLink = "";
  int products_id;
  File _image;
  String _filename = "";
  List<PrintURL> URLList = [];
  List urllist = [];
  String img_path;
  int count;

  void initState() {
    super.initState();
    count = 0;
  }

  TextEditingController BrandTextController = TextEditingController();
  TextEditingController ProductTextController = TextEditingController();
  TextEditingController URLTextController = TextEditingController();

  Future<dynamic> enrollProduct(token, product_name, brand, link_type,
      product_link, sales_place_urls) async {
    Map data = {
      "product_name": product_name,
      "brand": brand,
      "link_type": link_type,
      "product_link": product_link,
      "sales_place_urls": sales_place_urls
    };
    String body = json.encode(data);
    return await http.post(Uri.parse("http://neuro.iptime.org:3080/product"),
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
        print("products_id:             $products_id");
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

    if (response.statusCode == 200) {
      print("img upload SUCCESS!!!");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(response1.body);
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    } else {
      print("img upload FAIL!!!!!!!!!!!!");
      print(response.reasonPhrase);
      print(response.statusCode);
    }
  }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    LinkValue linkvalue = Provider.of<LinkValue>(context);
    Url_List url_list = Provider.of<Url_List>(context);
    Value value = Provider.of<Value>(context);

    token = value.getToken();
    print("token:              $token");
    randomLink = value.getRandLink();
    if (count == 0) {
      urllist = [];
      url_list.setUrlList(urllist);
    } else {
      urllist = url_list.getUrlList();
    }

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
                await enrollProduct(token, ProductTextController.text,
                    BrandTextController.text, 0, randomLink, urllist);
                await uploadImage(token, _image.path, products_id, _filename);

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
                        id: products_id, token: token, img_path: img_path),
                  ),
                );
              },
              child: Text("등록"),
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
                        child: IconButton(
                          onPressed: _getImage,
                          icon: Icon(Icons.camera_alt_outlined),
                          iconSize: 30,
                          color: Colors.white,
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
                          hintText: '브랜드명',
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
                          hintText: '상품명',
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
                    "상품링크 ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                        initialValue: value.getRandLink(),
                        focusNode: textFocusNode,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '상품링크',
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
