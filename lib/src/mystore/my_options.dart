import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemOptionList.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:mbook_flutter/src/comm/model/OptionTempResultList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/tools/widget_option.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';
import 'package:collection/collection.dart';

Function deepEq = const DeepCollectionEquality().equals;

class MyOptionsPage extends StatefulWidget {
  MyOptionsPage(this.optionTemps);

  final List<OptionTemp>? optionTemps;

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
  late ScrollController scrollController;
  bool inReorder = true;

  int copiedIndex = -1;

  //new TextWidgetProperty(backColor: Colors.white)

  List<OptionTemp>? optionTemps = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<OptionTemp> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;

      optionTemps!
        ..clear()
        ..addAll(newItems);
    });
  }


  //OptionWidgetProperty _optionWidgetProperty = OptionWidgetProperty.init();
  ItemOptionList _itemOptionList = ItemOptionList.forTemp();

  int _currentSliderValue = 3;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarView.appbar("Options", true, context:context),
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
            optionTemps!,
            setActions: (c, r, index) {
              return [
                FBListViewWidget.getSlideActionDelete(c, () {
                  setState(() {
                    optionTemps!.remove(r);
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
                      GlobalFun.fbInputBox(
                          context, "Description", (optionTemps![index].desc?.toString() ?? ""),
                          (value) {
                        setState(() {
                          optionTemps![index].desc = value;
                        });
                      }),
                      GlobalFun.commonTitle("Temp"),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.transparent,
                        //width: 1.sw,
                        //height: 100 ,
                        child: WidgetOptionPage.build(
                            context, optionTemps![index].property!, _itemOptionList,
                            rowMaxcount: _currentSliderValue),
                      ),
                    ]),
              );
            },
            footer: FBListViewWidget.buildFooter(context,
                icon: Icons.add, title: "Add a Option template", onTap: () {
              setState(() {
                optionTemps!.add(OptionTemp( desc: ""));
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
                        optionTemps![index].property =
                            optionTemps![copiedIndex].property!.copy();
                    });
                  })
              ];
            },
          ),
        ),
      ),
      floatingActionButton: GlobalFun.saveFloatingActionButton(() {
        GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Saving...");
        Api.saveMyOptionTempnfo(
                context, OptionTempResultList(optionTempLst: this.optionTemps))
            .whenComplete(() {
          GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        }).catchError((e) {
          GlobalFun.showSnackBar(context,_scaffoldKey, null, e.toString());
        });
      }),
    );
  }
}
