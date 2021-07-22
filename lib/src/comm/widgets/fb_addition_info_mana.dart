import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/AdditionalInfo.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/tools/group.dart';

typedef OnSaveSettingCallBack = void Function(List<AdditionalInfo> infos);

class AdditionInfoManaWidget extends StatefulWidget {
  final List<AdditionalInfo>? infos;
  final OnSaveSettingCallBack? onSave;

  List<AdditionalInfo> get _infos {
    List<AdditionalInfo> tmpInfos = [];
    if (infos == null || infos!.length == 0) {
      tmpInfos = [];
      for (int i = 1; i <= 10; i++) {
        tmpInfos.add(new AdditionalInfo(no: i, canBeUse: false));
      }
    }
    return tmpInfos;
  }

  AdditionInfoManaWidget({this.infos, this.onSave});

  @override
  _AdditionInfoManaWidgetState createState() =>
      new _AdditionInfoManaWidgetState();
}

class _AdditionInfoManaWidgetState extends State<AdditionInfoManaWidget> {
  FocusNode _blankNode = FocusNode();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (widget.onSave != null) {
      widget.onSave!(widget._infos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 0.9.sh,
      color: Colors.greenAccent,
      child: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(_blankNode);
          },
          child: Container(
            color: backgroundGray,
            child: new ListView.builder(
              itemCount: widget._infos.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child: ListTile(
                    title: Text(
                      "No.${widget._infos[index].no}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                    subtitle: InkWell(
                        onTap: () {
                          // required BuildContext context,
                          // String? hintTextValue,
                          // String? initValue,
                          // required TextInputAction textInputAction,
                          // required TextInputType keyboardType,
                          // required Function onEditingCompleteText}) {
                          GlobalFun.openEditPage(
                              context: context,
                              hintTextValue: "Title",
                              initValue: widget._infos[index].title!,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              onEditingCompleteText: (value) {
                                setState(() {
                                  widget._infos[index].title = value;
                                });
                              });
                        },
                        child: Text(
                            "${widget._infos[index].title == null ? "" : widget._infos[index].title}")),
                    trailing: Checkbox(
                        activeColor: G.appBaseColor[0],
                        value: widget._infos[index].canBeUse,
                        onChanged: (value) {
                          setState(() {
                            widget._infos[index].canBeUse = value;
                          });
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum SwitchItem { none, texts, picturs, videos, htmlTexts, webViewUrl }

// class AdditionColum extends StatefulWidget {
//   SwitchItem nowExpanded;
//   SwitchItem meSwitchItem;
//   List<AdditionalInfo> infos;
//   String title;
//   IconData titleIcon;
//
//   AdditionColum(
//       {this.nowExpanded,
//       this.meSwitchItem,
//       this.title,
//       this.titleIcon,
//       this.infos});
//
//   @override
//   State<StatefulWidget> createState() => new _AdditionColumWidget();
// }
//
// class _AdditionColumWidget extends State<AdditionColum> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ActiveTitle(
//           expand: widget.nowExpanded == widget.meSwitchItem,
//           title: widget.title,
//           titleIcon: widget.titleIcon,
//           infos: widget.infos,
//           onSetting: (infos) {
//             setState(() {
//               widget.infos = infos;
//             });
//           },
//           onTap: (expanded) {
//             setState(() {
//               widget.nowExpanded = widget.nowExpanded != widget.meSwitchItem
//                   ? widget.meSwitchItem
//                   : SwitchItem.none;
//             });
//           },
//         ),
//         if (widget.meSwitchItem == widget.nowExpanded && widget.infos != null)
//           new Column(
//               children:
//                   widget.infos.where((element) => element.canBeUse).map((item) {
//             return Container(
//               color: Colors.white,
//               child: Card(
//                 color: Color(0xFFEFEFF4),
//                 child: ListTile(
//                   title: Container(
//                     alignment: Alignment.centerLeft,
//                     child: CircleAvatar(
//                       radius: 10,
//                       backgroundColor: Colors.grey,
//                       child: Text('${item.no}'),
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                   subtitle: Container(
//                     constraints: BoxConstraints(
//                       minHeight: 40,
//                     ),
//                     child: GlobalFun.fbInputBox(context, null, item.value,
//                         (value) {
//                       setState(() {
//                         item.value = value;
//                       });
//                     },
//                         valueWidget:
//                             widget.meSwitchItem == SwitchItem.htmlTexts
//                                 ? new FBHtmlTextView(src: item.value)
//                                 : null,
//                         width: 0.9.sw),
//                   ),
//                 ),
//               ),
//             );
//           }).toList()),
//       ],
//     );
//   }
// }

// SwitchItem reserSWTexts(SwitchItem switchItem) {
//   return switchItem != SwitchItem.texts ? SwitchItem.texts : SwitchItem.none;
// }
//
// List getCanUseList(List<AdditionalInfo> list) {
//   if (list == null || list.length == 0) {
//     return null;
//   }
//   List result = list.where((element) => element.canBeUse).toList();
//   return (list == null || list.length == 0) ? null : result;
// }
