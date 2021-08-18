import 'package:flutter/material.dart';
import 'package:chat_flutter/widget/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key ? key}) : super(key: key);

  @override
  _AllUserState createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  CollectionReference posts = FirebaseFirestore.instance.collection('user');

  TextEditingController _textFieldUserId = TextEditingController();
  TextEditingController _textFieldText = TextEditingController();

  _addPost(String id, String text) {
    Timestamp nowTime = Timestamp.fromDate(DateTime.now());
    posts.add(
        {
          "name" : id,
          "text" : text,
          "postDate" : nowTime,
          "profile" : "https://image.shutterstock.com/z/stock-photo-truck-transportation-on-the-road-at-sunset-350092247.jpg",
          'currentMessage' : nowTime,
        }
    );
  }

  String userId = '';
  String valueText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(secondary: Colors.yellow),
        ),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('유저 추가'),
                    content: Container(
                      height: 100,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                userId = value;
                              });
                            },
                            controller: _textFieldUserId,
                            decoration: InputDecoration(hintText: "User 이름 입력"),
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                valueText = value;
                              });
                            },
                            controller: _textFieldText,
                            decoration: InputDecoration(hintText: "Text 입력"),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('추가'),
                        onPressed: () {
                          setState(() {
                            _addPost(userId, valueText);
                            userId = '';
                            valueText = '';
                            Navigator.pop(context);
                          });
                        },
                      ),
                      MaterialButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('취소'),
                        onPressed: () {
                          setState(() {
                            userId = '';
                            valueText = '';
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  );
                });
          },
          child: Icon(
            Icons.person_add_alt_1,
            color: Colors.green,
          ),
        ),
      ),

      backgroundColor: Colors.white,
      body: PaginateFirestore(
        // header: SliverToBoxAdapter(child: Text('HEADER')),
        // footer: SliverToBoxAdapter(child: Text('FOOTER')),
        itemBuilder: (index, context, documentSnapshot) {
          final data = documentSnapshot.data() as Map?;
          return ItemCard(data: data, id : documentSnapshot.id);
        },
        query: FirebaseFirestore.instance.collection('user').orderBy('postDate', descending: true),
        itemBuilderType: PaginateBuilderType.listView,
        isLive: true,
      ),
    );
  }
}