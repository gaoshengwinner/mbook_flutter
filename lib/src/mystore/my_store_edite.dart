import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyStoreInfoPage extends StatefulWidget {
  final ShopInfo _shopInfo;

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

  bool _textExpand = false;
  bool _pictureExpand = false;
  bool _videoExpand = false;

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
                    _textExpand
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Texts',
                    () => {
                          setState(() {
                            _textExpand = !_textExpand;
                            _pictureExpand =
                                _textExpand ? false : _pictureExpand;
                            _videoExpand = _textExpand ? false : _videoExpand;
                          })
                        }),
                if (_textExpand)
                  Column(
                    children: [
                      GlobalFun.fbInputBox(
                          context, "No.1", widget._shopInfo.shopName, (value) {
                        setState(() {
                          widget._shopInfo.shopName = value;
                        });
                      }),
                      GlobalFun.fbInputBox(
                          context, "No.2", widget._shopInfo.shopName, (value) {
                        setState(() {
                          widget._shopInfo.shopName = value;
                        });
                      }),
                      Container(
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
                      )
                    ],
                  ),
                GlobalFun.canClicklistTitle(
                    Icons.picture_in_picture_outlined,
                    _pictureExpand
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Pictures',
                    () => {
                          setState(() {
                            _pictureExpand = !_pictureExpand;
                            _textExpand =
                                _pictureExpand ? false : _pictureExpand;
                            _videoExpand =
                                _pictureExpand ? false : _videoExpand;
                          })
                        }),
                if (_pictureExpand)
                  Column(children: [
                    GlobalFun.fbInputBox(
                        context, "No1", widget._shopInfo.shopPicUrl, (value) {
                      setState(() {
                        widget._shopInfo.shopPicUrl = value;
                      });
                    },
                        valueWidget: Row(children: [
                          Flexible(
                              child:
                                  new MBImage(url: widget._shopInfo.shopPicUrl))
                        ])),
                    Container(
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
                    )
                  ]),
                GlobalFun.canClicklistTitle(
                    Icons.video_collection_outlined,
                    _videoExpand
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    'Videos',
                    () => {
                          setState(() {
                            _videoExpand = !_videoExpand;
                            _pictureExpand =
                                _videoExpand ? false : _pictureExpand;
                            _textExpand = _videoExpand ? false : _textExpand;
                          })
                        }),
                if (true /*_videoExpand*/)
                  Column(
                    children: [
                      Container(
                        width: 500,
                        height: 200,
                        child:WebView(
                        initialUrl: 'https://flutter.dev',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          //_controller.complete(webViewController);
                        },
                        onProgress: (int progress) {
                          print("WebView is loading (progress : $progress%)");
                        },
                        javascriptChannels: <JavascriptChannel>{
                          //_toasterJavascriptChannel(context),
                        },
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url
                              .startsWith('https://www.youtube.com/')) {
                            print('blocking navigation to $request}');
                            return NavigationDecision.prevent;
                          }
                          print('allowing navigation to $request');
                          return NavigationDecision.navigate;
                        },
                        onPageStarted: (String url) {
                          print('Page started loading: $url');
                        },
                        onPageFinished: (String url) {
                          print('Page finished loading: $url');
                        },
                        gestureNavigationEnabled: true,
                      ),)

                      // GlobalFun.fbInputBox(
                      //     context, "No.1", widget._shopInfo.shopName, (value) {
                      //   setState(() {
                      //     widget._shopInfo.shopName = value;
                      //   });
                      // }),
                      // Container(
                      //   width: 0.8.sw,
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.settings, color: G.appBaseColor[0]),
                      //       Text(
                      //         "Setting",
                      //         style: TextStyle(color: G.appBaseColor[0]),
                      //       )
                      //     ],
                      //   ),
                      // ),
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
