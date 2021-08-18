import 'package:chat_flutter/widget/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCard extends StatefulWidget {
  final data;
  final id;

  const ItemCard({required this.data, required this.id});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  CollectionReference posts = FirebaseFirestore.instance.collection('user');

  _deleteDoc(dynamic docID) {
    posts.doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return ListTile(
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
        trailing: IconButton(
          onPressed: () {
            _deleteDoc(widget.id);
          },
          icon: Icon(
            Icons.delete_forever,
            color: Colors.black,
          ),
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
        subtitle: Text(widget.data['text']),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ChatItemPage(user_value: widget.data, user_id : widget.id))
    );
        }, // 다음 화면 이동    
    );
  }
}
