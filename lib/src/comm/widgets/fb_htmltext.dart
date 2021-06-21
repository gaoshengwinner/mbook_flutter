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
  double _heightbiwidth = 1;

  FBHtmlTextView({this.src});

  _FbYoutubeState createState() => _FbYoutubeState();

}

class _FbYoutubeState extends State<FBHtmlTextView> {
  double webViewHeight = 10;
  WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: widget._width,
      height: webViewHeight != null ? webViewHeight : 10,
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;
          await _loadHtmlFromAssets(webViewController, widget.src);
        },
        onPageFinished: (some) async {
          if (_webViewController != null) {
            webViewHeight = double.tryParse(
              await _webViewController
                  .evaluateJavascript("document.documentElement.scrollHeight;"),
            );
            setState(() {
            });
          }
        },
      ),
    );
  }

  Future _loadHtmlFromAssets(
      WebViewController webViewController, String src) async {
    webViewController.loadUrl(Uri.dataFromString(
        "<html><body>" + src + "</body></html>",
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
