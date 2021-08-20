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
import 'package:mbook_flutter/src/comm/widgets/fb_footer.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_input_box.dart';
import 'package:mbook_flutter/src/my_store/MyGlobal.dart';
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
        body: (OptionGroupInfo optionGroupInfo, int i) {
          return ListTile(
            onTap: () {
              openOptionEdit(option: optionGroupInfo);
            },
            title: Text(optionGroupInfo.description),
            // subtitle: Center(
            //   child: MyGlobal.getOptionTempById(optionGroupInfo.optionTempId) ==
            //           null
            //       ? Text("")
            //       : WidgetOptionWidget(
            //           optionGroupInfo: optionGroupInfo,
            //           optionTemp: MyGlobal.getOptionTempById(
            //               optionGroupInfo.optionTempId)!),
            // ),
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
            openOptionEdit(option: OptionGroupInfo());
          },
      ),
    );
  }

  void openOptionEdit({required OptionGroupInfo option}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddOptionPage(
                  info: option,
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
  final OptionGroupInfo info;

  //late OptionGroupInfo widget.info;
  final SaveOptionFunction? onSave;

  AddOptionPage({required this.info, this.onSave});

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
      if (widget.info.optionTempId == null) {
        _optionTemp = optionTempList![0];
      } else if (optionTempList![i].id == widget.info.optionTempId) {
        _optionTemp = optionTempList![i];
      }
    }
  }

  OptionTemp _optionTemp = OptionTemp(id: null, desc: "");

  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
        //key: GlobalKey<ScaffoldState>(),
        appBar: AppBarView.appbar(
          title: "Add Option",
          canReturn: true,
          canSave: true,
          onSave: () {
            if (widget.onSave != null) {
              widget.onSave!(widget.info);
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
                  FBInputBox(
                    lableText: "Description",
                    value: G.ifNull(widget.info.description, ""),
                    serValue: (value) {
                      setState(() {
                        widget.info.description = value;
                      });
                    },
                  ),
                  //if (widget.info.options?.isNotEmpty ?? false)
                  Divider(),
                  //if (widget.info.options?.isNotEmpty ?? false)
                  FBNumberPicker(
                    title: "Minimum selected options",
                    initialValue: widget.info.mustSelectMin.toInt(),
                    maxValue: widget.info.mustSelectMax,
                    minValue: 0,
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        widget.info.mustSelectMin = value;
                      });
                    },
                  ),
                  // if (widget.info.options?.isNotEmpty ?? false)
                  Divider(),
                  // if (widget.info.options?.isNotEmpty ?? false)
                  FBNumberPicker(
                    title: "Maximum selected options",
                    initialValue: widget.info.mustSelectMax,
                    maxValue: widget.info.options.length,
                    minValue: (widget.info.mustSelectMin),
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        widget.info.mustSelectMax = value;
                      });
                    },
                  ),
                  Divider(),
                  FBInputBox(
                    lableText: "Option title",
                    value: G.ifNull(widget.info.title, ""),
                    serValue: (value) {
                      setState(() {
                        widget.info.title = value;
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
                              setState(() {
                                widget.info.options
                                    .add(Option(title: "", price: null));
                              });
                            },
                            icon: Icon(Icons.add))
                      ]),
                  if (widget.info.options.isNotEmpty)
                    Column(
                      children: getOptionsWidgetList(),
                    ),
                  Divider(),
                  FBNumberPicker(
                    title: "Rows/line",
                    initialValue: widget.info.lineDispCount ?? 3,
                    maxValue: 20,
                    minValue: 1,
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        widget.info.lineDispCount = value;
                      });
                    },
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {
                      showOptionTempPicker(context, initValue: _optionTemp.id,
                          onSelectedItemChanged: (OptionTemp value) {
                        _optionTemp = value;
                        widget.info.optionTempId = value.id;
                        setState(() {});
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Option Temp",
                            style: Theme.of(context).textTheme.subtitle1),
                        Text("${_optionTemp.id}:${_optionTemp.desc}"),
                        Icon(
                          CupertinoIcons.forward,
                          color: Theme.of(context).primaryColor,
                          //size: 21.0,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.transparent,
                      //width: 1.sw,
                      //height: 100 ,
                      child: WidgetOptionWidget(
                          optionGroupInfo: widget.info, optionTemp: _optionTemp)

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
    for (int i = 0; i < widget.info.options.length; i++) {
      Slidable slidable = Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Card(
          //color: Colors.white,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FBInputBox(
                    value: G.ifNull(widget.info.options[i].title, ""),
                    serValue: (value) {
                      setState(() {
                        widget.info.options[i].title = value;
                      });
                    },
                    hintTextValue: "title",
                    width: 0.55.sw),
                FBInputBox(
                    value: G.ifNull(widget.info.options[i].price, ""),
                    serValue: (value) {
                      setState(() {
                        widget.info.options[i].price = value;
                      });
                    },
                    hintTextValue: "price",
                    width: 0.25.sw),
                // CupertinoSwitch(
                //   activeColor: Theme.of(context).primaryColor,
                //   value: widget.info.options?[i].selected ?? false,
                //   onChanged: (value) {
                //     setState(
                //       () {
                //         widget.info.options![i].selected = value;
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
                widget.info.options.removeAt(i);
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
                  Option item = widget.info.options[i];

                  widget.info.options.removeAt(i);

                  widget.info.options.insert(i - 1, item);
                });
              }
            },
          ),
          IconSlideAction(
            caption: 'Down',
            color: Colors.green,
            icon: Entypo.arrow_bold_down,
            onTap: () {
              if (i < widget.info.options.length - 1) {
                setState(() {
                  Option item = widget.info.options[i];

                  widget.info.options.removeAt(i);

                  widget.info.options.insert(i + 1, item);
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
