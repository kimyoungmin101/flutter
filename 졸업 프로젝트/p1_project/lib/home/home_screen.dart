import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/id_nickname_value.dart';
import 'package:p1_project/setting/setting_screen.dart';
import 'package:p1_project/login_screen/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:p1_project/value.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  HomeScreen({Key key, this.url}) : super(key: key);
  final String url;
  static final storage = new FlutterSecureStorage();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String userInfo = "";
  String email = "";
  String token = "";
  String uid = "";
  String nickname = "";
  String password = "";

  String products_id;
  String product_name;
  String product_link;
  String brand;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  var serverReceiverPath = "http://neuro.iptime.org:3080/user/image";

  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void distpose() {
    super.dispose();
  }

  Future<dynamic> post(email, password) async {
    return await http.post(Uri.parse("http://neuro.iptime.org:3080/auth/neuro"),
        body: <String, String>{
          "email": email,
          "password": password
        },
        headers: {
          "Accept": "application/json"
        }).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        setState(() {
          token = map["token"];
          uid = map["uid"];

          searchId(uid, token);
        });
      }
    });
  }

  Future<Body> searchId(uid, token) async {
    final http.Response response = await http
        .get(Uri.parse('http://neuro.iptime.org:3080/user/$uid'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      setState(() {
        email = map["email"];
        nickname = map["nickname"];
      });
    } else {
      throw Exception('Failed to search.');
    }
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await HomeScreen.storage.read(key: "login");

    if (userInfo != null) {
      setState(() {
        email = userInfo.split(" ")[1];
        password = userInfo.split(" ")[3];

        post(email, password);
      });
    } else {
      setState(() {
        email = "로그인을 해주세요";
      });
    }
  }

  Future<String> uploadImage(token, _imageFile) async {
    Map<String, String> headers = {'Accesstoken': 'access_token'};
    var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath));
    request.files
        .add(await http.MultipartFile.fromPath('UserImage', _imageFile));
    request.headers.addAll(headers);
    var res = await request.send();
    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);
    IdValue idvalue = Provider.of<IdValue>(context);

    value.setUid(uid);
    value.setToken(token);
    idvalue.setEmail(email);
    idvalue.setNickname(nickname);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          '이거루바',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () async {
                _scaffoldKey.currentState.openEndDrawer();
              }),
          SizedBox(width: kDefaultPaddin / 2),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(idvalue.getEmail()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _imageFile == null
                    ? AssetImage('assets/images/user.png')
                    : FileImage(File(_imageFile.path)),
                child: MaterialButton(
                  onPressed: () async {
                    _imageFile = (await _picker.getImage(
                        source: ImageSource.gallery)) as PickedFile;
                    setState(() {});
                  },
                ),
              ),

              accountName: Text(idvalue.getNickname()), // 밑으로 펼쳐지는 것
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),

            // 리스트타일 추가
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('설정'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );
              },
            ),
            // 리스트타일 추가
            ListTile(
              leading: Icon(Icons.login),
              title: Text('로그인'),
              onTap: () {
                Navigator.pushNamed(context, WelcomeScreen.routeName);
              },
            )
          ],
        ),
      ),
      body: Body(),
    );
  }
}
