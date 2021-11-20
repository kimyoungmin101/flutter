import 'package:flutter/material.dart';
import 'package:memo_app/models/memo_model.dart';
import 'package:memo_app/provider/memo_provider.dart';
import 'package:memo_app/view/real_memo.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class Memo_view extends StatefulWidget {
  const Memo_view({Key? key}) : super(key: key);

  @override
  _Memo_viewState createState() => _Memo_viewState();
}

class _Memo_viewState extends State<Memo_view> {
  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    MemoProvider myMemo = Provider.of<MemoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Memo'),
        actions: [
          IconButton(onPressed: (){
            Memo(
              title : this.title,
              content : this.content,
              dateCreated : DateTime.now(),
            );
          }, icon: Icon(Icons.add),)
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            var date = myMemo.getMemo[index].dateCreated;
            return Container(
              margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.orange,
                ),
              ), //  POINT: BoxDecoration
              child: ListTile(
                    title: Text(myMemo.getMemo[index].title),
                    trailing: Wrap(
                        spacing: 15,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                              child: Text(myMemo.getMemo[index].content)),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                              child: Text(DateFormat.yMMMd().format(date))),
                          IconButton(onPressed: (){
                            myMemo.removeMemo(index);
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
              ),
            );
          },
          itemCount: myMemo.memos.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Real_Memo();
          },
        ),
      );
  },
        child: Icon(Icons.add),
      ),
    );
  }
}

