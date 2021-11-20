import 'package:flutter/material.dart';
import 'package:memo_app/models/memo_model.dart';
import 'package:memo_app/provider/memo_provider.dart';
import 'package:provider/provider.dart';

class Real_Memo extends StatefulWidget {
  const Real_Memo({Key? key}) : super(key: key);

  @override
  _Real_MemoState createState() => _Real_MemoState();
}

class _Real_MemoState extends State<Real_Memo> {
  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    MemoProvider myMemo = Provider.of<MemoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Memo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              myMemo.addMemo(
                Memo(
                  title: this.title,
                  content: this.content,
                  dateCreated: DateTime.now(),
                ),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              onChanged: (value){
                title = value;
              },
              decoration: InputDecoration(
                hintText: '제목',
                enabledBorder: OutlineInputBorder(
                  borderSide : BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent)
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: null,
              onChanged: (value) {
                content = value;
              },
              decoration: InputDecoration(
                hintText: '내용',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.black),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
