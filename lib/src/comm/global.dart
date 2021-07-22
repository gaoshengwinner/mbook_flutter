import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/tools/group.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_tags_selector.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'consts.dart';

///枚举类型转string
String enumToString(o) => o.toString().split('.').last;

///string转枚举类型
T enumFromString<T>(List<T> values, String value) {
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

  static void showSnackBar(BuildContext context,
      GlobalKey<ScaffoldState> _scaffoldKey, Object? e, String? title) {
    FocusScope.of(context).requestFocus(new FocusNode());
    print("showSnackBar:$e");
    //_scaffoldKey.currentContext.
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
        .showSnackBar(new SnackBar(
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

  static void removeCurrentSnackBar(GlobalKey<ScaffoldState> _scaffoldKey) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).removeCurrentSnackBar();
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
  //
  // static ListHelper _listMin = ListHelper(0, 1024);

  // static showWHPicker(BuildContext context, double initValue,
  //     List<String> utils, String selectedUtil, Function onSelectedItemChanged) {
  //   int initialItem = _listMin.getIndexByValue(initValue.toInt());
  //   int oldInitialItem = initialItem;
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: <Widget>[
  //           Container(
  //             decoration: BoxDecoration(
  //               color: Color(0xffffffff),
  //               border: Border(
  //                 bottom: BorderSide(
  //                   color: Color(0xff999999),
  //                   width: 0.0,
  //                 ),
  //               ),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 CupertinoButton(
  //                   child: Text(
  //                     'Revoke',
  //                     style: TextStyle(color: Colors.grey),
  //                   ),
  //                   onPressed: () {
  //                     onSelectedItemChanged(oldInitialItem);
  //                     Navigator.pop(context);
  //                   },
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 16.0,
  //                     vertical: 5.0,
  //                   ),
  //                 ),
  //                 // CupertinoButton(
  //                 //   child: Text('Confirm',
  //                 //       style: TextStyle(color: G.appBaseColor[0])),
  //                 //   onPressed: () {
  //                 //     Navigator.pop(context);
  //                 //   },
  //                 //   padding: const EdgeInsets.symmetric(
  //                 //     horizontal: 16.0,
  //                 //     vertical: 5.0,
  //                 //   ),
  //                 // )
  //               ],
  //             ),
  //           ),
  //           Container(
  //               alignment: Alignment(0.0, 0.0),
  //               width: 1.sw,
  //               color: Color(0xfff7f7f7),
  //               child: CupertinoRadioChoice(
  //                   initialKeyValue: "",
  //                   selectedColor: G.appBaseColor[0],
  //                   choices: {
  //                     "px": 'Pixel',
  //                     "sw": 'Screen Width',
  //                     "sh": 'Screen Height'
  //                   },
  //                   onChange: (selectedGender) {
  //                     // setState(() {
  //                     //   selected = selectedGender;
  //                     // });
  //                     // print(selected);
  //                   })),
  //           Container(
  //             height: 320.0,
  //             color: Color(0xfff7f7f7),
  //             child: CupertinoPicker(
  //                 itemExtent: 32.6,
  //                 children: _listMin.list(),
  //                 onSelectedItemChanged: (value) {
  //                   onSelectedItemChanged(
  //                       _listMin.values()[value.toInt()].toDouble());
  //                 },
  //                 scrollController:
  //                     FixedExtentScrollController(initialItem: initialItem)),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

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

  static void openEditPage({
      required BuildContext context,
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
                          context:context,
                          hintTextValue:title,
                          initValue:value,
                          textInputAction:TextInputAction.newline,
                          keyboardType:TextInputType.multiline,onEditingCompleteText: (value) {
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

  static Widget clipOvalIconTitle(IconData icon, String title, Function onTap) {
    return
        // FittedBox(
        // fit: BoxFit.fill,
        // alignment: Alignment.topLeft,
        //
        // child:
        Row(
      children: [
        ClipOval(
            child: Material(
          //color: G.appBaseColor[1], // button color
          child: InkWell(
            splashColor: Colors.purpleAccent,
            // inkwell color
            child: SizedBox(
                width: 25,
                height: 25,
                child: Icon(
                  icon,
                  color: G.appBaseColor[0],
                  size: 25,
                )),
            onTap: () {
              onTap();
            },
          ),
        )),
        Text(title)
      ],
    );
    //     ,
    // );
  }

  static Widget clipOvalIcon(IconData icon, Function onTap) {
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
    ));
  }

  static Widget fbInputTagBox(BuildContext context, String lableText,
      List<TagInfo>? tags, List<TagInfo>? selectedTags, Function onSelected,
      {width}) {
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
          constraints: BoxConstraints(
            minHeight: 30,
          ),
          child: GestureDetector(
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: 0.8.sw,
                child: Wrap(
                  spacing: 4,
                  children: [
                    if (selectedTags != null)
                      for (TagInfo tag in selectedTags)
                        WidgetTextPage(
                          property: tag.property,
                          data: tag.data,
                        )
                  ],
                )),
            onTap: () {
              GlobalFun.openEditTagPage(
                  context, tags, selectedTags, onSelected);
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  static Widget commonTitle(BuildContext context, String lableText,
      {Widget? rightWidget}) {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(lableText, style: Theme.of(context).textTheme.subtitle1), //
              rightWidget != null?  rightWidget : Text("")

    ]));
  }

  static Widget customListTitle(
      IconData icon, String title, GestureTapCallback? doTop) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: InkWell(
            splashColor: G.appBaseColor[1],
            onTap: doTop,
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title,maxLines: 2,
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  static Widget canClicklistTitle(IconData leadingIcon, IconData trailingIcon,
      String title, GestureTapCallback? doTop,
      {weidget}) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: InkWell(
            splashColor: G.appBaseColor[1],
            onTap: doTop,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(leadingIcon),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title))
                      ],
                    ),
                    Row(
                      children: [
                        // Icon(AntDesign.plussquareo , color:G.appBaseColor[0],),
                        Icon(trailingIcon),
                      ],
                    )
                  ],
                )),
          ),
        ));
  }

  static Widget fbInputBox(BuildContext context, String? lableText,
      String? value, Function? serValue,
      {Widget? valueWidget, double? width, Axis? axis, String? hintTextValue}) {
    width = width == null ? double.maxFinite : width;
    return Container(
        //padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Flex(
      direction: axis == null ? Axis.vertical : axis,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lableText != null) commonTitle(context, lableText),
        Container(
          constraints: BoxConstraints(
            minHeight: 20,
          ),
          //width: width,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              width: width,
              child: Stack(children: [
                Container(
                    child: valueWidget == null
                        ? value == null || value == ""
                            ? Text(
                                (hintTextValue == null || hintTextValue.isEmpty
                                    ? ""
                                    : hintTextValue),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: Colors.black54))
                            : Text(value,
                                style: Theme.of(context).textTheme.bodyText2)
                        //)
                        : valueWidget),
                if (valueWidget != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.red,
                        )),
                  )
              ]),
            ),
            onTap: () {
              GlobalFun.openEditPage(
                  context:context,
                  hintTextValue:lableText == null ? hintTextValue : lableText,
                  initValue:value,
                  textInputAction:TextInputAction.newline,
                  keyboardType:TextInputType.multiline,onEditingCompleteText: (value) {
                if (serValue != null) serValue(value);
              });
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ));
  }

  static Widget setingRow(IconData icon, String text) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [

        Icon(
          icon,
          size: 18,
          color: G.appBaseColor[0],
        ),

        Text(
          text,
          style: TextStyle(fontSize: 14, color: G.appBaseColor[0]),
        )
    ]);
  }
}

class FBCustomScrollView extends StatefulWidget {
  final Widget? upWidget;
  final List<Widget>? downWidget;
  final int downFlex;

  FBCustomScrollView({this.upWidget, this.downWidget, this.downFlex = 5});

  @override
  _FBCustomScrollViewState createState() => _FBCustomScrollViewState(
      upWidget: this.upWidget,
      downWidget: this.downWidget,
      downFlex: this.downFlex);
}

class _FBCustomScrollViewState extends State<FBCustomScrollView> {
  Widget? upWidget;
  List<Widget>? downWidget;
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
            child: upWidget!,
          ),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: downWidget == null ? [Text("")] : downWidget!,
              ),
            ),
          ),
        )
      ],
    ));
  }
}

//过度路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
