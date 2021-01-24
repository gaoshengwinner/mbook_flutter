import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'consts.dart';

class GlobalFun {
  static void showSnackBar(
      GlobalKey<ScaffoldState> _scaffoldKey, String title) {
    //_scaffoldKey.currentContext.
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: G.appBaseColor[0],
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(
            title,
            maxLines: 5,
          )
        ],
      ),
    ));
  }

  static void removeCurrentSnackBar(GlobalKey<ScaffoldState> _scaffoldKey) {
    //_scaffoldKey.currentContext.
    _scaffoldKey.currentState.removeCurrentSnackBar();
  }

  static Future<T> showBottomSheet<T>(
      BuildContext context, List<Widget> widget, Color bkgColor) {
    return showMaterialModalBottomSheet(
      //expand: false,
      context: context,
      backgroundColor: bkgColor == null ? Colors.blue.withOpacity(0) : bkgColor,
      builder: (context) => Container(
          decoration: new BoxDecoration(
            //border: new Border.all( width: 0.5), // 边色与边宽度
            color: Color(0xFFEFEFF4),
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
  static Future<T> showBottomSheetForTextPrperty<T>(
      BuildContext context, Widget widget, Color bkgColor) {
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

  static showPicker(BuildContext context, int initialItem,
      List<Widget> children, Function onSelectedItemChanged) {
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
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: Text('Confirm',
                        style: TextStyle(color: G.appBaseColor[0])),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  )
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

  static void openEditPage(
      BuildContext context,
      String hintTextValue,
      String initVlueValue,
      TextInputAction textInputAction,
      TextInputType keyboardType,
      Function onEditingCompleteText) {
    Navigator.push(
        context,
        PopRoute(
            child: InputButtomWidget(
          onEditingCompleteText: (text) {
            onEditingCompleteText(text);
          },
          hintTextValue: hintTextValue,
          initVlueValue: initVlueValue,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
        )));
  }

  static Widget getEditCont(BuildContext context, String title, String value,
      bool isImage, Function onChange) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: 10),
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Column(children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: G.appBaseColor[0]),
              ),
              Spacer(),
              ClipOval(
                child: Material(
                  color: G.appBaseColor[1], // button color
                  child: InkWell(
                    splashColor: Colors.purpleAccent, // inkwell color
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        )),
                    onTap: () {
                      GlobalFun.openEditPage(
                          context,
                          title,
                          value,
                          TextInputAction.newline,
                          TextInputType.multiline, (value) {
                        onChange(value);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 2, bottom: 5),
              child: Divider(
                color: Colors.grey,
                height: 1.0,
              )),
          if (!isImage)
            Row(children: [
              Flexible(
                  child: Text(
                value,
                maxLines: 100,
              ))
            ]),
          if (isImage) Row(children: [Flexible(child: Image.network(value))]),
        ]));
  }

  static Widget ClipOvalIcon(IconData icon, Function onTap) {
    return ClipOval(
      child: Material(
        //color: G.appBaseColor[1], // button color
        child: InkWell(
          splashColor: Colors.purpleAccent,
          // inkwell color
          child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                icon,
                //color: Colors.white,
                size: 28,
              )),
          onTap: () {
            onTap();
          },
        ),
      ),
    );
  }

  static Widget FBInputBox(
      BuildContext context, String lableText, String value, Function serValue,
      {Widget valueWidget = null, width = null}) {
    width = width == null ? 0.8.sw : width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          child: Text(
            lableText,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: G.appBaseColor[0]),
          ),
        ),
        Container(
          width: width,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: 0.8.sw,
              child: valueWidget == null ? Text(value) : valueWidget,
            ),
            onTap: () {
              GlobalFun.openEditPage(context, lableText, value,
                  TextInputAction.newline, TextInputType.multiline, (value) {
                serValue(value);
              });
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class FBCustomScrollView extends StatefulWidget {
  Widget upWidget = null;
  List<Widget> downWidget = null;
  int downFlex = 5;

  FBCustomScrollView({this.upWidget, this.downWidget, this.downFlex = 5});

  @override
  _FBCustomScrollViewState createState() => _FBCustomScrollViewState(
      upWidget: this.upWidget,
      downWidget: this.downWidget,
      downFlex: this.downFlex);
}

class _FBCustomScrollViewState extends State<FBCustomScrollView> {
  Widget upWidget = null;
  List<Widget> downWidget = null;
  int downFlex = 5;

  _FBCustomScrollViewState({this.upWidget, this.downWidget, this.downFlex = 5});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        if (upWidget != null)
          Expanded(
            flex: 1,
            child: upWidget,
          ),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: downWidget == null ? [Text("")] : downWidget,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
