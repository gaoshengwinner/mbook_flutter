import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemOptionList.dart';
import 'package:mbook_flutter/src/comm/model/OptionGroupInfo.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:mbook_flutter/src/comm/model/OptionTempResultList.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:mbook_flutter/src/comm/tools/widget_option.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_implicitly_animated_reorderable_list.dart';
import 'package:collection/collection.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_number_picker.dart';

typedef EditeOptionTempSaveFunction = void Function(OptionTemp);

Function deepEq = const DeepCollectionEquality().equals;

class MyOptionsPage extends StatefulWidget {
  final List<OptionTemp>? optionTemps;

  MyOptionsPage(this.optionTemps);

  _MyOptionsPageState createState() => _MyOptionsPageState();
}

class _MyOptionsPageState extends State<MyOptionsPage> {
  List<OptionTemp> _optionTemps = [];

  late ScrollController scrollController;
  bool inReorder = true;

  int copiedIndex = -1;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<OptionTemp> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;
      _optionTemps
        ..clear()
        ..addAll(newItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    _optionTemps = widget.optionTemps == null ? [] : widget.optionTemps!;
    return Scaffold(
      appBar: AppBarView.appbar(
          title: "Option temps",
          canReturn: true,
          context: context,
          canSave: true),
      key: GlobalKey<ScaffoldState>(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child:
    FBReorderableList<OptionTemp>(
          items: _optionTemps,
          body: (OptionTemp item, int i) {
            return Container(
              //width: 0.95.sw,
              child: ListTile(
                  onTap: () {
                    openEditePage(optionTemps: _optionTemps, index: i);
                  },
                  leading: Icon(Ionicons.ios_options_outline,
                      color: Theme.of(context).iconTheme.color),
                  title: Text(item.desc),
                  trailing: Icon(
                    CupertinoIcons.forward,
                    color: Theme.of(context).primaryColor,
                  )),
            );
          },
          actions: [
            ActionsParam(
                kind: ActionsKind.delete,
                actFuction: (int index) {
                  setState(() {
                    _optionTemps.removeAt(index);
                  });
                })
          ],
          needHandle: true,
          footerParam: FooterParam()
            ..title = Text("Add a option temp",
                style: TextStyle(color: Theme.of(context).primaryColor))
            ..icon = Icon(Icons.add, color: Theme.of(context).primaryColor)
            ..onTap = () {
              //final OptionTemp newOptionTem = OptionTemp();
              //_optionTemps.add(newOptionTem);
              openEditePage();
            },
        ),

        // child: new FBListViewWidget<OptionTemp>(
        //   optionTemps!,
        //   setActions: (c, r, index) {
        //     return [
        //       FBListViewWidget.getSlideActionDelete(c, () {
        //         setState(() {
        //           optionTemps!.remove(r);
        //         });
        //       })
        //     ];
        //   },
        //   canBeMove: true,
        //   setSubWidget: (c, r, index) {
        //     return Container(
        //       padding: EdgeInsets.only(top: 10, bottom: 10),
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             GlobalFun.fbInputBox(context, "Description",
        //                 (optionTemps![index].desc?.toString() ?? ""),
        //                 (value) {
        //               setState(() {
        //                 optionTemps![index].desc = value;
        //               });
        //             }),
        //             GlobalFun.commonTitle(context, "Temp",
        //                 rightWidget: IconButton(
        //                   icon: const Icon(
        //                     Icons.settings,
        //                   ),
        //                   onPressed: () {
        //                     showSetting(index);
        //                   },
        //                 )),
        //             Container(
        //               padding: EdgeInsets.only(top: 10, bottom: 10),
        //               color: Colors.transparent,
        //               //width: 1.sw,
        //               //height: 100 ,
        //               child: WidgetOptionPage.build(context,
        //                   optionTemps![index].property!, _itemOptionList,
        //                   rowMaxcount: _currentSliderValue),
        //             ),
        //           ]),
        //     );
        //   },
        //   footer: FBListViewWidget.buildFooter(context,
        //       icon: Icons.add, title: "Add a Option template", onTap: () {
        //     setState(() {
        //       optionTemps!.add(OptionTemp(desc: ""));
        //     });
        //   }),
        //   setSeActions: (c, r, index) {
        //     return [
        //       FBListViewWidget.getSlideActionCopy(c, () {
        //         setState(() {
        //           copiedIndex = index;
        //         });
        //       }),
        //       if (copiedIndex >= 0 && copiedIndex != index)
        //         FBListViewWidget.getSlideActionBrush(c, () {
        //           setState(() {
        //             if (copiedIndex >= 0)
        //               optionTemps![index].property =
        //                   optionTemps![copiedIndex].property!.copy();
        //           });
        //         })
        //     ];
        //   },
        // ),
        //),
      ),
      floatingActionButton: GlobalFun.saveFloatingActionButton(() {
        GlobalFun.showSnackBar(context, null, "  Saving...");
        Api.saveMyOptionTempnfo(
                context, OptionTempResultList(optionTempLst: this._optionTemps))
            .whenComplete(() {
          GlobalFun.removeCurrentSnackBar(context);
        }).catchError((e) {
          GlobalFun.showSnackBar(context, null, e.toString());
        });
      }),
    );
  }

  void openEditePage(
      {OptionTemp? optionTemp,
      EditeOptionTempSaveFunction? onSave,
      List<OptionTemp>? optionTemps,
      int? index}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OptionTempEditPage(
                optionTemp: optionTemp,
                optionTemps: optionTemps,
                index: index)));
  }
}

class OptionTempEditPage extends StatefulWidget {
  final OptionTemp? optionTemp;
  final List<OptionTemp>? optionTemps;
  final int? index;

  OptionTempEditPage({this.optionTemp, this.optionTemps, this.index}) {
    assert((optionTemps == null && index == null) ||
        (optionTemps != null && index != null));
    assert(optionTemp == null || optionTemps == null);
  }

  @override
  _OptionTempEditPageState createState() => _OptionTempEditPageState();
}

class _OptionTempEditPageState extends State<OptionTempEditPage>
    with SingleTickerProviderStateMixin {
  OptionTemp _optionTemp = OptionTemp();
  List<OptionTemp> _optionTemps = [];

  //OptionWidgetProperty _optionWidgetProperty = OptionWidgetProperty.init();
  ItemOptionList _itemOptionList = ItemOptionList.forTemp();

  late TabController _tabController;

  void initState() {
    super.initState();
    initList();
    _tabController = new TabController(
        initialIndex: G.ifNull(widget.index, 0),
        vsync: this,
        length: _optionTemps.length);
    //_tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initList() {
    _optionTemps = [];
    if (widget.optionTemp != null) {
      _optionTemp = widget.optionTemp!;
      _optionTemps.add(_optionTemp);
    } else if (widget.index != null) {
      _optionTemp = widget.optionTemps![widget.index!];
      _optionTemps.addAll(widget.optionTemps!);
    } else {
      _optionTemps.add(_optionTemp);
    }
  }

  @override
  Widget build(BuildContext context) {
    initList();
    return
        // DefaultTabController(
        //   initialIndex: G.ifNull(widget.index, 0),
        //   length: _optionTemps.length,
        //   child:
        Scaffold(
      appBar: AppBarView.appbar(
          title: "Edit option template",
          canReturn: true,
          context: context,
          canSave: true,
          onSave: () {}),
      key: GlobalKey<ScaffoldState>(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IconButton(
        tooltip: "Setting",
        icon: const Icon(
          Ionicons.md_settings_outline,
        ),
        onPressed: () {
          showSetting(_optionTemps[_tabController.index]);
        },
      ),
      body:
          //SingleChildScrollView(child:
          TabBarView(
        controller: this._tabController,
        children: [
          for (var i = 0; i < _optionTemps.length; i++)
            ListView(children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // 点击空白页面关闭键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalFun.fbInputBox(context:context, lableText:"Description",
                              value:(_optionTemps[i].desc.toString()),
                              serValue:(value) {
                            setState(() {
                              _optionTemps[i].desc = value;
                            });
                          }),
                          Divider(),
                          FBNumberPicker(
                            title: "Default rows/line",
                            initialValue: _optionTemps[i].defaultLineCount,
                            maxValue: 10,
                            minValue: 1,
                            step: 1,
                            onValue: (value) {
                              setState(() {
                                _optionTemps[i].defaultLineCount =
                                    value ?? _optionTemps[i].defaultLineCount;
                              });
                            },
                          ),
                          Divider(),
                          GlobalFun.commonTitle(
                            context,
                            "Look like",
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              color: Colors.transparent,
                              //width: 1.sw,
                              //height: 100 ,
                              child: WidgetOptionWidget(
                                  optionGroupInfo: OptionGroupInfo.temp(),
                                  optionTemp: _optionTemps[i])

                              // WidgetOptionWidget.build(context,
                              //     _optionTemps[i].property!, _itemOptionList,
                              //     rowMaxcount: _optionTemps[i].defaultLineCount),
                              //
                              ),
                        ]),
                  ))
            ])
        ],
      ),
      //) ,
    ) //,
        // )
        ;
  }

  // Widget getEditBody(OptionTemp optionTemp) {
  //   return
  //     GestureDetector(
  //       behavior: HitTestBehavior.translucent,
  //       onTap: () {
  //         // 点击空白页面关闭键盘
  //         FocusScope.of(context).requestFocus(FocusNode());
  //       },
  //       child: Container(
  //         padding: EdgeInsets.only(top: 10, bottom: 10),
  //         child:
  //             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //           GlobalFun.fbInputBox(
  //               context, "Description", (optionTemp.desc?.toString() ?? ""),
  //               (value) {
  //             setState(() {
  //               optionTemp.desc = value;
  //             });
  //           }),
  //           GlobalFun.commonTitle(
  //             context,
  //             "Temp",
  //             rightWidget:
  //             Tooltip(message: "message", child: Icon(Ionicons.md_settings_outline),)
  //             // IconButton(
  //             //   tooltip: "test",
  //             //   icon: const Icon(
  //             //     Icons.settings,
  //             //   ),
  //             //   onPressed: () {
  //             //     showSetting(optionTemp);
  //             //   },
  //             // ),
  //           ),
  //           Container(
  //             padding: EdgeInsets.only(top: 10, bottom: 10),
  //             color: Colors.transparent,
  //             //width: 1.sw,
  //             //height: 100 ,
  //             child: WidgetOptionPage.build(
  //                 context, optionTemp.property!, _itemOptionList,
  //                 rowMaxcount: 3),
  //           ),
  //         ]),
  //       ));
  // }

  void showSetting(OptionTemp optionTemp) {
    GlobalFun.showBottomSheet(
        context,
        [
          GlobalFun.customListTitle(context:context, icon:Ionicons.md_settings_outline, title:"Title style",
             doTop:  () {
            Navigator.pop(context);
            GlobalFun.showBottomSheetForTextPrperty(
                context,
                TextSettingWidget(
                    property: optionTemp.property.titlePr,
                    data: _itemOptionList.title,
                    onChange: (value) {
                      setState(() {
                        optionTemp.property.titlePr = value;
                      });
                    }),
                null);
          },isFirst:true),
          GlobalFun.customListTitle(context:context, icon:
              Ionicons.md_settings_outline, title:"Background style", doTop: () {
            Navigator.pop(context);
            GlobalFun.showBottomSheetForTextPrperty(
                context,
                TextSettingWidget(
                    property: optionTemp.property.framPr,
                    data: "",
                    onChange: (value) {
                      setState(() {
                        optionTemp.property.framPr = value;
                      });
                    }),
                null);
          }),
          GlobalFun.customListTitle(context:context, icon:
              Ionicons.md_settings_outline, title:"Option style(not selected)", doTop: () {
            Navigator.pop(context);
            GlobalFun.showBottomSheetForTextPrperty(
                context,
                TextSettingWidget(
                    property: optionTemp.property.buttonPr,
                    data: _itemOptionList.options!.first.title,
                    onChange: (value) {
                      setState(() {
                        optionTemp.property.buttonPr = value;
                      });
                    }),
                null);
          }),
          GlobalFun.customListTitle(context:context, icon:
              Ionicons.md_settings_outline, title:"Option style(selected)", doTop: () {
            Navigator.pop(context);
            GlobalFun.showBottomSheetForTextPrperty(
                context,
                TextSettingWidget(
                    property: optionTemp.property.buttonSelectPr,
                    data: _itemOptionList.options!.first.title,
                    onChange: (value) {
                      setState(() {
                        optionTemp.property.buttonSelectPr = value;
                      });
                    }),
                null);
          }),
          GlobalFun.customListTitle(context:context,icon:Icons.copy, title:"copy(not selected→selected)",
             doTop:  () {
            optionTemp.property.buttonSelectPr =
                optionTemp.property.buttonPr.copy();
            Navigator.pop(context);
          }),
          GlobalFun.customListTitle(context:context,icon:Icons.copy, title:"copy(selected→not selected)",
            doTop:   () {
            optionTemp.property.buttonPr =
                optionTemp.property.buttonSelectPr.copy();
            Navigator.pop(context);
          },isBottom:true),
          // GlobalFun.customListTitle(Icons.copy, "Print", () {
          //   print("titlePr");
          //   print(optionTemp.property!.titlePr.getJsonString());
          //   print("framPr");
          //   print(optionTemp.property!.framPr.getJsonString());
          //   print("buttonPr");
          //   print(optionTemp.property!.buttonPr.getJsonString());
          //   print("buttonSelectPr");
          //   print(optionTemp.property!.buttonSelectPr.getJsonString());
          // }),
        ],
        Colors.white);
  }
}
