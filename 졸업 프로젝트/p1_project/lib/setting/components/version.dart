import 'package:flutter/material.dart';

class version extends StatelessWidget {
  Widget get_in(text1, title){
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child:
          Text(
            text1,
            style: TextStyle(fontSize: 15),),
        ),
      ],
    );



  }
  final String first =
      " 버전 정보";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버전정보'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text('착하니 버전정보', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),


              get_in(first, '버전을 쓰면 됩니다'),



              SizedBox(
                height: 20,
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
