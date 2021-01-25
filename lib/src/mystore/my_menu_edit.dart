import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyMenuEditPage extends StatefulWidget {
  ItemDetail _item;

  MyMenuEditPage(this._item);

  _MyMenuEditState createState() => _MyMenuEditState(this._item);
}

class _MyMenuEditState extends State<MyMenuEditPage> {
  ItemDetail _item;

  _MyMenuEditState(this._item);

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  Color borderColor = Color(0xFFBCBBC1);
  Color borderLightColor = Color.fromRGBO(49, 44, 51, 1);
  Color backgroundGray = Color(0xFFEFEFF4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarView.appbar("Item info", true),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 点击空白页面关闭键盘
              FocusScope.of(context).requestFocus(_blankNode);
            },
            child: Container(
                color: Color(0xFFEFEFF4),
                child: ListView(children: [
                  GlobalFun.FBInputBox(context, "商品名", _item.itemName, (value) {
                    setState(() {
                      _item.itemName = value;
                    });
                  }, width: 0.9.sw),
                  GlobalFun.FBInputBox(context, "商品価格", _item.itemPrice,
                      (value) {
                    setState(() {
                      _item.itemPrice = value;
                    });
                  }, width: 0.9.sw),
                  GlobalFun.FBInputBox(context, "商品説明", _item.itemDescr,
                      (value) {
                    setState(() {
                      _item.itemDescr = value;
                    });
                  }, width: 0.9.sw),
                  GlobalFun.FBInputBox(context, "商品代表写真", _item.itemMainPicUrl,
                      (value) {
                    setState(() {
                      _item.itemMainPicUrl = value;
                    });
                  },
                      width: 0.9.sw,
                      valueWidget: Row(children: [
                        Flexible(child: Image.network(_item.itemMainPicUrl))
                      ])),

                  // Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 16.0),
                  //     child:
                  //         FBButton.build(context, 0.6.sw, "Save", Icons.save, () {
                  //       GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
                  //       Api.saveMyItemInfo(context, this._item).whenComplete(() {
                  //         GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                  //       }).catchError((e) {
                  //         GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                  //       });
                  //     })),
                ]))),
        floatingActionButton: buildSpeedDial()
        // FloatingActionButton.extended(
        //   backgroundColor: G.appBaseColor[0],
        //   onPressed: () {
        //     GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
        //     Api.saveMyItemInfo(context, this._item).whenComplete(() {
        //       GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        //     }).catchError((e) {
        //       GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        //     });
        //   },
        //   icon: Icon(
        //     Icons.save,
        //   ),
        //   label: Text("Save"),
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(16.0))),
        //
        // )

        );
  }

  ScrollController scrollController;
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      backgroundColor: G.appBaseColor[0],
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.save, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () {
            GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
            Api.saveMyItemInfo(context, this._item).whenComplete(() {
              GlobalFun.removeCurrentSnackBar(_scaffoldKey);
            }).catchError((e) {
              GlobalFun.showSnackBar(_scaffoldKey, e.toString());
            });
          },
          //label: 'Save ',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.delete, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () {
            Api.deleteMyShopItem(context, this._item).whenComplete(() {
              GlobalFun.removeCurrentSnackBar(_scaffoldKey);
              Navigator.pop(context);
            }).catchError((e) {
              GlobalFun.showSnackBar(_scaffoldKey, e.toString());
            });
          },
          //label: 'Delete',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
      ],
    );
  }
}
