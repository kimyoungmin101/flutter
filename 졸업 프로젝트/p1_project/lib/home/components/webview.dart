import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p1_project/home/components/navi.dart';
import 'package:p1_project/home/components/navi2.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants.dart';

class AplicativoB2b extends StatefulWidget {
  String url;

  AplicativoB2b({@required this.url});
  @override
  _AplicativoB2bState createState() => _AplicativoB2bState(url:url);
}
class _AplicativoB2bState extends State<AplicativoB2b> {
  String url;


  _AplicativoB2bState({this.url});


  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: const Text("Webview"),
          actions:<Widget>[
            NavigationControls_two(_controller.future),
          ]

      ),
      body: WebView(

        initialUrl: url,

        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),

      floatingActionButton: NavigationControls(_controller.future),
      // <-- added this

    );
  }
}