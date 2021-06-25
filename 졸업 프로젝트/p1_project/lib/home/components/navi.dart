import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);
  final Future<WebViewController> _webViewControllerFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return FloatingActionButton.extended(
          onPressed: !webViewReady
              ? null
              : () => navigate(context, controller, goBack: true),
          icon: Icon(Icons.arrow_back),
          backgroundColor: Colors.black,
          label: Text("Back"),
        );
      },
    );
  }
  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
    goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      print("*********");
      print(await controller.currentUrl());
      print("*********");
      Navigator.pop(context);
    }
  }
}
