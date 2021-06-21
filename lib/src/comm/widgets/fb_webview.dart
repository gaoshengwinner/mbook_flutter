import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FBWebView extends StatefulWidget {
  final String initialUrl;

  FBWebView({this.initialUrl});

  @override
  _FBWebViewState createState() => new _FBWebViewState();
}

class _FBWebViewState extends State<FBWebView> {
  double webViewHeight;
  String guideUrl;
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    guideUrl = widget.initialUrl;
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: webViewHeight != null ? webViewHeight : 300,
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: guideUrl,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        onPageFinished: (some) async {
          if (_webViewController != null) {
            webViewHeight = double.tryParse(
              await _webViewController
                  .evaluateJavascript("document.documentElement.scrollHeight;"),
            );
            setState(() {});
          }
        },
      ),
    );
  }
}
