import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1_project/home/components/product_value.dart';
import 'package:p1_project/home/components/webview.dart';
import 'package:p1_project/models/Product.dart';

import 'package:p1_project/constants.dart';
import 'package:p1_project/value.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Value value = Provider.of<Value>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Product_Value(
              id: product.id,
              token: value.getToken(),
              img_path: product.img_path,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 180,
              width: 180,
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
                child: product.img_path.contains('http')
                    ? Image.network(
                        product.img_path,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'http://neuro.iptime.org:3080/${product.img_path}',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product.title,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\브랜드: ${product.brand}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RichText(
            text: new TextSpan(
              children: [
                new TextSpan(
                  text: '링크 이동',
                  style: new TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (AplicativoB2b(
                            url: product.url,
                          )),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text: new TextSpan(
              children: [
                new TextSpan(
                  text: '링크 복사',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async {
                      await Clipboard.setData(ClipboardData(text: product.url));
                      _showDialog(context, product.url);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showDialog(context, url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("링크 복사"),
        content: new Text(url + " \n 제품 링크가 복사 됐습니다."),
        actions: <Widget>[
          new FlatButton(
            child: new Text("닫기"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
