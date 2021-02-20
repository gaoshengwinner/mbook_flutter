import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/extension/extension.dart';
import 'package:mbook_flutter/src/comm/model/ItemOptionList.dart';
import 'package:mbook_flutter/src/comm/model/widget/OptionWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';

class WidgetOptionPage {
  static Widget build(BuildContext context, OptionWidgetProperty property,
      ItemOptionList data ,{int rowMaxcount = 3}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: WidgetTextPage(property: property.titlePr, data: data.title),
        ),
        WidgetBasePage.build(
          context,
          property.framPr,
          child: _CupertinoRadioChoice(
            onChange: () {},
            initialKeyValue: data.options.first,
            optionWidgetProperty: property,
            data: data,
            rowMaxcount: rowMaxcount,
          ),
        ),

      ],
    );
  }
}

class _CupertinoRadioChoice extends StatefulWidget {
  /// CupertinoRadioChoice displays a radio choice widget with cupertino format
  _CupertinoRadioChoice(
      { //@required this.choices,
      @required this.onChange,
      @required this.initialKeyValue,
      this.enabled = true,
      this.optionWidgetProperty,
      this.data,
      this.rowMaxcount = 3});

  final int rowMaxcount;
  final ItemOptionList data;

  final OptionWidgetProperty optionWidgetProperty;

  /// Function is called if the user selects another choice
  final Function onChange;

  /// Defines which choice shall be selected initally by key
  final ItemOption initialKeyValue;

  /// Contains a map which defines which choices shall be displayed (key => value).
  /// Values are the values displyed in the choices
  //final Map<dynamic, String> choices;

  /// Defines if the widget shall be enabled (clickable) or not
  final bool enabled;

  @override
  _CupertinoRadioChoiceState createState() => new _CupertinoRadioChoiceState();
}

/// State of the widget
class _CupertinoRadioChoiceState extends State<_CupertinoRadioChoice> {
  dynamic _selectedKey;
  ScrollController _controller;

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
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    if (widget.data.options.contains(widget.initialKeyValue))
      _selectedKey = widget.initialKeyValue;
    else
      _selectedKey = widget.data.options.first;
  }

  Widget buildSelectionButton(ItemOption key, {bool selected = false}) {
    return InkWell(
      onTap: !widget.enabled || selected
          ? null
          : () {
              setState(() {
                _selectedKey = key;
              });
              widget.onChange(_selectedKey);
            },
      child: WidgetTextPage(
          property: selected
              ? widget.optionWidgetProperty.buttonSelectPr
              : widget.optionWidgetProperty.buttonPr,
          data: key.title),
    );
  }

  @override
  Widget build(BuildContext context) {

    double realWidth = (1.sw -
            widget.optionWidgetProperty.framPr.marginLeft -
            widget.optionWidgetProperty.framPr.marginRight -
            widget.optionWidgetProperty.framPr.paddingLeft -
            widget.optionWidgetProperty.framPr.paddingRight -
            (widget.rowMaxcount - 1) * widget.optionWidgetProperty.framPr.spacingHWidth) /
        widget.rowMaxcount;

    final List<List<Widget>> buttonList = [];
    int i = 1;
    int j = 0;
    List<Widget> row = [];
    for (var key in widget.data.options) {
      if (row.length > 0) {
        row.add(new Expanded(
          flex: widget.optionWidgetProperty.framPr.spacingHWidth.toInt(),
          child: SizedBox(
            width: widget.optionWidgetProperty.framPr.spacingHWidth,
            height: widget.optionWidgetProperty.framPr.spacingVWidth,
          ),
        ));
      }
      row.add(new Expanded(
        flex: realWidth.toInt(),
        child: buildSelectionButton(key, selected: _selectedKey == key),
      ));
      if ((i % widget.rowMaxcount == 0 || i == widget.data.options.length)) {
        if (i == widget.data.options.length && i % widget.rowMaxcount != 0) {
          j++;
        } else {
          j = 0;
        }
        buttonList.add(row);
        if (i < widget.data.options.length) {
          buttonList.add([
            SizedBox(
              height: widget.optionWidgetProperty.framPr.spacingVWidth,
              width: widget.optionWidgetProperty.framPr.spacingHWidth,
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
      for (int l = j; l < widget.rowMaxcount; l++) {
        buttonList.last.add(new Expanded(
          flex: widget.optionWidgetProperty.framPr.spacingHWidth.toInt(),
          child: SizedBox(
            width: widget.optionWidgetProperty.framPr.spacingHWidth,
            height: widget.optionWidgetProperty.framPr.spacingVWidth,
          ),
        ));
        buttonList.last.add(new Expanded(
          flex: realWidth.toInt(),
          child: SizedBox(
            width: realWidth,
            height: widget.optionWidgetProperty.framPr.spacingVWidth,
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
                    children: row
                    //     [
                    //   for (var child in row)
                    //     Expanded(
                    //       flex: 5,
                    //       child: child,
                    //     ),
                    // ]
                    )),
        ])
        //)
        ;

    // final List<List<Widget>> buttonList = [];
    // int i = 1;
    // for (var key in widget.data.options) {
    //   buttonList.add(buildSelectionButton(key, selected: _selectedKey == key));
    //   // buttonList.add(
    //   //     SizedBox(width: 100, height: 100, child:  Text("Text"),));
    // }
    //
    // double spacing = 5; // TODO
    // double realWidth = (1.sw - widget.optionWidgetProperty.framPr.marginLeft
    //     - widget.optionWidgetProperty.framPr.marginRight - (widget.rowMaxcount - 1) * spacing) /  widget.rowMaxcount ;
    // final int rows = (buttonList.length / widget.rowMaxcount).ceil();
    // var releaAllHeight = rows * widget.optionWidgetProperty.buttonPr.minHeight +
    //     (rows-1) * spacing + widget.optionWidgetProperty.framPr.marginTop
    //     + widget.optionWidgetProperty.framPr.marginBottom
    // ;
    // return
    //   // SizedBox(
    //   //   height: releaAllHeight,
    //   //   child:
    //
    //     GridView.count(
    //       children: buttonList,
    //       crossAxisCount: widget.rowMaxcount,
    //       padding: EdgeInsets.all(10),
    //       crossAxisSpacing: spacing,
    //       // 水平距离
    //       mainAxisSpacing: spacing,
    //       // 垂直距离
    //       childAspectRatio: realWidth  / widget.optionWidgetProperty.buttonPr.minHeight, // 宽高比例
    //     )
    //
    //   //)
    // ;

    // GridView.builder(
    //     controller:_controller,
    //   itemBuilder: (ctx,index){
    //
    //   return buildSelectionButton(widget.data.options[index], selected: _selectedKey == widget.data.options[index]);
    // },
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1.0/1.20),
    //   itemCount: widget.data.options.length,
    // ),

    //  )
    // ;

    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
          for (var row in buttonList)
            Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  for (var child in row)
                    Expanded(
                      flex: 5,
                      child: child,
                    )
                ]))
        ])
        //)
        ;
  }
}
