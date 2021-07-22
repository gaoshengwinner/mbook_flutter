import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FBHtmlTextView extends StatefulWidget {
  String src;
  double _width = 200;

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
      height: webViewHeight != null ? webViewHeight : 10,
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
          if (_webViewController != null &&
              (widget.src != null && widget.src.isNotEmpty)) {
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
                (src == null ? "" : src) +
                "</body></html>",
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
