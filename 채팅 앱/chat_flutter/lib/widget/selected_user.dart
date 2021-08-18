import 'package:chat_flutter/widget/selected_item_card.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Selected_User extends StatefulWidget {
  const Selected_User({Key ? key}) : super(key: key);

  @override
  _Selected_UserState createState() => _Selected_UserState();
}

class _Selected_UserState extends State<Selected_User> {
  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      // header: SliverToBoxAdapter(child: Text('HEADER')),
      // footer: SliverToBoxAdapter(child: Text('FOOTER')),
      itemBuilder: (index, context, documentSnapshot) {
        final data = documentSnapshot.data() as Map?;
        return SelectedItemCard(data: data, id : documentSnapshot.id);
      },
      query: FirebaseFirestore.instance.collection('user').orderBy('currentMessage', descending: true),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
    );
  }
}
