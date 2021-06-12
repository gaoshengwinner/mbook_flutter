import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';

class MyMenuEditPage extends StatefulWidget {
  final ItemDetail _item;

  MyMenuEditPage(this._item);

  _MyMenuEditState createState() => _MyMenuEditState();
}

class _MyMenuEditState extends State<MyMenuEditPage> {

  // 响应空白处的焦点的Node
  final GlobalKey<ScaffoldState> _baseInfoscaffoldKey =
      new GlobalKey<ScaffoldState>();


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
    List<TabInfo> tabInfos = [
      TabInfo(title: "Item info", widget: _baseInfo(context)),
      TabInfo(title: "Addtion info", widget: _addtionInfo(context)),
    ];
    return Scaffold(
      key: _baseInfoscaffoldKey,
      appBar: AppBarView.appbar("Item info", true, canSave: true, onSave: () {
        GlobalFun.showSnackBar(_baseInfoscaffoldKey, "  Saving...");
        Api.saveMyItemInfo(context, widget._item).whenComplete(() {
          GlobalFun.removeCurrentSnackBar(_baseInfoscaffoldKey);
        }).catchError((e) {
          GlobalFun.showSnackBar(_baseInfoscaffoldKey, e.toString());
        });
      }),
      body: DefaultTabController(
        length: tabInfos.length,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: Material(
                color: Colors.white,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: G.appBaseColor[0],
                  tabs: // [Tab(text: "Hello"), Tab(text: "Hell1o")]
                      //[
                      tabInfos.map((TabInfo tabInfo) {
                    return new Tab(
                      text: tabInfo.title,
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: //[

                    tabInfos.map((TabInfo tabInfo) {
                  return Scaffold(
                    key: new GlobalKey<RefreshIndicatorState>(),
                    body: Center(child: tabInfo.widget),
                  );
                }).toList(),
                // ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _baseInfo(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Color(0xFFEFEFF4),
        child: ListView(children: [
          GlobalFun.fbInputBox(context, "商品名", widget._item.itemName, (value) {
            setState(() {
              widget._item.itemName = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(context, "商品価格", widget._item.itemPrice, (value) {
            setState(() {
              widget._item.itemPrice = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(context, "商品説明", widget._item.itemDescr, (value) {
            setState(() {
              widget._item.itemDescr = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(context, "商品代表写真", widget._item.itemMainPicUrl,
              (value) {
            setState(() {
              widget._item.itemMainPicUrl = value;
            });
          },
              width: 0.9.sw,
              valueWidget: Row(children: [
                Flexible(child: new MBImage(url: widget._item.itemMainPicUrl))
              ])),
        ]));
  }

  Widget _addtionInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Color(0xFFEFEFF4),
      child: ListView(
        children: [
          GlobalFun.fbInputTagBox(
              context, "Tags", MyGlobal.tagInfos, widget._item.tags, (value) {
            setState(() {
              widget._item.tags = value;
            });
          }),
        ],
      ),
    );
  }

  ScrollController scrollController;
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }
}

class TabInfo {
  const TabInfo({this.title, this.icon, this.widget});

  final String title;
  final IconData icon;
  final Widget widget;
}
