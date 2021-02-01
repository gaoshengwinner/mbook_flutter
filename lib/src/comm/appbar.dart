import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';

import 'consts.dart';

class AppBarView {
  static AppBar appbar(String title, bool canReturn,
  {bool canBesearch = false,
      BuildContext context,
      ValueChanged onEditingCompleteText, String serarchValue,
    bool canSave = false, Function onSave =  null
  }) {
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
          : Text(title),
      actions: [
        if (canBesearch)
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PopRoute(
                      child: InputButtomWidget(
                          onEditingCompleteText: (text) {
                            onEditingCompleteText(text);
                          },
                          hintTextValue: "Searh", initVlueValue: serarchValue)));
            },
          ),
        if (canSave)
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              onSave();
            },
          ),
      ],
    );
  }
}
