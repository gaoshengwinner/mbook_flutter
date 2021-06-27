import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/AdditionInfoManaWidget.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_additioninfo_mana.dart';
import 'package:mbook_flutter/src/mystore/my_addition_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyStoreInfoPage extends StatefulWidget {
  final ShopInfo _shopInfo;
  AdditionalMana addtionInfoMana = new AdditionalMana();

  MyStoreInfoPage(this._shopInfo);

  _MyStoreInfoPageState createState() => _MyStoreInfoPageState();
}

class _MyStoreInfoPageState extends State<MyStoreInfoPage> {
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

  SwitchItem _nowExpanded = SwitchItem.none;

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    List<TabInfo> tabInfos = [
      TabInfo(title: "Store base info", widget: _baseInfo(context)),
      TabInfo(title: "Addition info", widget: _addtionInfo(context)),
    ];
    return Scaffold(
      key: _baseInfoscaffoldKey,
      appBar: AppBarView.appbar("Store info", true, canSave: true, onSave: () {
        GlobalFun.showSnackBar(context, _baseInfoscaffoldKey, "  Saving...");
        Api.saveMyShopInfo(context, widget._shopInfo).whenComplete(() {
          GlobalFun.removeCurrentSnackBar(_baseInfoscaffoldKey);
        }).catchError((e) {
          GlobalFun.showSnackBar(context, _baseInfoscaffoldKey, e.toString());
        });
      }),
      body:
          //Scrollbar(child:SingleChildScrollView(child:
          DefaultTabController(
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
                  tabs: tabInfos.map((TabInfo tabInfo) {
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
          GlobalFun.fbInputBox(
            context,
            "Store name",
            widget._shopInfo.shopName,
            (value) {
              setState(() {
                widget._shopInfo.shopName = value;
              });
            },
          ),
          GlobalFun.fbInputBox(
            context,
            "Tel",
            widget._shopInfo.shopTel,
            (value) {
              setState(() {
                widget._shopInfo.shopTel = value;
              });
            },
          ),
          GlobalFun.fbInputBox(
            context,
            "Locate",
            widget._shopInfo.shopAddr,
            (value) {
              setState(() {
                widget._shopInfo.shopAddr = value;
              });
            },
          ),
          GlobalFun.fbInputBox(context, "Image", widget._shopInfo.shopPicUrl,
              (value) {
            setState(() {
              widget._shopInfo.shopPicUrl = value;
            });
          },
              valueWidget: Row(children: [
                Flexible(child: new MBImage(url: widget._shopInfo.shopPicUrl))
              ])),
        ]));
  }

  Widget _addtionInfo(BuildContext context) {
    return MyAdditionPage(addtionInfoMana: widget.addtionInfoMana);
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
