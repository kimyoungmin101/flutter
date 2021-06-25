import 'package:flutter/material.dart';
import 'package:p1_project/constants.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double wid;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.wid,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // 앱 화면 크기 size  Ex> Size(360.0, 692.0)
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      width: size.width * wid,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
