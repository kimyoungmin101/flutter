import 'package:flutter/material.dart';
import 'package:p1_project/constants.dart';
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["최근 게시물", "내 게시물"];
  // By default our first item will be selected
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);
    selectedIndex = value.getValueIndex();

    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  Widget buildCategory(int index) {
    Value value = Provider.of<Value>(context);
    return GestureDetector(
      onTap: () {
        setState(() async {
          if(index == 0){
            selectedIndex = index;
            value.setResultIndex(true);
            value.setValueIndex(0);

            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName, (route)=> false,
            );

          }
          else if(index == 1){
            selectedIndex = index;
            value.setResultIndex(false);
            value.setValueIndex(1);

            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName, (route)=> false,
            );
          }

        });
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
