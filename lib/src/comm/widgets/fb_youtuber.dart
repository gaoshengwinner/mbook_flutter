import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:webview_flutter/webview_flutter.dart';

class FbYoutubeWidget extends StatefulWidget {
  final String src;
  final double width;

  FbYoutubeWidget(this.src, this.width);

  _FbYoutubeState createState() => _FbYoutubeState();
}

class _FbYoutubeState extends State<FbYoutubeWidget> {
  late String _src;

  @override
  Widget build(BuildContext context) {
    _src = widget.src;
    return new Container(
      width: widget.width,
      height: _src.isEmpty ? 0 : _getHeightbiWidth(_src) * widget.width,
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          // _controller = webViewController;
          await _loadHtmlFromAssets(webViewController, _src);
        },
      ),
    );
  }

  Future _loadHtmlFromAssets(
      WebViewController webViewController, String src) async {
    webViewController.loadUrl(Uri.dataFromString(
            "<html><body>" + (src) + "</body></html>",
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  double _getHeightbiWidth(final String src) {
    if (src.isEmpty) return 1;
    Document document = parse(src);
    String width = "";
    String height = "";
    Node? e = document.querySelector("iframe");
    try {
      e?.attributes.forEach((key, value) {
        if ("width".toLowerCase() == key.toString().toLowerCase()) {
          width = value;
        }
        if ("height".toLowerCase() == key.toString().toLowerCase()) {
          height = value;
        }
      });
    } catch (e) {
      return 0.2;
    }

    e?.attributes["width"] = "100%";
    e?.attributes["height"] = "100%";

    _src = document.outerHtml;

    final doubleRegex = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
    try {
      final double doubleWidth = doubleRegex
          .allMatches(width)
          .map((m) => double.parse(m[0]!))
          .toList()[0];
      final double doubleHeight = doubleRegex
          .allMatches(height)
          .map((m) => double.parse(m[0]!))
          .toList()[0];
      if (doubleHeight == 0 || doubleWidth == 0) {
        return 1;
      } else {
        return doubleHeight / doubleWidth;
      }
    } catch (e) {
      return 1;
    }
  }
}
