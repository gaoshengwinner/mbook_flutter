import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/mystore/my_addition_page.dart';

class MyStoreInfoPage extends StatefulWidget {
  final ShopInfo? _shopInfo;

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


  @override
  Widget build(BuildContext context) {
    List<TabInfo> tabInfos = [
      TabInfo(title: "Store base info", widget: _baseInfo(context)),
      TabInfo(title: "Addition info", widget: _addtionInfo(context)),
    ];
    return MaterialApp(
      theme: Theme.of(context),
      home: DefaultTabController(
        length: tabInfos.length,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBarView.appbar(title:
            "Store info",
            canReturn:true,
            canSave: true,
            onSave: () {
              GlobalFun.showSnackBar(
                  context, _baseInfoscaffoldKey, null, "  Saving...");
              Api.saveMyShopInfo(context, widget._shopInfo!).whenComplete(() {
                GlobalFun.removeCurrentSnackBar(_baseInfoscaffoldKey);
              }).catchError((e) {
                GlobalFun.showSnackBar(
                    context, _baseInfoscaffoldKey, null, e.toString());
              });
            },
            context: context,
            bottom: TabBar(
              tabs: tabInfos.map((TabInfo tabInfo) {
                return Tab(
                  text: tabInfo.title,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: tabInfos.map((TabInfo tabInfo) {
              return Container(
                //padding: const EdgeInsets.all(16.0),
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
       // color: Color(0xFFEFEFF4),
        child: ListView(children: [
          GlobalFun.fbInputBox(
            context,
            "Store name",
            widget._shopInfo?.shopName,
            (value) {
              setState(() {
                widget._shopInfo?.shopName = value;
              });
            },
          ),
          GlobalFun.fbInputBox(
            context,
            "Tel",
            widget._shopInfo?.shopTel,
            (value) {
              setState(() {
                widget._shopInfo?.shopTel = value;
              });
            },
          ),
          GlobalFun.fbInputBox(
            context,
            "Locate",
            widget._shopInfo?.shopAddr,
            (value) {
              setState(() {
                widget._shopInfo?.shopAddr = value;
              });
            },
          ),
          GlobalFun.fbInputBox(context, "Image", widget._shopInfo?.shopPicUrl,
              (value) {
            setState(() {
              widget._shopInfo?.shopPicUrl = value;
            });
          },
              valueWidget: Row(children: [
                Flexible(child: new MBImage(url: widget._shopInfo?.shopPicUrl))
              ])),
        ]));
  }

  Widget _addtionInfo(BuildContext context) {
    return MyAdditionPage(addtionInfoMana: widget._shopInfo?.getMana());
  }

  late ScrollController scrollController;
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }
}

class TabInfo {
  const TabInfo({this.title, this.icon, this.widget});

  final String? title;
  final IconData? icon;
  final Widget? widget;
}
