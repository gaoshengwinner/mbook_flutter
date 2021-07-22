import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/model/OptionGroupInfo.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';

typedef OptionSelectEventFunction = void Function(
    OptionGroupInfo optionGroupInfo);

class WidgetOptionWidget extends StatefulWidget {
  OptionGroupInfo optionGroupInfo;
  OptionTemp optionTemp;
  OptionSelectEventFunction? onSelected;

  WidgetOptionWidget(
      {required this.optionGroupInfo,
      required this.optionTemp,
      this.onSelected});

  @override
  _WidgetOptionWidgetState createState() => _WidgetOptionWidgetState();
}

class _WidgetOptionWidgetState extends State<WidgetOptionWidget> {
  ScrollController _controller = ScrollController();

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
    // if (widget.data.options!.contains(widget.initialKeyValue))
    //   _selectedKey = widget.initialKeyValue;
    // else
    //   _selectedKey = widget.data.options!.first;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.optionGroupInfo.options == null ||
        widget.optionGroupInfo.options!.isEmpty) {
      return Text("");
    }

    var rowMaxcount = widget.optionGroupInfo.lineDispCount == null
        ? widget.optionTemp.defaultLineCount
        : widget.optionGroupInfo.lineDispCount!;

    double realWidth = (1.sw -
            widget.optionTemp.property.framPr.marginLeft -
            widget.optionTemp.property.framPr.marginRight -
            widget.optionTemp.property.framPr.paddingLeft -
            widget.optionTemp.property.framPr.paddingRight -
            (rowMaxcount - 1) *
                widget.optionTemp.property.framPr.spacingHWidth) /
        rowMaxcount;

    final List<List<Widget>> buttonList = [];
    int i = 1;
    int j = 0;
    List<Widget> row = [];
    for (var index = 0; index < widget.optionGroupInfo.options!.length; index++) {
      if (row.length > 0) {
        row.add(new Expanded(
          flex: widget.optionTemp.property.framPr.spacingHWidth.toInt(),
          child: SizedBox(
            width: widget.optionTemp.property.framPr.spacingHWidth,
            height: widget.optionTemp.property.framPr.spacingVWidth,
          ),
        ));
      }
      row.add(new Expanded(
        flex: realWidth.toInt(),
        child: buildSelectionButton(widget.optionGroupInfo.options![index], i),
      ));
      if ((i % rowMaxcount == 0 ||
          i == widget.optionGroupInfo.options!.length)) {
        if (i == widget.optionGroupInfo.options!.length &&
            i % rowMaxcount != 0) {
          j++;
        } else {
          j = 0;
        }
        buttonList.add(row);
        if (i < widget.optionGroupInfo.options!.length) {
          buttonList.add([
            SizedBox(
              height: widget.optionTemp.property.framPr.spacingVWidth,
              width: widget.optionTemp.property.framPr.spacingHWidth,
            )
          ]);
        }

        row = [];
      } else {
        j++;
      }

      i++;
    }
    if (j != 0)
      for (int l = j; l < rowMaxcount; l++) {
        buttonList.last.add(new Expanded(
          flex: widget.optionTemp.property.framPr.spacingHWidth.toInt(),
          child: SizedBox(
            width: widget.optionTemp.property.framPr.spacingHWidth,
            height: widget.optionTemp.property.framPr.spacingVWidth,
          ),
        ));
        buttonList.last.add(new Expanded(
          flex: realWidth.toInt(),
          child: SizedBox(
            width: realWidth,
            height: widget.optionTemp.property.framPr.spacingVWidth,
            child: Text(
                "                                                               "),
          ),
        ));
      }

    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
          for (var row in buttonList)
            Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: row)),
        ])
        //)
        ;
  }

  Widget buildSelectionButton(Option option, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          int selectedCount = widget.optionGroupInfo.options?.where((o) {
                return o.selected;
              }).length ??
              0;
          // 之前是未选中
          if (!option.selected) {
            if (selectedCount <
                (widget.optionGroupInfo.mustSelectMax ??
                    widget.optionGroupInfo.options?.length ??
                    0)) {
              option.selected = !option.selected;

            } else {
              List<Option>? tmp = widget.optionGroupInfo.options?.where((o) {
                return o.selected;
              }).toList();
              tmp?.sort((a, b) {
                return a.selectedTime!.compareTo(b.selectedTime!);
              });
              tmp?.first.selected = false;
              option.selected = !option.selected;
            }
          } else {
            //之前是选中
            if (selectedCount > (widget.optionGroupInfo.mustSelectMin ?? 0)) {
              option.selected = !option.selected;
            }
          }
        });
         if ( widget.onSelected != null)widget.onSelected!(widget.optionGroupInfo);
      },
      child: WidgetTextPage(
          property: (option.selected)
              ? widget.optionTemp.property.buttonSelectPr
              : widget.optionTemp.property.buttonPr,
          data: option.title),
    );
  }
}

//   static Widget build(
//       BuildContext context, OptionWidgetProperty property, ItemOptionList data,
//       {int rowMaxcount = 3}) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           child: WidgetTextPage(property: property.titlePr, data: data.title),
//         ),
//         WidgetBasePage.build(
//           context,
//           property.framPr,
//           child: _CupertinoRadioChoice(
//             onChange: (value) {},
//             initialKeyValue: data.options!.first,
//             optionWidgetProperty: property,
//             data: data,
//             rowMaxcount: rowMaxcount,
//           ),
//         ),
//       ],
//     );
//   }
//
//
// }
//
// class _CupertinoRadioChoice extends StatefulWidget {
//   /// CupertinoRadioChoice displays a radio choice widget with cupertino format
//   _CupertinoRadioChoice(
//       { //@required this.choices,
//       required this.onChange,
//       required this.initialKeyValue,
//       this.enabled = true,
//       required this.optionWidgetProperty,
//       required this.data,
//       this.rowMaxcount = 3});
//
//   final int rowMaxcount;
//   final ItemOptionList data;
//
//   final OptionWidgetProperty optionWidgetProperty;
//
//   /// Function is called if the user selects another choice
//   final Function onChange;
//
//   /// Defines which choice shall be selected initally by key
//   final ItemOption initialKeyValue;
//
//   /// Defines if the widget shall be enabled (clickable) or not
//   final bool enabled;
//
//   @override
//   _CupertinoRadioChoiceState createState() => new _CupertinoRadioChoiceState();
// }
//
// /// State of the widget
// class _CupertinoRadioChoiceState extends State<_CupertinoRadioChoice> {
//   dynamic _selectedKey;
//   late ScrollController _controller;
//
//   _scrollListener() {
//     if (_controller.offset >= _controller.position.maxScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         //you can do anything here
//       });
//     }
//     if (_controller.offset <= _controller.position.minScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         //you can do anything here
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     _controller = ScrollController();
//     _controller.addListener(_scrollListener);
//     super.initState();
//     if (widget.data.options!.contains(widget.initialKeyValue))
//       _selectedKey = widget.initialKeyValue;
//     else
//       _selectedKey = widget.data.options!.first;
//   }
//
//   Widget buildSelectionButton(ItemOption key, {bool selected = false}) {
//     return InkWell(
//       onTap: !widget.enabled || selected
//           ? null
//           : () {
//               setState(() {
//                 _selectedKey = key;
//               });
//               if (widget.onChange != null) {
//                 widget.onChange(_selectedKey);
//               }
//             },
//       child: WidgetTextPage(
//           property: selected
//               ? widget.optionWidgetProperty.buttonSelectPr
//               : widget.optionWidgetProperty.buttonPr,
//           data: key.title),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double realWidth = (1.sw -
//             widget.optionWidgetProperty.framPr.marginLeft -
//             widget.optionWidgetProperty.framPr.marginRight -
//             widget.optionWidgetProperty.framPr.paddingLeft -
//             widget.optionWidgetProperty.framPr.paddingRight -
//             (widget.rowMaxcount - 1) *
//                 widget.optionWidgetProperty.framPr.spacingHWidth) /
//         widget.rowMaxcount;
//
//     final List<List<Widget>> buttonList = [];
//     int i = 1;
//     int j = 0;
//     List<Widget> row = [];
//     for (var key in widget.data.options!) {
//       if (row.length > 0) {
//         row.add(new Expanded(
//           flex: widget.optionWidgetProperty.framPr.spacingHWidth.toInt(),
//           child: SizedBox(
//             width: widget.optionWidgetProperty.framPr.spacingHWidth,
//             height: widget.optionWidgetProperty.framPr.spacingVWidth,
//           ),
//         ));
//       }
//       row.add(new Expanded(
//         flex: realWidth.toInt(),
//         child: buildSelectionButton(key, selected: _selectedKey == key),
//       ));
//       if ((i % widget.rowMaxcount == 0 || i == widget.data.options!.length)) {
//         if (i == widget.data.options!.length && i % widget.rowMaxcount != 0) {
//           j++;
//         } else {
//           j = 0;
//         }
//         buttonList.add(row);
//         if (i < widget.data.options!.length) {
//           buttonList.add([
//             SizedBox(
//               height: widget.optionWidgetProperty.framPr.spacingVWidth,
//               width: widget.optionWidgetProperty.framPr.spacingHWidth,
//             )
//           ]);
//         }
//
//         row = [];
//       } else {
//         j++;
//       }
//
//       i++;
//     }
//     if (j != 0)
//       for (int l = j; l < widget.rowMaxcount; l++) {
//         buttonList.last.add(new Expanded(
//           flex: widget.optionWidgetProperty.framPr.spacingHWidth.toInt(),
//           child: SizedBox(
//             width: widget.optionWidgetProperty.framPr.spacingHWidth,
//             height: widget.optionWidgetProperty.framPr.spacingVWidth,
//           ),
//         ));
//         buttonList.last.add(new Expanded(
//           flex: realWidth.toInt(),
//           child: SizedBox(
//             width: realWidth,
//             height: widget.optionWidgetProperty.framPr.spacingVWidth,
//             child: Text(
//                 "                                                               "),
//           ),
//         ));
//       }
//
//     return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//           for (var row in buttonList)
//             Center(
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.min,
//                     children: row
//                     )),
//         ])
//         //)
//         ;
//
//   }
// }
