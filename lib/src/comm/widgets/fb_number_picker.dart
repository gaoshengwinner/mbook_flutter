import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FBNumberPicker<T extends num> extends StatefulWidget {
  final String? title;
  final T initialValue;
  final T maxValue;
  final T minValue;
  final T step;
  final Function(dynamic) onValue;
  final bool canInputByKeyboard;

  const FBNumberPicker(
      {Key? key,
      required this.initialValue,
      required this.maxValue,
      required this.minValue,
      required this.step,
      required this.onValue,
      this.title,
      this.canInputByKeyboard = true})
      : super(key: key);

  @override
  _FBNumberPickerState createState() => _FBNumberPickerState();
}

class _FBNumberPickerState<T extends num> extends State<FBNumberPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment:CrossAxisAlignment.baseline,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.title != null) Container(width: 0.5.sw,child:AutoSizeText(widget.title!,maxLines: 1,
        style: Theme.of(context).textTheme.subtitle1)),
        Container(
          color: Colors.white,
          child: CustomNumberPicker(
            valueTextStyle: TextStyle().copyWith(
                color: Colors.black,
                //backgroundColor: Colors.white,
                fontSize: Theme.of(context).textTheme.bodyText1?.fontSize),
            initialValue: widget.initialValue,
            maxValue: widget.maxValue,
            minValue: widget.minValue,
            step: widget.step,
            bodyTap: (){
                  if (widget.canInputByKeyboard) {
                    GlobalFun.openEditPage(
                        context: context,
                        //hintTextValue:title,
                        initValue: G.ifNull(widget.initialValue.toString(), ""),
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.number,
                        onEditingCompleteText: (value) {
                          dynamic exValue = value;
                          if (widget.initialValue is int){
                            exValue = int.tryParse(value);
                          } else if (widget.initialValue is double) {
                            exValue = double.tryParse(value);
                          }
                          //final double? intValue = double.tryParse(value);
                          if (exValue != null &&
                              widget.minValue <= exValue &&
                              exValue <= widget.maxValue) {
                            widget.onValue(exValue);
                          }
                          //onChange(value);
                        });
                  }
            },
            customAddButton: Icon(
              Icons.add,
              size: 15,
            ),
            customMinusButton: Icon(Icons.remove, size: 15),
            onValue: (value) {
              widget.onValue(value);
            },
          ),
          ),
       // )
      ],
    );
  }
}

class CustomNumberPicker extends StatefulWidget {
  final ShapeBorder? shape;
  final TextStyle? valueTextStyle;
  final Function(dynamic) onValue;
  final Widget? customAddButton;
  final Widget? customMinusButton;
  final dynamic maxValue;
  final dynamic minValue;
  final dynamic initialValue;
  final dynamic step;
  GestureTapCallback? bodyTap;

  ///default vale true
  final bool enable;

  CustomNumberPicker(
      {Key? key,
      this.shape,
      this.valueTextStyle,
      required this.onValue,
      required this.initialValue,
      required this.maxValue,
      required this.minValue,
      this.step = 1,
      this.customAddButton,
      this.customMinusButton,
      this.enable = true,
      this.bodyTap})
      : assert(initialValue != null),
        assert(initialValue.runtimeType != String),
        assert(maxValue.runtimeType == initialValue.runtimeType),
        assert(minValue.runtimeType == initialValue.runtimeType),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomNumberPickerState();
  }
}

class CustomNumberPickerState extends State<CustomNumberPicker> {
  dynamic _initialValue;
  dynamic _maxValue;
  dynamic _minValue;
  dynamic _step;
  Timer? _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.  dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initialValue = widget.initialValue;
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
    _step = widget.step;
    return IgnorePointer(
      ignoring: !widget.enable,
      child: Card(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        semanticContainer: true,
        color: Colors.transparent,
        shape: widget.shape ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                side: BorderSide(width: 1.0, color: Color(0xffF0F0F0))),
        child:
        Container(
          constraints: BoxConstraints(
            minWidth: 0.4.sw,
            minHeight: 20,
          ),
          child:

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: minus,
                onLongPressStart: (LongPressStartDetails details){
                  _longTaping = true;
                  onLongPress(DoAction.MINUS);
                },
                onLongPressEnd: (LongPressEndDetails details){
                  _longTaping = false;
                },
                child: Padding(
                  padding:
                  EdgeInsets.all(0.0),
                  child: //widget.customMinusButton ??
                      Icon(AntDesign.minuscircleo, color: Colors.grey[500],),
                ),
              ),
              GestureDetector(
                onTap: (widget.bodyTap?? (){}),
                child: Container(
                  width: _textSize(
                          widget.valueTextStyle ?? TextStyle(fontSize: 14))
                      .width,
                  child: Text(
                    "$_initialValue",
                    style: widget.valueTextStyle ?? TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: add,
                onLongPressStart: (LongPressStartDetails details){
                  _longTaping = true;
                  onLongPress(DoAction.ADD);
                },
                onLongPressEnd: (LongPressEndDetails details){
                  _longTaping = false;
                },
                child: Padding(
                  padding:
                  EdgeInsets.all(0.0),
                  child: //widget.customAddButton ??
                      Icon(AntDesign.pluscircleo, color: Colors.grey,),
                ),
              )
            ],
          ),
        ),)
      ),
    );
  }

  Size _textSize(TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: _maxValue.toString(), style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(
          minWidth: 0, maxWidth: _maxValue.toString().length * style.fontSize!);
    return textPainter.size;
  }

  void minus() {
    if (canDoAction(DoAction.MINUS)) {
      setState(() {
        _initialValue -= _step;
        widget.onValue(_initialValue);
      });
    }
  }

  void add() {
    if (canDoAction(DoAction.ADD)) {
      setState(() {
        _initialValue += _step;
        widget.onValue(_initialValue);
      });
    }
  }

  bool _longTaping = false;

  void onLongPress(DoAction action) {
    this._timer = Timer.periodic(
      const Duration(milliseconds: 300),
          (Timer timer) {
        if (!canDoAction(action) || !_longTaping) {
          timer.cancel();
          widget.onValue(_initialValue);
        } else {
          setState(() {
            _initialValue = _initialValue + _step * (action == DoAction.MINUS ? -1 : 1);
          });
        }
      },
    );
  }

  bool canDoAction(DoAction action) {
    if (action == DoAction.MINUS) {
      return _initialValue - _step >= _minValue;
    }
    if (action == DoAction.ADD) {
      return _initialValue + _step <= _maxValue;
    }
    return false;
  }
}

enum DoAction { MINUS, ADD }
