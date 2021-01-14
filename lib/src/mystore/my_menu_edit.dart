import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
                getEditCont("商品名", _item.itemName, false, (value) {
                  setState(() {
                    _item.itemName = value;
                  });
                }),
                getEditCont("商品価格", _item.itemPrice, false, (value) {
                  setState(() {
                    _item.itemPrice = value;
                  });
                }),
                getEditCont("商品説明", _item.itemDescr, false, (value) {
                  setState(() {
                    _item.itemDescr = value;
                  });
                }),
                getEditCont("商品代表写真", _item.itemMainPicUrl, true, (value) {
                  setState(() {
                    _item.itemMainPicUrl = value;
                  });
                }),
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


              ])

          )
      ),

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

  Widget getEditCont(
      String title, String value, bool isImage, Function onChange) {
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: G.appBaseColor[0],
                ),
                onPressed: () {
                  GlobalFun.openEditPage(context, title, value, TextInputAction.newline,
                      TextInputType.multiline, (value) {
                    onChange(value);
                  });
                },
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


}
