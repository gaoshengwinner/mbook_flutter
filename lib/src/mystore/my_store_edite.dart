import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/model/AdditionInfoManaWidget.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_additioninfo_mana.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_htmltext.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_webview.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_youtuber.dart';
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

  _SwitchItem _nowExpanded = _SwitchItem.none;

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
          GlobalFun.fbInputBox(context, "Store name", widget._shopInfo.shopName,
              (value) {
            setState(() {
              widget._shopInfo.shopName = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(context, "Tel", widget._shopInfo.shopTel,
              (value) {
            setState(() {
              widget._shopInfo.shopTel = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(context, "Locate", widget._shopInfo.shopAddr,
              (value) {
            setState(() {
              widget._shopInfo.shopAddr = value;
            });
          }, width: 0.9.sw),
          GlobalFun.fbInputBox(context, "Image", widget._shopInfo.shopPicUrl,
              (value) {
            setState(() {
              widget._shopInfo.shopPicUrl = value;
            });
          },
              width: 0.9.sw,
              valueWidget: Row(children: [
                Flexible(child: new MBImage(url: widget._shopInfo.shopPicUrl))
              ])),
        ]));
  }

  Widget settingButton(
      BuildContext context, List<AdditionalInfo> infos, Function onSave) {
    return new InkWell(
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AdditionInfoManaWidget(infos: infos, onSave: onSave);
            });
      },
      child: Container(
        width: 0.8.sw,
        child: Row(
          children: [
            Icon(Icons.settings, color: G.appBaseColor[0]),
            Text(
              "Setting",
              style: TextStyle(color: G.appBaseColor[0]),
            )
          ],
        ),
      ),
    );
  }

  List getCanUseList(List<AdditionalInfo> list) {
    if (list == null || list.length == 0) {
      return null;
    }
    List result = list.where((element) => element.canBeUse).toList();
    return (list == null || list.length == 0) ? null : result;
    //return new Column(children: result.map((item) => new Text("TODO")).toList());
  }

  Widget _addtionInfo(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFFEFEFF4),
            child: Column(
              children: [
                GlobalFun.canClicklistTitle(
                    Icons.view_headline,
                    _SwitchItem.texts == _nowExpanded
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Texts',
                    () => {
                          setState(() {
                            _nowExpanded = reserSWTexts(_nowExpanded);
                          })
                        }),
                if (_SwitchItem.texts == _nowExpanded)
                  Column(
                    children: [
                      getCanUseList(widget.addtionInfoMana.simpleTexts) == null
                          ? Text("")
                          : new Column(
                              children: getCanUseList(
                                      widget.addtionInfoMana.simpleTexts)
                                  .map((item) {
                              return GlobalFun.fbInputBox(
                                  context,
                                  "No.${item.no} ${item.title == null ? "" : item.title}",
                                  item.value, (value) {
                                setState(() {
                                  item.value = value == null ? "" : value;
                                });
                              }, width: 0.9.sw);
                            }).toList()),
                      settingButton(context, widget.addtionInfoMana.simpleTexts,
                          (value) {
                        setState(() {
                          widget.addtionInfoMana.simpleTexts = value;
                        });
                      }),
                    ],
                  ),
                GlobalFun.canClicklistTitle(
                    Icons.view_headline_sharp,
                    _SwitchItem.htmlTexts == _nowExpanded
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Html texts',
                    () => {
                          setState(() {
                            _nowExpanded = reserSWHtmls(_nowExpanded);
                          })
                        }),
                if (_SwitchItem.htmlTexts == _nowExpanded)
                  Column(
                    children: [
                      getCanUseList(widget.addtionInfoMana.htmlTexts) == null
                          ? Text("")
                          : new Column(
                              children: getCanUseList(
                                      widget.addtionInfoMana.htmlTexts)
                                  .map((item) {
                              return GlobalFun.fbInputBox(
                                  context,
                                  "No.${item.no} ${item.title == null ? "" : item.title}",
                                  item.value, (value) {
                                setState(() {
                                  item.value = value == null ? "" : value;
                                });
                              },
                                  valueWidget: Stack(children: [
                                    Container(
                                      width: 0.8.sw,
                                      //height: 25,
                                      child: FBHtmlTextView(
                                        src: item.value,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.edit,
                                            size: 25,
                                            color: Colors.red,
                                          )),
                                    )
                                  ]),
                                  width: 0.9.sw);
                            }).toList()),
                      settingButton(context, widget.addtionInfoMana.htmlTexts,
                          (value) {
                        setState(() {
                          widget.addtionInfoMana.htmlTexts = value;
                        });
                      }),
                    ],
                  ),
                GlobalFun.canClicklistTitle(
                    Icons.picture_in_picture_outlined,
                    _nowExpanded == _SwitchItem.picturs
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Pictures',
                    () => {
                          setState(() {
                            _nowExpanded = reserSWPicturs(_nowExpanded);
                          })
                        }),
                if (_nowExpanded == _SwitchItem.picturs)
                  Column(
                    children: [
                      getCanUseList(widget.addtionInfoMana.simpleTexts) == null
                          ? Text("")
                          : new Column(
                              children: getCanUseList(
                                      widget.addtionInfoMana.simpleTexts)
                                  .map((item) {
                              return GlobalFun.fbInputBox(
                                  context,
                                  "No.${item.no} ${item.title == null ? "" : item.title}",
                                  item.value, (value) {
                                setState(() {
                                  item.value = value == null ? "" : value;
                                });
                              },
                                  valueWidget: Row(children: [
                                    Flexible(
                                        child: item.value?.isEmpty ?? true
                                            ? Text("")
                                            : new MBImage(url: item.value))
                                  ]),
                                  width: 0.9.sw);
                            }).toList()),
                      settingButton(context, widget.addtionInfoMana.simpleTexts,
                          (value) {
                        setState(() {
                          widget.addtionInfoMana.simpleTexts = value;
                        });
                      }),
                    ],
                  ),
                GlobalFun.canClicklistTitle(
                    Icons.video_collection_outlined,
                    _nowExpanded == _SwitchItem.vides
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Videos',
                    () => {
                          setState(() {
                            _nowExpanded = reserSWVides(_nowExpanded);
                          })
                        }),
                if (_nowExpanded == _SwitchItem.vides)
                  Column(
                    children: [
                      getCanUseList(widget.addtionInfoMana.videos) == null
                          ? Text("")
                          : new Column(
                              children:
                                  getCanUseList(widget.addtionInfoMana.videos)
                                      .map((item) {
                              return GlobalFun.fbInputBox(
                                  context,
                                  "No.${item.no} ${item.title == null ? "" : item.title}",
                                  item.value, (value) {
                                setState(() {
                                  item.value = value == null ? "" : value;
                                });
                              },
                                  valueWidget: Stack(children: [
                                    Container(
                                      child:
                                          FbYoutubeWidget(item.value, 0.8.sw),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.edit,
                                            size: 25,
                                            color: Colors.red,
                                          )),
                                    )
                                  ]),
                                  width: 0.9.sw);
                            }).toList()),
                      settingButton(context, widget.addtionInfoMana.videos,
                          (value) {
                        setState(() {
                          widget.addtionInfoMana.videos = value;
                        });
                      }),
                    ],
                  ),
                GlobalFun.canClicklistTitle(
                    Icons.web_rounded,
                    _nowExpanded == _SwitchItem.vides
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Web Views',
                    () => {
                          setState(() {
                            _nowExpanded = reserSWWebViewUrl(_nowExpanded);
                          })
                        }),
                if (_nowExpanded == _SwitchItem.webViewUrl)
                  Column(
                    children: [
                      getCanUseList(widget.addtionInfoMana.videos) == null
                          ? Text("")
                          : new Column(
                              children:
                                  getCanUseList(widget.addtionInfoMana.videos)
                                      .map((item) {
                              return GlobalFun.fbInputBox(
                                  context,
                                  "No.${item.no} ${item.title == null ? "" : item.title}",
                                  item.value, (value) {
                                setState(() {
                                  item.value = value == null ? "" : value;
                                });
                              },
                                  valueWidget: Stack(children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.8.sw,
                                      child: FBWebView(
                                          initialUrl:
                                          item.value),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.edit,
                                            size: 25,
                                            color: Colors.red,
                                          )),
                                    )
                                  ]),
                                  width: 0.9.sw);
                            }).toList()),
                      settingButton(context, widget.addtionInfoMana.videos,
                          (value) {
                        setState(() {
                          widget.addtionInfoMana.videos = value;
                        });
                      }),
                    ],
                  ),
              ],
            ),
          ),
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

enum _SwitchItem { none, texts, picturs, vides, htmlTexts, webViewUrl }

_SwitchItem reserSWTexts(_SwitchItem switchItem) {
  return switchItem != _SwitchItem.texts ? _SwitchItem.texts : _SwitchItem.none;
}

_SwitchItem reserSWPicturs(_SwitchItem switchItem) {
  return switchItem != _SwitchItem.picturs
      ? _SwitchItem.picturs
      : _SwitchItem.none;
}

_SwitchItem reserSWVides(_SwitchItem switchItem) {
  return switchItem != _SwitchItem.vides ? _SwitchItem.vides : _SwitchItem.none;
}

_SwitchItem reserSWHtmls(_SwitchItem switchItem) {
  return switchItem != _SwitchItem.htmlTexts
      ? _SwitchItem.htmlTexts
      : _SwitchItem.none;
}

_SwitchItem reserSWWebViewUrl(_SwitchItem switchItem) {
  return switchItem != _SwitchItem.webViewUrl
      ? _SwitchItem.webViewUrl
      : _SwitchItem.none;
}

Future _loadHtmlFromAssets(
    WebViewController webViewController, String src) async {
  webViewController.loadUrl(Uri.dataFromString(
          "<html><body>" + src + "</body></html>",
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'))
      .toString());
}
