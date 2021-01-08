import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'consts.dart';

class AppBarView {
  static AppBar appbar(String title, bool canReturn) {
    return new AppBar(
        leading: canReturn ? null : Container(),
        //backgroundColor: G.appBaseColor,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: G.appBaseColor,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
        title: title == null
            ? Image.asset(
          'assets/graphics/logo_heng_white.png',
          fit: BoxFit.cover,
          width: 0.4.sw,
        )
            : Text(title));
  }
}
