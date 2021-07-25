import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';

typedef ReturnConfirmFunction = bool Function();

class AppBarView {
  static AppBar appbar(
      {String? title,
      required bool canReturn,
      ReturnConfirmFunction? whenReturnNeedConfirm,
      bool canBesearch = false,
      required BuildContext context,
      ValueChanged? onEditingCompleteText,
      String? serarchValue,
      bool canSave = false,
      Function? onSave,
      PreferredSizeWidget? bottom}) {
    return new AppBar(
      leading: canReturn
          ? IconButton(
              onPressed: () {
                if (whenReturnNeedConfirm != null &&
                    whenReturnNeedConfirm() == true) {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Do you want to save changes?'),
                          title: Center(
                              child: Text(
                            'Confirm saving',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  if (onSave != null) onSave();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Don't save")),
                          ],
                        );
                      });
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Icon(AntDesign.left))
          : Container(),
      centerTitle: true,
      title: title == null
          ? Image.asset(
              MediaQuery.platformBrightnessOf(context) == Brightness.dark
                  ? 'assets/graphics/logo_heng_white.png'
                  : 'assets/graphics/logo_heng.png',
              fit: BoxFit.cover,
              height: 50,
              //width: 0.4.sw,
            )
          : Text(title),
      actions: [
        if (canBesearch)
          IconButton(
            icon: const Icon(Feather.search),
            onPressed: () {
              Navigator.push(
                  context,
                  PopRoute(
                      child: InputButtomWidget(
                          onEditingCompleteText: (text) {
                            if (onEditingCompleteText != null)
                              onEditingCompleteText(text);
                          },
                          hintTextValue: "Search",
                          initVlueValue:
                              serarchValue == null ? "" : serarchValue)));
            },
          ),
        if (canSave)
          IconButton(
            icon: const Icon(
              Icons.save,
            ),
            onPressed: () {
              if (onSave != null) {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Do you want to save changes?'),
                        title: Center(
                            child: Text(
                          'Confirm saving',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                onSave();
                                Navigator.of(context).pop();
                              },
                              child: Text('Save')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Don't save")),
                        ],
                      );
                    });
                //

              }
            },
          ),
      ],
      bottom: bottom,
    );
  }
}
