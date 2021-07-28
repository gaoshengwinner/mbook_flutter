import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';

import 'my_addition_page.dart';
import 'my_item_options.dart';

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

  @override
  Widget build(BuildContext context) {
    List<TabInfo> tabInfos = [
      TabInfo(title: "Base", widget: _baseInfo(context)),
      TabInfo(title: "Option", widget: _optionsInfo(context)),
      TabInfo(title: "Tag", widget: _tagInfo(context)),
      TabInfo(title: "Addition", widget: _addtionInfo(context)),
    ];

    return MaterialApp(
      theme: Theme.of(context),
      home: DefaultTabController(
        length: tabInfos.length,
        child: Scaffold(
          appBar: AppBarView.appbar(title:
            "Item info",
            canReturn:true,
            canSave: true,
            onSave: () {
              GlobalFun.showSnackBar(
                  context, null, "  Saving...");
              Api.saveMyItemInfo(context, widget._item).whenComplete(() {
                GlobalFun.removeCurrentSnackBar(context);
              }).catchError((e) {
                GlobalFun.showSnackBar(
                    context, null, e.toString());
              });
            },
            context: context,
            bottom: TabBar(
                tabs: tabInfos.map((TabInfo tabInfo) {
              return Tab(
                text: tabInfo.title,
              );
            }).toList()),
          ),
          body: TabBarView(
            children: tabInfos.map((TabInfo tabInfo) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: tabInfo.widget,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _baseInfo(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          GlobalFun.fbInputBox(
              context:context, lableText:"商品名", value:widget._item.itemName?.toString() ?? "", serValue:(value) {
            setState(() {
              widget._item.itemName = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(
              context:context, lableText:"商品価格", value:widget._item.itemPrice?.toString() ?? "",
              serValue:(value) {
            setState(() {
              widget._item.itemPrice = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(
              context:context, lableText:"商品説明", value:widget._item.itemDescr?.toString() ?? "",
              serValue:  (value) {
            setState(() {
              widget._item.itemDescr = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(
              context:context, lableText:"商品代表写真", value:widget._item.itemMainPicUrl?.toString() ?? "",
              serValue:(value) {
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

  Widget _optionsInfo(BuildContext context) {
    return MyItemOptionsPage();
    // return Container(
    //   padding: EdgeInsets.all(10),
    //   color: Color(0xFFEFEFF4),
    //   child: ListView(
    //     children: [
    //       GlobalFun.fbInputTagBox(
    //           context, "Tags", MyGlobal.tagInfos, widget._item.tags, (value) {
    //         setState(() {
    //           widget._item.tags = value;
    //         });
    //       }),
    //     ],
    //   ),
    // );
  }

  Widget _tagInfo(BuildContext context) {
    //return MyItemOptionsPage();
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          GlobalFun.fbInputTagBox(
              context, "Display Tags", MyGlobal.tagInfos, widget._item.displayTags, (value) {
            setState(() {
              widget._item.displayTags = value;
            });
          }),
          GlobalFun.fbInputTagBox(
              context, "Function Tags", MyGlobal.tagInfos, widget._item.functionTags, (value) {
            setState(() {
              widget._item.functionTags = value;
            });
          }),
        ],
      ),
    );
  }

  Widget _addtionInfo(BuildContext context) {
    return MyAdditionPage(addtionInfoMana: widget._item.getMana());
  }

  ScrollController scrollController = ScrollController();
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }
}

class TabInfo {
  const TabInfo({required this.title, this.icon, required this.widget});

  final String title;
  final IconData? icon;
  final Widget widget;
}
