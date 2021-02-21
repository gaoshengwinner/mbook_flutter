import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemOptionList.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:mbook_flutter/src/comm/model/OptionTempResultList.dart';
import 'package:mbook_flutter/src/comm/model/widget/OptionWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/tools/widget_option.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';
import 'package:collection/collection.dart';

Function deepEq = const DeepCollectionEquality().equals;

class MyOptionsPage extends StatefulWidget {
  MyOptionsPage(this.optionTemps);

  List<OptionTemp> optionTemps = [];

  _MyOptionsPageState createState() => _MyOptionsPageState(this.optionTemps);
}

class _MyOptionsPageState extends State<MyOptionsPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _MyOptionsPageState(this.optionTemps) {
    if (optionTemps == null) {
      this.optionTemps = [];
    }
  }

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  ScrollController scrollController;
  bool inReorder = true;

  int copiedIndex = -1;

  //new TextWidgetProperty(backColor: Colors.white)

  List<OptionTemp> optionTemps = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<OptionTemp> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;

      optionTemps
        ..clear()
        ..addAll(newItems);
    });
  }

  final FocusNode _descriptionNode = FocusNode();

  //OptionWidgetProperty _optionWidgetProperty = OptionWidgetProperty.init();
  ItemOptionList _ItemOptionList = ItemOptionList.forTemp();

  int _currentSliderValue = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBarView.appbar("Options", true),
      key: _scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(_blankNode);
        },
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: new FBListViewWidget<OptionTemp>(
            optionTemps,
            setActions: (c, r, index) {
              return [
                FBListViewWidget.getSlideActionDelete(c, () {
                  setState(() {
                    optionTemps.remove(r);
                  });
                })
              ];
            },
            canBeMove: true,
            setSubWidget: (c, r, index) {
              return Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalFun.FBInputBox(
                          context, "Description", optionTemps[index].desc,
                          (value) {
                        setState(() {
                          optionTemps[index].desc = value;
                        });
                      }),
                      GlobalFun.commonTitle("Temp",
                          width: 0.95.sw,
                          rightWidget: GlobalFun.ClipOvalIconTitle(
                              Icons.settings, "", () {
                            GlobalFun.showBottomSheet(
                                context,
                                [
                                  GlobalFun.CustomListTitle(
                                      Icons.settings, "Title style", () {
                                    Navigator.pop(context);
                                    GlobalFun.showBottomSheetForTextPrperty(
                                        context,
                                        TextSettingWidget(
                                            property:
                                            optionTemps[index].property.titlePr,
                                            data: _ItemOptionList.title,
                                            onChange: (value) {
                                              setState(() {
                                                optionTemps[index].property.titlePr =
                                                    value;
                                              });
                                            }),
                                        null);
                                  }),
                                  GlobalFun.CustomListTitle(
                                      Icons.settings, "Frame style", () {
                                    Navigator.pop(context);
                                    return GlobalFun
                                        .showBottomSheetForTextPrperty(
                                            context,
                                            TextSettingWidget(
                                                property: optionTemps[index].property
                                                    .framPr,
                                                data: "",
                                                onChange: (value) {
                                                  setState(() {
                                                    optionTemps[index].property
                                                        .framPr = value;
                                                  });
                                                }),
                                            null);
                                  }),
                                  GlobalFun.CustomListTitle(Icons.settings,
                                      "Option style(not selected)", () {
                                    Navigator.pop(context);
                                    return GlobalFun
                                        .showBottomSheetForTextPrperty(
                                            context,
                                            TextSettingWidget(
                                                property: optionTemps[index].property
                                                    .buttonPr,
                                                data: _ItemOptionList
                                                    .options.first.title,
                                                onChange: (value) {
                                                  setState(() {
                                                    optionTemps[index].property
                                                        .buttonPr = value;
                                                  });
                                                }),
                                            null);
                                  }),
                                  GlobalFun.CustomListTitle(
                                      Icons.settings, "Option style(selected)",
                                      () {
                                    Navigator.pop(context);
                                    return GlobalFun
                                        .showBottomSheetForTextPrperty(
                                            context,
                                            TextSettingWidget(
                                                property: optionTemps[index].property
                                                    .buttonSelectPr,
                                                data: _ItemOptionList
                                                    .options.first.title,
                                                onChange: (value) {
                                                  setState(() {
                                                    optionTemps[index].property
                                                        .buttonSelectPr = value;
                                                  });
                                                }),
                                            null);
                                  }),
                                  GlobalFun.CustomListTitle(Icons.copy,
                                      "Option style copy(not selected→selected",
                                      () {
                                        optionTemps[index].property.buttonSelectPr =
                                            optionTemps[index].property.buttonPr.copy();
                                    Navigator.pop(context);
                                  }),
                                  GlobalFun.CustomListTitle(Icons.copy,
                                      "Option style copy(selected→not selected",
                                      () {
                                        optionTemps[index].property.buttonPr =
                                            optionTemps[index].property.buttonSelectPr
                                            .copy();
                                    Navigator.pop(context);
                                  }),
                                  GlobalFun.CustomListTitle(Icons.copy,
                                      "Print",
                                          () {
                                            print("titlePr");
                                            print(optionTemps[index].property.titlePr.getJsonString());
                                            print("framPr");
                                            print(optionTemps[index].property.framPr.getJsonString());
                                            print("buttonPr");
                                            print(optionTemps[index].property.buttonPr.getJsonString());
                                            print("buttonSelectPr");
                                            print(optionTemps[index].property.buttonSelectPr.getJsonString());
                                      }),
                                  CupertinoSlider(
                                    value: _currentSliderValue.toDouble(),
                                    min: 1,
                                    max: 10,
                                    onChanged: (double value) {
                                      setState(() {
                                        _currentSliderValue = value.toInt();
                                      });
                                    },
                                  )
                                ],
                                null);
                            return;

                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                // title: const Text('Choose Options'),
                                // message: const Text('Your options are '),
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    child: GlobalFun.setingRow(
                                        null, "Title style"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      GlobalFun.showBottomSheetForTextPrperty(
                                          context,
                                          TextSettingWidget(
                                              property:
                                              optionTemps[index].property.titlePr,
                                              data: _ItemOptionList.title,
                                              onChange: (value) {
                                                setState(() {
                                                  optionTemps[index].property
                                                      .titlePr = value;
                                                });
                                              }),
                                          null);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: GlobalFun.setingRow(
                                        null, "Frame style"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      return GlobalFun
                                          .showBottomSheetForTextPrperty(
                                              context,
                                              TextSettingWidget(
                                                  property:
                                                  optionTemps[index].property
                                                          .framPr,
                                                  data: "",
                                                  onChange: (value) {
                                                    setState(() {
                                                      optionTemps[index].property
                                                          .framPr = value;
                                                    });
                                                  }),
                                              null);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: GlobalFun.setingRow(
                                        null, "Option style(not selected)"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      return GlobalFun
                                          .showBottomSheetForTextPrperty(
                                              context,
                                              TextSettingWidget(
                                                  property:
                                                  optionTemps[index].property
                                                          .buttonPr,
                                                  data: _ItemOptionList
                                                      .options.first.title,
                                                  onChange: (value) {
                                                    setState(() {
                                                      optionTemps[index].property
                                                          .buttonPr = value;
                                                    });
                                                  }),
                                              null);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: GlobalFun.setingRow(
                                        null, "Option style(selected)"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      return GlobalFun
                                          .showBottomSheetForTextPrperty(
                                              context,
                                              TextSettingWidget(
                                                  property:
                                                  optionTemps[index].property
                                                          .buttonSelectPr,
                                                  data: _ItemOptionList
                                                      .options.first.title,
                                                  onChange: (value) {
                                                    setState(() {
                                                      optionTemps[index].property
                                                              .buttonSelectPr =
                                                          value;
                                                    });
                                                  }),
                                              null);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: GlobalFun.setingRow(null,
                                        "Option style copy(not selected→selected)"),
                                    onPressed: () {
                                      optionTemps[index].property.buttonSelectPr =
                                          optionTemps[index].property.buttonPr.copy();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Container(
                                    child: CupertinoSlider(
                                      value: _currentSliderValue.toDouble(),
                                      min: 1,
                                      max: 10,
                                      onChanged: (double value) {
                                        setState(() {
                                          _currentSliderValue = value.toInt();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.transparent,
                        //width: 1.sw,
                        //height: 100 ,
                        child: WidgetOptionPage.build(
                            context, optionTemps[index].property, _ItemOptionList,
                            rowMaxcount: _currentSliderValue),
                      ),
                    ]),
              );
            },
            footer: FBListViewWidget.buildFooter(context,
                icon: Icons.add, title: "Add a Option template", onTap: () {
              setState(() {
                optionTemps.add(OptionTemp( desc: ""));
              });
            }),
            setSeActions: (c, r, index) {
              return [
                FBListViewWidget.getSlideActionCopy(c, () {
                  setState(() {
                    copiedIndex = index;
                  });
                }),
                if (copiedIndex >= 0 && copiedIndex != index)
                  FBListViewWidget.getSlideActionBrush(c, () {
                    setState(() {
                      if (copiedIndex >= 0)
                        optionTemps[index].property =
                            optionTemps[copiedIndex].property.copy();
                    });
                  })
              ];
            },
          ),
        ),
      ),
      floatingActionButton: GlobalFun.saveFloatingActionButton(() {
        GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
        Api.saveMyOptionTempnfo(
                context, OptionTempResultList(optionTempLst: this.optionTemps))
            .whenComplete(() {
          GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        }).catchError((e) {
          GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        });
      }),
    );
  }
}
