import 'package:flutter/material.dart';
import 'package:p1_project/setting/link_value.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls_two extends StatelessWidget {
  const NavigationControls_two(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);
  final Future<WebViewController> _webViewControllerFuture;
  @override
  Widget build(BuildContext context) {
    LinkValue linkvalue = Provider.of<LinkValue>(context);

    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return IconButton(
          icon: const Icon(Icons.add_circle_outline_outlined),
          onPressed: !webViewReady
              ? null
              : () async {
            linkvalue.setUrl(await controller.currentUrl());

            Navigator.pop(context);
          },
        );
      },
    );
  }
}
