import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatItemPage extends StatefulWidget {
  final user_value;
  final user_id;

  @override
  const ChatItemPage({required this.user_value, required this.user_id});

  _ChatItemPageState createState() => _ChatItemPageState();
}

class _ChatItemPageState extends State<ChatItemPage> {
  int currentUser = 1;
  int pairId = 2;

  final PageController _pageController = PageController(initialPage: 0);

  final _controller = TextEditingController();
  String message = '';

  ImagePicker picker = ImagePicker();

  int senderId = 1;

  final imagePicker = ImagePicker();
  late File imageFile;

  Future setImage() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
    });

    uploadSingleImage(imageFile);
  }

  _deleteMessage(dynamic docID) {
    CollectionReference refMessages = FirebaseFirestore.instance
        .collection('chats/${widget.user_id}/messages');

    refMessages.doc(docID).delete();
  }

  Future<String> uploadSingleImage(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
        widget.user_id +
        '.jpg';

    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Single Post Images')
        .child(fileName);

    UploadTask uploadTask = reference.putFile(file);
    late String url;

    await uploadTask.whenComplete(() async {
      url = await uploadTask.snapshot.ref.getDownloadURL();
    });

    uploadMessage(widget.user_id, message, widget.user_value['profile'],
        widget.user_value['name'], url, senderId);

    return url;
  }

  Future uploadMessage(String idUser, String message, String profile,
      String name, String downloadURL, senderId) async {
    CollectionReference refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    await refMessages.add({
      "idUser": idUser,
      "urlAvatar": profile,
      "username": name,
      "message": message,
      "createdAt": DateTime.now(),
      "senderId": senderId, //전송하는쪽 : 1 , 받는쪽 : 2
      'photoUrl': downloadURL,
    });
  }

  void initState() {
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
            },
          ),
        ],
        title: Text(
          "Direct Message",
        ),
        centerTitle: true,
      ),
      body:
        Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats/${widget.user_id}/messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        child: Text('No Message'),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    const Text('No data avaible right now');
                  }

                  return
                    ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        var hours = snapshot.data!.docs[index]['createdAt'].toDate().hour;
                        var minutes = snapshot.data!.docs[index]['createdAt'].toDate().minute;
                        return Slidable(
                          actionExtentRatio: 0.14,
                          actionPane: _getActionPane(index)!,

                          actions: [
                            snapshot.data!.docs[index]['senderId'] == 2 ?
                            Container(
                              child:
                              Text("${DateFormat.jm('ko-kr').format(snapshot.data!.docs[index]["createdAt"].toDate())}"),
                              color: Colors.white,
                            ):
                                Container(),
                          ],
                          secondaryActions: [
                            snapshot.data!.docs[index]['senderId'] == 1 ? Container(
                                child:
                                Text("${DateFormat.jm('ko-kr').format(snapshot.data!.docs[index]["createdAt"].toDate())}"),
                                color: Colors.white,
                              ):
                            Container(),
                          ],



                          child: Column(
                            children: [
                              index ==  snapshot.data!.docs.length - 1 ? Center(
                                child: Text(
                                "${DateFormat.yMMMd('ko-kr').format(snapshot.data!.docs[snapshot.data!.docs.length - 1]["createdAt"].toDate())}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),
                              ),) : index == 0 ? Container() : DateFormat.yMMMd('ko-kr').format(snapshot.data!.docs[index - 1]["createdAt"].toDate()) == DateFormat.yMMMd('ko-kr').format(snapshot.data!.docs[index]["createdAt"].toDate()) ? Container() :
                        Center(
                          child: Text("${DateFormat.yMMMd('ko-kr').format(snapshot.data!.docs[index-1]["createdAt"].toDate())}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                        ),
                          ),
                        ),
                              MaterialButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: snapshot.data!.docs[index]
                                                    ['photoUrl'] != 'null'
                                            ? Container(
                                                width: 230,
                                                height: 270,
                                                child: Column(
                                                  children: [
                                                    snapshot.data!.docs[index]
                                                                ['photoUrl'] !=
                                                            'null'
                                                        ? Image.network(
                                                            snapshot.data!.docs[index]
                                                                ['photoUrl'],
                                                            width: 230,
                                                            height: 220,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 200,
                                                      child: MaterialButton(
                                                        color: Colors.green,
                                                        textColor: Colors.white,
                                                        child: Text('삭제 하기'),
                                                        onPressed: () {
                                                          _deleteMessage(snapshot
                                                              .data!.docs[index].id);
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height: 30,
                                                width: 200,
                                                child: MaterialButton(
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  child: Text('삭제 하기'),
                                                  onPressed: () {
                                                    _deleteMessage(
                                                        snapshot.data!.docs[index].id);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: snapshot.data!.docs[index]
                                              ['senderId'] == currentUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: <Widget>[
                                    snapshot.data!.docs[index]['senderId'] == pairId
                                        ? Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                child: Image.network(
                                                  snapshot.data!.docs[index]
                                                      ['urlAvatar'],
                                                  fit: BoxFit.cover,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(100),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            width: 30,
                                            height: 30,
                                          ),
                                    Column(
                                      crossAxisAlignment: snapshot.data!.docs[index]
                                                  ['senderId'] == currentUser
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  MediaQuery.of(context).size.width *
                                                      .7,
                                            ),
                                            padding: snapshot.data!.docs[index]
                                                        ['photoUrl'] ==
                                                    'null'
                                                ? EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 12,
                                                  )
                                                : EdgeInsets.all(0),
                                            margin: EdgeInsets.symmetric(
                                              vertical: 6,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: snapshot.data!.docs[index]
                                                          ['senderId'] ==
                                                      currentUser
                                                  ? Colors.blue
                                                  : Colors.black26,
                                            ),
                                            child: snapshot.data!.docs[index]
                                                        ['photoUrl'] == 'null'
                                                ? Column(
                                                    children: [
                                                      Text(
                                                        "${snapshot.data!.docs[index]['message']}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Image.network(
                                                    snapshot.data!.docs[index]
                                                        ['photoUrl'],
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.fill,
                                                  )),
                                        index != 0 ? hours == snapshot.data!.docs[index - 1]['createdAt'].toDate().hour &&
                                                    minutes == snapshot.data!.docs[index - 1]['createdAt'].toDate().minute
                                                ? SizedBox()
                                                : snapshot.data!.docs[index]['createdAt'].toDate().hour >= 12
                                                    ? _Hello_time(snapshot, index)
                                                    : _Hello_time2(snapshot, index)
                                            : snapshot.data!.docs[index]['createdAt'].toDate().hour >= 12
                                                ? _Hello_time(snapshot, index)
                                                : _Hello_time2(snapshot, index),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                          ),
                        );
                      },
                    );
                },
              ),
            ),
            _build_input(context),
          ],
        ),
    );
  }

  Widget _build_input(context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: '메시지를 입력하세요',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                gapPadding: 10,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onChanged: (value) => setState(() {
              message = value;
            }),
          )),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();

              message.trim().isEmpty
                  ? null
                  : uploadMessage(
                      widget.user_id,
                      message,
                      widget.user_value['profile'],
                      widget.user_value['name'],
                      'null',
              senderId);

              updateUserData(DateTime.now(), widget.user_id);

              _controller.clear();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: IconButton(
              icon: Icon(Icons.image, color: Colors.white),
              onPressed: () {
                setImage();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: IconButton(
              icon: Icon(Icons.change_circle, color: Colors.white),
              onPressed: () {
                ChangeUser();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _Hello_time(snapshot, index) {
    // 12시 이후 이면 오후를 표현하게 만들어주는 로직
    return Padding(
      padding: snapshot.data!.docs[index]['senderId'] == currentUser
          ? EdgeInsets.only(right: 15)
          : EdgeInsets.only(left: 15),
      child: Text(
        (snapshot.data!.docs[index]['createdAt'].toDate().minute < 10)
            ? "오후 : ${snapshot.data!.docs[index]['createdAt'].toDate().hour - 12}: 0${snapshot.data!.docs[index]['createdAt'].toDate().minute}"
            : "오후 : ${snapshot.data!.docs[index]['createdAt'].toDate().hour - 12}: ${snapshot.data!.docs[index]['createdAt'].toDate().minute}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _Hello_time2(snapshot, index) {
    // 12시 이전 이면 오전을 표현하게 만들어주는 로직
    return Padding(
      padding: snapshot.data!.docs[index]['senderId'] == currentUser
          ? EdgeInsets.only(right: 15)
          : EdgeInsets.only(left: 15),
      child: Text(
        (snapshot.data!.docs[index]['createdAt'].toDate().minute < 10)
            ? "오전 : ${snapshot.data!.docs[index]['createdAt'].toDate().hour}: 0${snapshot.data!.docs[index]['createdAt'].toDate().minute}"
            : "오전 : ${snapshot.data!.docs[index]['createdAt'].toDate().hour}: ${snapshot.data!.docs[index]['createdAt'].toDate().minute}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    );
  }

  Future<void> updateUserData(DateTime time, String Id) async {
    return await FirebaseFirestore.instance.collection('user').doc(Id).update({
      'currentMessage': time,
    });
  }

  //senderId

  Future<void> ChangeUser() async {
    if(senderId == 1){
      senderId = 2;
    }
    else{
      senderId = 1;
    }
  }

  static Widget? _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }
}
