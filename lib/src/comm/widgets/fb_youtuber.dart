import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FbYoutubeWidget extends StatefulWidget {
  String _src;
  double _width;
  double _heightbiwidth = 1;

  FbYoutubeWidget(this._src, this._width) {
    _heightbiwidth = _getHeightbiWidth(this._src);
  }

  _FbYoutubeState createState() => _FbYoutubeState();

   double _getHeightbiWidth(final String src) {
    if (src == null || src.isEmpty) return 1;
    Document document = parse(src);
    String width = "";
    String height = "";
    Node e = document.querySelector("iframe");
    e.attributes.forEach((key, value) {
      if ("width".toLowerCase() == key.toString().toLowerCase()) {
        width = value;
      }
      if ("height".toLowerCase() == key.toString().toLowerCase()) {
        height = value;
      }
    });

    e.attributes["width"] = "100%";
    e.attributes["height"] = "100%";

    _src = document.outerHtml;

    final doubleRegex = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
    try {
      final double doubleWidth = doubleRegex
          .allMatches(width)
          .map((m) => double.parse(m[0]))
          .toList()[0];
      final double doubleHeight = doubleRegex
          .allMatches(height)
          .map((m) => double.parse(m[0]))
          .toList()[0];
      if (doubleHeight == 0 || doubleWidth == 0) {
        return 1;
      } else {
        return doubleHeight / doubleWidth;
      }
    } catch (e, stack) {
      return 1;
    }
  }
}

class _FbYoutubeState extends State<FbYoutubeWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: widget._width,
      height: widget._src?.isEmpty ?? true ? 0 : widget._heightbiwidth * widget._width,
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          // _controller = webViewController;
          await _loadHtmlFromAssets(webViewController, widget._src);
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
