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
      ItemOptionList data) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: WidgetTextPage.build(context, property.titlePr, data.title),
        ),
        _WidgetFramPage(
          context: context,
          optionWidgetProperty: property,
          child: _CupertinoRadioChoice(
            onChange: () {},
            initialKeyValue: data.options.first,
            optionWidgetProperty: property,
            data: data,
            rowMaxcount: 1,
          ),
        ),
      ],
    );
  }
}

class _WidgetFramPage extends StatelessWidget {
  BuildContext context;
  OptionWidgetProperty optionWidgetProperty;
  Widget child;

  _WidgetFramPage({this.context, this.optionWidgetProperty, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          optionWidgetProperty.framPr.marginLeft,
          optionWidgetProperty.framPr.marginTop,
          optionWidgetProperty.framPr.marginRight,
          optionWidgetProperty.framPr.marginBottom),
      width: optionWidgetProperty.framPr.getRealMinWidth(),
      height: optionWidgetProperty.framPr.getRealMinHeight(),
      //property.minHeight,
      alignment: FBAlignment.map()[optionWidgetProperty.framPr.alignment],
      padding: EdgeInsets.only(
          left: optionWidgetProperty.framPr.paddingLeft,
          top: optionWidgetProperty.framPr.paddingTop,
          right: optionWidgetProperty.framPr.paddingRight,
          bottom: optionWidgetProperty.framPr.paddingBottom),
      //margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: optionWidgetProperty.framPr.backColor,
        border: optionWidgetProperty.framPr.borderWidth == null ||
                optionWidgetProperty.framPr.borderWidth < 1
            ? null
            : Border.all(
                color: optionWidgetProperty.framPr.borderColor,
                width: optionWidgetProperty.framPr.borderWidth),
        boxShadow: [
          BoxShadow(
              color: optionWidgetProperty.framPr.shadowOffsetX == 0 &&
                      optionWidgetProperty.framPr.shadowOffsetY == 0
                  ? Colors.transparent
                  : optionWidgetProperty.framPr.shadowColor,
              offset: Offset(optionWidgetProperty.framPr.shadowOffsetX,
                  optionWidgetProperty.framPr.shadowOffsetY),
              blurRadius: optionWidgetProperty.framPr.shadowBlurRadius,
              spreadRadius: optionWidgetProperty.framPr.shadowSpreadRadius)
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                optionWidgetProperty.framPr.borderRadiusTopLeft),
            topRight: Radius.circular(
                optionWidgetProperty.framPr.borderRadiusTopRight),
            bottomLeft: Radius.circular(
                optionWidgetProperty.framPr.borderRadiusBottomLeft),
            bottomRight: Radius.circular(
                optionWidgetProperty.framPr.borderRadiusBottomRight)),
      ),

      child: child == null ? Text("Todo") : child,
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
      child: WidgetTextPage.build(
          context,
          selected
              ? widget.optionWidgetProperty.buttonSelectPr
              : widget.optionWidgetProperty.buttonPr,
          key.title),
    );
    // return Container(
    //   color: Colors.amber,
    //   width: 100,
    //     height: 100,
    //     child: CupertinoButton(
    //       color: Colors.red,
    //         disabledColor:Colors.green,
    //         child:
    //         WidgetTextPage.build(context,
    //             selected ? widget.property : widget.selectproperty, key.title),
    //         onPressed: !widget.enabled || selected
    //             ? null
    //             : () {
    //                 setState(() {
    //                   _selectedKey = key;
    //                 });
    //                 widget.onChange(_selectedKey);
    //               }));
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 10;
    double realWidth = (1.sw -
            widget.optionWidgetProperty.framPr.marginLeft -
            widget.optionWidgetProperty.framPr.marginRight -
            widget.optionWidgetProperty.framPr.paddingLeft -
            widget.optionWidgetProperty.framPr.paddingRight -
            (widget.rowMaxcount - 1) * spacing) /
        widget.rowMaxcount;

    final List<List<Widget>> buttonList = [];
    int i = 1;
    int j = 0;
    List<Widget> row = [];
    for (var key in widget.data.options) {
      if (row.length > 0) {
        row.add(new Expanded(
          flex: spacing.toInt(),
          child: SizedBox(
            width: spacing,
            height: spacing,
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
              height: spacing,
              width: spacing,
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
        flex: spacing.toInt(),
        child: SizedBox(
          width: spacing,
          height: spacing,
        ),
      ));
      buttonList.last.add(new Expanded(
        flex: realWidth.toInt(),
        child: SizedBox(
          width: realWidth,
          height: spacing,
          child: Text("                                                               "),
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
