import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickle_intern_2021/models/user_model.dart';
import 'package:pickle_intern_2021/provider/image_provider.dart';
import 'package:pickle_intern_2021/provider/user_provider.dart';
import 'package:pickle_intern_2021/view/image_select_screen.dart';
import 'package:pickle_intern_2021/view/story_test.dart';
import 'package:provider/provider.dart';

class PostMakeScreen extends StatefulWidget {
  @override
  _PostMakeScreenState createState() => _PostMakeScreenState();
}

class _PostMakeScreenState extends State<PostMakeScreen> {
  CollectionReference posts = FirebaseFirestore.instance.collection('post');
  TextEditingController _textEditingController = TextEditingController();
  bool _allowedSave = true;
  int _settingAndTagIndex = 0;
  int _publicityIndex = 0;
  List<Widget> _publicity = [];
  List<dynamic> _pickedImageList = [];
  List<String> _urlList = [];
  List<String> _publicityList = ["전체공개", "팔로워", "우리끼리"];

  Widget publicityWidgetBuilder (String publicity, Icon icon) {
    // 아이콘 -> 이미지 교체 필요
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: icon,
        ),
        Text(publicity, style: TextStyle(fontSize: 16),),
      ],
    );
  }

  Widget tagBuilder (String tag, double width) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          _textEditingController.text = _textEditingController.text + " #" + tag;
        },
        child: Container(
          height: 35,
          width: width,
          child: Center(child: Text("#" + tag)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
        )
      ),
    );
  }

  _upLoadPhotos(User user) async {
    for (int i = 0; i < _pickedImageList.length; i++) {
      var storage = FirebaseStorage.instance.ref().child("image/" + user.name +"/" + "${DateTime.now().toString() + i.toString()}.png");
      await storage.putFile(_pickedImageList[i]);
      String downloadURL = await storage.getDownloadURL();
      _urlList.add(downloadURL);
    }
  }

  _addPost(List<String> images, String publicity, String description, String writer, String icon) {
    Timestamp nowTime = Timestamp.fromDate(DateTime.now());
    posts.add(
        {
          "comments" : [],
          "description" : description,
          "icon" : icon,
          "images" : images,
          "publicity" : publicity,
          "writer" : writer,
          "postDate" : nowTime,
        }
    );
  }


  @override
  void initState() {
    _publicity.add(publicityWidgetBuilder("모두", Icon(Icons.people)));
    _publicity.add(publicityWidgetBuilder("팔로워", Icon(Icons.perm_contact_calendar_outlined)));
    _publicity.add(publicityWidgetBuilder("우리끼리", Icon(Icons.person_pin_rounded)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PickImageProvider imageProvider = Provider.of<PickImageProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    _pickedImageList = imageProvider.getImageList;
    User _user = userProvider.getUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("픽 만들기", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        actions: [
          TextButton(
            onPressed: () {
              imageProvider.resetImage();
              _textEditingController.clear();
              setState(() {
                _allowedSave = true;
                _publicityIndex = 0;
              });
            },
            child: Text("Reset", style: TextStyle(color: Colors.red),),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(hintText: "픽을 설명해주세요",
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: RawMaterialButton(
                            // show image pick page
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                enableDrag: false,
                                isDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return ImageSelectScreen();
                                }
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              height: 175,
                              width: 100,
                              child: _pickedImageList.isEmpty ? 
                                Icon(Icons.add, color: Colors.grey,) : 
                                ClipRRect(
                                  child: Image.file(_pickedImageList[0], fit: BoxFit.fill,),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _settingAndTagIndex = 0;
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 50,
                          child: Center(child: Text("설정")),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _settingAndTagIndex = 1;
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 75,
                            child: Center(child: Text("추천 태그")),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              _settingAndTagIndex == 0 ?
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              // 따로 widget 으로 분리할 방법 생각
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _publicityIndex = 0;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: _publicity[0],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _publicityIndex = 1;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: _publicity[1],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _publicityIndex = 2;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: _publicity[2],
                                    ),
                                  )
                                ],
                              );
                            }
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("이 픽에 참여할 수 있는 사람", style: TextStyle(fontSize: 16),),
                            Row(
                              children: [
                                _publicity[_publicityIndex],
                                Icon(Icons.arrow_forward_ios),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("사진 저장 허용", style: TextStyle(fontSize: 16),),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: _allowedSave,
                                onChanged: (bool allow) {
                                  setState(() {
                                    _allowedSave = allow;
                                  });
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ) :
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  children: [
                    // tag list
                    tagBuilder("패션", 55),
                    tagBuilder("프사", 55),
                    tagBuilder("음식", 55),
                    tagBuilder("여행", 55),
                    tagBuilder("연예인", 65),
                    tagBuilder("셀카", 55),
                    tagBuilder("일상", 55),
                    tagBuilder("취미", 55),
                    tagBuilder("동물", 55),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.30,
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height:  MediaQuery.of(context).size.height * 0.075,
              child: RawMaterialButton(
                onPressed: () async {
                  await _upLoadPhotos(_user);
                  _addPost(_urlList, _publicityList[_publicityIndex], _textEditingController.text, _user.name, _user.profileImageUrl);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Story_test()));
                },
                fillColor: Colors.pink,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text("게시", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 26,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Story_test()));
                      },
                      icon: Icon(Icons.push_pin_outlined, color: Colors.grey,),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.camera_alt_outlined, color: Colors.grey,),
                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
