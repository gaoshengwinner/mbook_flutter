import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
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

  OptionWidgetProperty _optionWidgetProperty = OptionWidgetProperty();
  ItemOptionList _ItemOptionList = ItemOptionList.forTemp();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBarView.appbar("Options", true),
      key: _scaffoldKey,
      body:

      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(_blankNode);
        },
        child:
        SizedBox(
          height: 1.sh,
          width: 1.sw,
          child:
        new FBListViewWidget<OptionTemp>(
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
                    GlobalFun.commonTitle("Temp", width: 1.sw),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.white,
                      //width: 1.sw,
                      //height: 100 ,
                      child: WidgetOptionPage.build(context, _optionWidgetProperty, _ItemOptionList),
                    )
                    ,
                    GlobalFun.commonTitle("Setting", width: 1.sw),
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: GlobalFun.ClipOvalIconTitle(
                            Icons.settings, "frame style", () {
                          return GlobalFun.showBottomSheetForTextPrperty(
                              context,
                              TextSettingWidget(
                                  property: _optionWidgetProperty.framPr,
                                  data: optionTemps[index].data,
                                  onChange: (value) {
                                    setState(() {
                                      _optionWidgetProperty.framPr = value;
                                    });
                                  }),
                              null);
                        }),
                      ),
                      Expanded(
                        flex: 1,
                        child: GlobalFun.ClipOvalIconTitle(
                            Icons.settings, "title style", () {
                          return GlobalFun.showBottomSheetForTextPrperty(
                              context,
                              TextSettingWidget(
                                  property: _optionWidgetProperty.titlePr,
                                  data: _ItemOptionList.title,
                                  onChange: (value) {
                                    setState(() {
                                      _optionWidgetProperty.titlePr = value;
                                    });
                                  }),
                              null);
                        }),
                      ),
                    ]),
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: GlobalFun.ClipOvalIconTitle(
                            Icons.settings, "Button style", () {
                          return GlobalFun.showBottomSheetForTextPrperty(
                              context,
                              TextSettingWidget(
                                  property: _optionWidgetProperty.buttonPr,
                                  data: _ItemOptionList.options.first.title,
                                  onChange: (value) {
                                    setState(() {
                                      _optionWidgetProperty.buttonPr = value;
                                    });
                                  }),
                              null);
                        }),
                      ),
                      Expanded(
                        flex: 1,
                        child: GlobalFun.ClipOvalIconTitle(
                            Icons.settings, "Button selected style", () {
                          return GlobalFun.showBottomSheetForTextPrperty(
                              context,
                              TextSettingWidget(
                                  property: _optionWidgetProperty.buttonSelectPr,
                                  data: _ItemOptionList.options.first.title,
                                  onChange: (value) {
                                    setState(() {
                                      _optionWidgetProperty.buttonSelectPr = value;
                                    });
                                  }),
                              null);
                        }),
                      ),
                    ]),
                  ]),
            );
          },
          footer: FBListViewWidget.buildFooter(context,
              icon: Icons.add, title: "Add a Option template", onTap: () {
            setState(() {
              optionTemps.add(OptionTemp(data: "", desc: ""));
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
        Api.saveOptionTempInfo(
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
