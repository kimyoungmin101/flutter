import 'package:chat_flutter/widget/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class SelectedItemCard extends StatefulWidget {
  final data;
  final id;

  const SelectedItemCard({required this.data, required this.id});

  @override
  State<SelectedItemCard> createState() => _SelectedItemCardState();
}

class _SelectedItemCardState extends State<SelectedItemCard> {
  CollectionReference posts = FirebaseFirestore.instance.collection('user');

  void initState() {
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats/${widget.id}/messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              child: Center(
                child: LinearProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          const Text('No data avaible right now');
        }

        return snapshot.data!.docs.length != 0
            ? ListTile(
                leading: widget.data['profile'] == null
                    ? CircleAvatar(child: Icon(Icons.person))
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Image.network(
                          widget.data['profile'],
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                trailing: Column(
                  children: [
                    Text(
                      "${DateFormat.yMMMd('ko-kr').format(snapshot.data!.docs[0]["createdAt"].toDate())}",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                    "${DateFormat.jm('ko-kr').format(snapshot.data!.docs[0]["createdAt"].toDate())}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),],
                ),
                title: widget.data == null
                    ? Text('Error in data')
                    : Text(
                        widget.data['name'],
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                subtitle: snapshot.data!.docs[0]['message'].length != 0
                    ? snapshot.data!.docs[0]['message'].length >= 3
                        ? Text(
                            "${snapshot.data!.docs[0]['message'].substring(0, 3)} ...")
                        : Text(
                            "${snapshot.data!.docs[0]['message'].substring(0, 2)} ...")
                    : null,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ChatItemPage(
                              user_value: widget.data, user_id: widget.id)));
                }, // 다음 화면 이동
              )
            : SizedBox();
      },
    );
  }


}
