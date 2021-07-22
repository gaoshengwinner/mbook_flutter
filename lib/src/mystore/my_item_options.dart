import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/model/OptionGroupInfo.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:mbook_flutter/src/comm/tools/widget_option.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_implicitly_animated_reorderable_list.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_number_picker.dart';



class MyItemOptionsPage extends StatefulWidget {
  final List<OptionGroupInfo> _list = [];

  MyItemOptionsPage();

  _MyItemOptionsPageState createState() => _MyItemOptionsPageState();
}

class _MyItemOptionsPageState extends State<MyItemOptionsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FBReorderableList<OptionGroupInfo>(
        actions: [
          ActionsParam(
              kind: ActionsKind.delete,
              actFuction: (int index) {
                setState(() {
                  widget._list.removeAt(index);
                });
              })
        ],
        secondaryActions: [
          ActionsParam(
              kind: ActionsKind.copy,
              actFuction: (int index) {
                setState(() {
                  //
                });
              }),
          ActionsParam(
              kind: ActionsKind.paste,
              actFuction: (int index) {
                setState(() {
                  //
                });
              }),
        ],
        items: widget._list,
        needHandle: true,
        body: (OptionGroupInfo item, int i) {
          return ListTile(
            title: Text(item.title ?? ""),
            trailing: Icon(
              CupertinoIcons.forward,
              color: Theme.of(context).primaryColor,
            ),
          );
        },
        footerParam: FooterParam()
          ..title = Text("Add a option",
              style: TextStyle(color: Theme.of(context).primaryColor))
          ..icon = Icon(Icons.add, color: Theme.of(context).primaryColor)
          ..onTap = () {
            addOption(context);
          },
      ),
    );
  }

  void addOption(BuildContext _context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddOptionPage(
                  onSave: (OptionGroupInfo option) {
                    setState(() {
                      widget._list.add(option);
                    });
                  },
                )));
  }
}

typedef SaveOptionFunction = void Function(OptionGroupInfo info);

class AddOptionPage extends StatefulWidget {
  final OptionGroupInfo? info;
  //late OptionGroupInfo _info;
  final SaveOptionFunction? onSave;

  AddOptionPage({this.info, this.onSave});

  OptionGroupInfo get _info {
    return this.info == null ? OptionGroupInfo() : this.info!.copyWith();
}
  _AddOptionPageState createState() => _AddOptionPageState();
}

class _AddOptionPageState extends State<AddOptionPage> {
  int step = 0;

  List<OptionTemp>? optionTempList = MyGlobal.optionTempInfos;

  _init() {
    if (optionTempList == null) {
      return;
    }
    for (int i = 0; i < optionTempList!.length; i++) {
      if (widget._info.optionTempId == null) {
        _optionTemp = optionTempList![0];
      } else if (optionTempList![i].id == widget._info.optionTempId) {
        _optionTemp = optionTempList![i];
      }
    }
  }

  OptionTemp _optionTemp = OptionTemp(id: null, desc: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarView.appbar(
          title: "Add Option",
          canReturn: true,
          canSave: true,
          onSave: () {
            if (widget.onSave != null) {
              widget.onSave!(widget._info);
            }
            Navigator.pop(context);
          },
          context: context,
        ),
        body: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: ListView(
                children: [
                  GlobalFun.fbInputBox(
                    context,
                    "Title",
                    G.ifNull(widget._info.title, ""),
                    (value) {
                      setState(() {
                        widget._info.title = value;
                      });
                    },
                  ),
                  //if (widget._info.options?.isNotEmpty ?? false)
                  Divider(),
                  //if (widget._info.options?.isNotEmpty ?? false)
                  FBNumberPicker(
                    title: "Minimum selected options",
                    initialValue: widget._info.mustSelectMin?.toInt() ?? 0,
                    maxValue: widget._info.mustSelectMax ?? 0,
                    minValue: 0,
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        widget._info.mustSelectMin = value;
                      });
                    },
                  ),
                  // if (widget._info.options?.isNotEmpty ?? false)
                  Divider(),
                  // if (widget._info.options?.isNotEmpty ?? false)
                  FBNumberPicker(
                    title: "Maximum selected options",
                    initialValue: widget._info.mustSelectMax ?? 0,
                    maxValue: widget._info.options?.length ?? 0,
                    minValue: (widget._info.mustSelectMin ?? 0),
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        widget._info.mustSelectMax = value;
                      });
                    },
                  ),
                  Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Options",
                            style: Theme.of(context).textTheme.subtitle1),
                        IconButton(
                            onPressed: () {
                              if (widget._info.options == null) {
                                widget._info.options = [];
                              }
                              widget._info.options!
                                  .add(Option(title: "", price: null));
                              setState(() {});
                            },
                            icon: Icon(Icons.add))
                      ]),
                  if (widget._info.options?.isNotEmpty ?? false)
                    Column(
                      children: getOptionsWidgetList(),
                    ),
                  Divider(),
                  FBNumberPicker(
                    title: "Rows/line",
                    initialValue: widget._info.lineDispCount ?? 3,
                    maxValue: 20,
                    minValue: 1,
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        widget._info.lineDispCount  = value;
                      });
                    },
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Option Temp",
                          style: Theme.of(context).textTheme.subtitle1),
                      Text("${_optionTemp.id}:${_optionTemp.desc}"),
                      IconButton(
                        onPressed: () {
                          showOptionTempPicker(context,
                              initValue: _optionTemp.id,
                              onSelectedItemChanged: (OptionTemp value) {
                            _optionTemp = value;
                            widget._info.optionTempId = value.id;
                            setState(() {});
                          });
                          //setState(() {});
                        },
                        icon: Row(
                          children: [
                            Icon(
                              CupertinoIcons.forward,
                              color: Theme.of(context).primaryColor,
                              //size: 21.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.transparent,
                      //width: 1.sw,
                      //height: 100 ,
                      child: WidgetOptionWidget(optionGroupInfo: widget._info,optionTemp:_optionTemp)

                    // WidgetOptionWidget.build(context,
                    //     _optionTemps[i].property!, _itemOptionList,
                    //     rowMaxcount: _optionTemps[i].defaultLineCount),
                    //
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> getOptionsWidgetList() {
    List<Widget> result = [];
    for (int i = 0; i < widget._info.options!.length; i++) {
      Slidable slidable = Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Card(
          //color: Colors.white,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalFun.fbInputBox(
                    context, null, G.ifNull(widget._info.options?[i].title, ""),
                    (value) {
                  setState(() {
                    widget._info.options?[i].title = value;
                  });
                }, hintTextValue: "title", width: 0.55.sw),
                GlobalFun.fbInputBox(
                    context, null, G.ifNull(widget._info.options?[i].price, ""),
                    (value) {
                  setState(() {
                    widget._info.options?[i].price = value;
                  });
                }, hintTextValue: "price", width: 0.25.sw),
                // CupertinoSwitch(
                //   activeColor: Theme.of(context).primaryColor,
                //   value: widget._info.options?[i].selected ?? false,
                //   onChanged: (value) {
                //     setState(
                //       () {
                //         widget._info.options![i].selected = value;
                //       },
                //     );
                //   },
                // )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                widget._info.options?.removeAt(i);
              });
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Up',
            color: Colors.blue,
            icon: Entypo.arrow_bold_up,
            onTap: () {
              if (i > 0) {
                setState(() {
                  Option item = widget._info.options![i];
                  widget._info.options!.removeAt(i);
                  widget._info.options!.insert(i - 1, item);
                });
              }
            },
          ),
          IconSlideAction(
            caption: 'Down',
            color: Colors.green,
            icon: Entypo.arrow_bold_down,
            onTap: () {
              if (i < widget._info.options!.length - 1) {
                setState(() {
                  Option item = widget._info.options![i];
                  widget._info.options!.removeAt(i);
                  widget._info.options!.insert(i + 1, item);
                });
              }
            },
          ),
        ],
      );
      result.add(slidable);
    }
    return result;
  }

  showOptionTempPicker(BuildContext context,
      {int? initValue, required Function onSelectedItemChanged}) {
    if (optionTempList == null) {
      return;
    }
    List<Widget> _listView = [];

    for (int i = 0; i < optionTempList!.length; i++) {
      if (initValue == null) {
        initValue = optionTempList![0].id;
      } else if (optionTempList![i].id == initValue) {
        //break;
      }
      _listView
          .add(Text("${optionTempList![i].id}:${optionTempList![i].desc}"));
    }
    GlobalFun.showPicker(context, initValue!.toInt(), _listView, (value) {
      onSelectedItemChanged(optionTempList![value]);
    });
  }
}
