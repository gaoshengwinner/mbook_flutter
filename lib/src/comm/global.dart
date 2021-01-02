import 'package:flutter/material.dart';

import 'consts.dart';

class GlobalFun {
  static void showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String title) {
    //_scaffoldKey.currentContext.
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: G.appBaseColor[0],
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(title)
        ],
      ),
    ));
  }

  static void removeCurrentSnackBar(GlobalKey<ScaffoldState> _scaffoldKey) {
    //_scaffoldKey.currentContext.
    _scaffoldKey.currentState.removeCurrentSnackBar();
  }



}
