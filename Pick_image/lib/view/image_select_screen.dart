import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pickle_intern_2021/provider/image_provider.dart';
import 'package:pickle_intern_2021/provider/image_select_state_provider.dart';
import 'package:pickle_intern_2021/view/image_filter_screen.dart';
import 'package:provider/provider.dart';

//필터를 입힌채로 저장하지 말고 저장할 필터만
//provider로 기억해두었다가 게시물 올릴때 필터 입히는게 좋을듯?

class ImageSelectScreen extends StatefulWidget {
  @override
  _ImageSelectScreenState createState() => _ImageSelectScreenState();
}

class _ImageSelectScreenState extends State<ImageSelectScreen> {
  List<AssetEntity> _everyMediaList = [];
  List<AssetEntity> _currentMediaList = [];
  List<File> _photoFiles = [];
  List<String> _pathList = ["Recent"];
  var _selectedPath = "Recent";

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
    _currentMediaList = _everyMediaList;
  }

  _fetchNewMedia() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(hasAll: true);
      List<AssetEntity> media = await albums[0].getAssetListPaged(0, 30);
      setState(() {
        _everyMediaList.addAll(media);
      });
      media.forEach((AssetEntity element) {
        if (!_pathList.contains(element.relativePath.split("/")[0])) {
          _pathList.add(element.relativePath.split("/")[0]);
        }
      });
    }
  }

  _setPhotoFileList(List<AssetEntity> medias) async {
    for (int i = 0; i < medias.length; i++) {
      File file = await medias[i].file; // image file
      _photoFiles.add(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    PickImageProvider imageProvider = Provider.of<PickImageProvider>(context, listen: false);
    Provider.of<ImageSelectStateProvider>(context, listen: false).initList(_currentMediaList.length);

    if (_photoFiles.isEmpty) {
      _setPhotoFileList(_currentMediaList);
    }

    WidgetsBinding.instance.addPostFrameCallback((_){
      for (int i = 0; i < _photoFiles.length; i++ ) {
        if (imageProvider.getImageList.contains(_photoFiles[i])) {
          Provider.of<ImageSelectStateProvider>(context, listen: false).setSelectState(i, true);
        }
      }
    });

    return Stack(
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton(
                        value: _selectedPath,
                        items: _pathList.map(
                                (e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            imageProvider.resetImage();
                            _selectedPath = value.toString();
                            _currentMediaList = [];
                            _photoFiles = [];
                            if (value.toString() != "Recent") {
                              _everyMediaList.forEach((AssetEntity element) {
                                if (element.relativePath.split("/")[0] == value.toString()) {
                                  _currentMediaList.add(element);
                                }
                              });
                            } else {
                              _currentMediaList = _everyMediaList;
                            }
                            Provider.of<ImageSelectStateProvider>(context, listen: false).setListFalse(_currentMediaList.length);
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.clear),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: _currentMediaList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.5,crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder(
                      future: _currentMediaList[index].thumbDataWithSize(200, 200),
                      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Stack(
                            children: [
                              Container(
                                child: InkWell(
                                    onTap: () {
                                      if(Provider.of<ImageSelectStateProvider>(context, listen: false).getState(index) == true) {
                                        Provider.of<ImageSelectStateProvider>(context, listen: false).setSelectState(index, false);
                                        imageProvider.removeImage(_photoFiles[index]);
                                      } else {
                                        Provider.of<ImageSelectStateProvider>(context, listen: false).setSelectState(index, true);
                                        imageProvider.addImage(_photoFiles[index]);
                                      }
                                    },
                                    onLongPress: (){
                                      setState(() {
                                        if(Provider.of<ImageSelectStateProvider>(context, listen: false).getState(index) != true) {
                                          Provider.of<ImageSelectStateProvider>(context, listen: false).setSelectState(index, true);
                                          imageProvider.addImage(_photoFiles[index]);
                                        }
                                      });

                                      imageProvider.selectImage(_photoFiles[index]);
                                      Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (context) => ImageFilterScreen()
                                        )
                                      );
                                    },
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: Image.memory(snapshot.data, fit: BoxFit.fill,)
                                ),
                                height: 300,
                                width: 150,
                              ),
                              Consumer<ImageSelectStateProvider> (
                                builder: (context, provider, child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: provider.getState(index) ?
                                    Container(
                                      child: Center(
                                          child: Text(
                                            (imageProvider.getImageList.indexOf(_photoFiles[index])+1).toString(),
                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                          )
                                      ),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                    ) :
                                    Container(),
                                  );
                                }
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  }
              ),
            ),
          ],
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.30,
          bottom: MediaQuery.of(context).size.height * 0.025,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height:  MediaQuery.of(context).size.height * 0.075,
            child: RawMaterialButton(
              onPressed: () {
                if (imageProvider.getImageList.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0, top: 10),
                              child: Text("1개 이상의 사진을 선택해야 합니다.", style: TextStyle(color: Colors.black,fontSize: 19),),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                height: 50,
                                width: 350,
                                child: Center(child: Text("알겠어요!", style: TextStyle(color: Colors.white, fontSize: 20),)),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  );
                } else {
                  Navigator.pop(context);
                  // navigate to image filter page
                }
              },
              fillColor: Colors.pink,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: imageProvider.getImageList.isEmpty?
                Text("다음", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))
              : Text("다음 (${imageProvider.getImageList.length})", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
        )
      ],
    );
  }
}
