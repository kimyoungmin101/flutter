import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:p1_project/components/rounded_button.dart';

import '../../constants.dart';
import '../../value.dart';

class LoadImageFromGallery extends StatefulWidget {
  @override
  _LoadImageFromGalleryState createState() => _LoadImageFromGalleryState();
}

class _LoadImageFromGalleryState extends State<LoadImageFromGallery> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode titleFocusNode;
  FocusNode textFocusNode;
  bool _image = false;

  TextEditingController titleTextController = TextEditingController();
  TextEditingController TextController = TextEditingController();

  @override
  void dispose() {
    titleTextController.dispose();
    TextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    titleFocusNode = FocusNode();
    textFocusNode = FocusNode();
  }

  List<Asset> images = <Asset>[];

  String _error = 'No Error Dectected';

  Widget buildGridView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        Asset asset = images[index];

        return Container(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: camera_option(),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    _image = true;
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });

    clearimage() {
      setState(() {
        images = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("글쓰기"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_image)
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(height: 100, child: buildGridView()),
                )
              else
                Padding(
                  padding: EdgeInsets.all(10),
                  child: camera_option(),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 2.0,
                  width: 400.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: TextFormField(
                  focusNode: titleFocusNode,
                  controller: titleTextController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '제목',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 2.0,
                  width: 400.0,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 350,
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextFormField(
                    focusNode: textFocusNode,
                    controller: TextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Center(
                child: RoundedButton(
                  text: "글쓰기",
                  wid: 0.2,
                  color: kPrimaryColor,
                  press: () {
                    print(titleTextController.text);
                    print(TextController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container camera_option() {
    return Container(
      height: 80,
      width: 80,
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.camera_alt_rounded), onPressed: loadAssets),
        ],
      ),
    );
  }
}
