import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FBHtmlTextView extends StatefulWidget {
  final String src;
  final double _width = 200;

  FBHtmlTextView({required this.src});

  _FbYoutubeState createState() => _FbYoutubeState();
}

class _FbYoutubeState extends State<FBHtmlTextView> {
  double webViewHeight = 10;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: widget._width,
      height: webViewHeight,
      constraints: BoxConstraints(
        minHeight: 20,
      ),
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;
          _loadHtmlFromAssets(webViewController, widget.src);
        },
        onPageFinished: (some) async {
          if (
              (widget.src.isNotEmpty)) {
            webViewHeight = double.tryParse(
              await _webViewController
                  .evaluateJavascript("document.documentElement.scrollHeight;"),
            )!;
            setState(() {});
          }
        },
      ),
    );
  }

  Future<void> _loadHtmlFromAssets(
      WebViewController webViewController, String src) {
    return webViewController.loadUrl(Uri.dataFromString(
            "<html><body style='width:100%'>" +
                (src) +
                "</body></html>",
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
