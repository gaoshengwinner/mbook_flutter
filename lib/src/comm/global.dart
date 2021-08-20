import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/tools/group.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_tags_selector.dart';
import 'package:mbook_flutter/src/comm/widgets/pop_route.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'consts.dart';

///枚举类型转string
String enumToString(o) => o.toString().split('.').last;

///string转枚举类型
T enumFromString<T>(List<T> values, String? value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value);
}

class GlobalFun {
  static Widget saveFloatingActionButton(Function onSave) {
    return FloatingActionButton(
      onPressed: () async {
        onSave();

        // GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
        // Api.saveMyTagInfo(context, TagResultList(tagLst: this.tagInfos))
        //     .whenComplete(() {
        //   GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        // }).catchError((e) {
        //   GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        // });
        //
      },
      child: Icon(Icons.save),
      foregroundColor: Colors.white,
      backgroundColor: G.appBaseColor[0],
//          mini: true,
//            shape: CircleBorder()
    );
  }

  static void showSnackBar(BuildContext context, Object? e, String? title) {
    FocusScope.of(context).requestFocus(new FocusNode());
    print("showSnackBar:$e");
    //_scaffoldKey.currentContext.
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      //_scaffoldKey.currentState.showSnackBar(new SnackBar(
      //backgroundColor: G.appBaseColor[0],
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Container(
            width: 0.7.sw,
            child: Text(
              title?.toString() ?? "",
              maxLines: 5,
            ),
          )
        ],
      ),
    ));
  }

  static void removeCurrentSnackBar( BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  static Future<T?> showBottomSheet<T>(
      BuildContext context, List<Widget> widget, Color bkgColor) {
    return showMaterialModalBottomSheet(
      //expand: false,
      context: context,
      backgroundColor: bkgColor,
      builder: (context) => Container(
          decoration: new BoxDecoration(
            //border: new Border.all( width: 0.5), // 边色与边宽度
            color: backgroundGray,
            // 底色
            //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            borderRadius:
                new BorderRadius.vertical(top: Radius.elliptical(5, 5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 20.0,
                  spreadRadius: 2.0)
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget,
            ),
          )),
    );
  }

  //
  // Widget upWidget = null;
  // List<Widget> downWidget = null;
  // int downFlex = 5;
  static Future<T?> showBottomSheetForTextPrperty<T>(
      BuildContext context, Widget widget, Color? bkgColor) {
    return showMaterialModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: bkgColor == null ? Colors.blue.withOpacity(0) : bkgColor,
      builder: (context) => Container(
          child: Material(
              child: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                      // leading: Icon(Icons.clear),
                      // middle: Container(),
                      // trailing: Icon(Icons.done),
                      ),
                  child: SafeArea(
                    bottom: false,
                    child: (widget),
                  )))),
    );
  }

  static Future<T?> showBottomSheetCommon<T>(
      BuildContext context, Widget widget) {
    return showMaterialModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => Container(
          child: Material(
              child: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                      // leading: Icon(Icons.clear),
                      // middle: Container(),
                      // trailing: Icon(Icons.done),
                      ),
                  child: SafeArea(
                    bottom: false,
                    child: (widget),
                  )))),
    );
  }

  static showPicker(BuildContext context, int initialItem,
      List<Widget> children, Function onSelectedItemChanged) {
    int oldInitialItem = initialItem;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff999999),
                    width: 0.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'Revoke',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      onSelectedItemChanged(oldInitialItem);
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  // CupertinoButton(
                  //   child: Text('Confirm',
                  //       style: TextStyle(color: G.appBaseColor[0])),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 16.0,
                  //     vertical: 5.0,
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              height: 320.0,
              color: Color(0xfff7f7f7),
              child: CupertinoPicker(
                  itemExtent: 32.6,
                  children: children,
                  onSelectedItemChanged: (value) {
                    onSelectedItemChanged(value);
                  },
                  scrollController:
                      FixedExtentScrollController(initialItem: initialItem)),
            )
          ],
        );
      },
    );
  }

  static void openEditTagPage(BuildContext context, List<TagInfo>? tags,
      List<TagInfo>? selectedTags, Function? onSelected) {
    showBottomSheetCommon(
        context,
        TagsSelectWidget(
            tagInfos: tags,
            selectedTagInfos: selectedTags,
            onSelected: onSelected));
    // Navigator.push(
    //     context,
    //     PopRoute(
    //         child: TagsSelectWidget(
    //             tagInfos: tags,
    //             selectedTagInfos: selectedTags,
    //             onSelected: onSelected)));
  }

  static void openEditPage(
      {required BuildContext context,
      String? hintTextValue,
      String? initValue,
      required TextInputAction textInputAction,
      required TextInputType keyboardType,
      required Function onEditingCompleteText}) {
    Navigator.push(
        context,
        PopRoute(
            child: InputButtomWidget(
          onEditingCompleteText: (text) {
            onEditingCompleteText(text);
          },
          hintTextValue: hintTextValue,
          initVlueValue: initValue,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
        )));
  }

}

