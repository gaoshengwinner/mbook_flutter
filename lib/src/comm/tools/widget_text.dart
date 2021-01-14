import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';

class WidgetTextPage extends StatefulWidget {
  TextWidgetProperty property;
  String data;

  WidgetTextPage(this.data, this.property);

  _WidgetTextPagetate createState() =>
      _WidgetTextPagetate(this.data, this.property);
}

class _WidgetTextPagetate extends State<WidgetTextPage> {
  TextWidgetProperty property;
  String data;

  _WidgetTextPagetate(this.data, this.property);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(
          left: property.paddingLeft,
          top: property.paddingTop,
          right: property.paddingRight,
          bottom: property.paddingBottom),
      //margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: property.backColor,
        border:
        property.borderWidth == null || property.borderWidth < 1 ? null :
         Border.all(color: property.borderColor, width: property.borderWidth),

        boxShadow: [
          BoxShadow(
              color: property.shadowColor,
              offset: Offset(property.shadowOffsetX, property.shadowOffsetY),
              blurRadius: property.shadowBlurRadius,
              spreadRadius: property.shadowSpreadRadius
          )
        ],

        borderRadius: BorderRadius.only(
              topLeft: Radius.circular(property.borderRadiusTopLeft),
            topRight: Radius.circular(property.borderRadiusTopRight),
            bottomLeft: Radius.circular(property.borderRadiusBottomLeft),
            bottomRight: Radius.circular(property.borderRadiusBottomRight)),
      ),
      child: Row(
          mainAxisSize: property.fullLineDisp != null && property.fullLineDisp
              ? MainAxisSize.max
              : MainAxisSize.min,
          children: [

            Text(
              data,
              softWrap:true,
              style: TextStyle(
                color: property.textColor,
                fontSize: property.fontSize,
                fontWeight: _getFontWeightByInt(property.fontWeight),
                fontStyle: property.italic ? FontStyle.italic : null,
                letterSpacing: property.letterSpacing,

              ),
            ),
          ]),
    );
  }

  static FontWeight _getFontWeightByInt(int value) {
    if (value == null || !(value is int)) {
      return FontWeight.w400;
    } else if (value < 150) {
      return FontWeight.w100;
    } else if (value < 250) {
      return FontWeight.w200;
    } else if (value < 350) {
      return FontWeight.w300;
    } else if (value < 450) {
      return FontWeight.w400;
    } else if (value < 550) {
      return FontWeight.w500;
    } else if (value < 650) {
      return FontWeight.w600;
    } else if (value < 750) {
      return FontWeight.w700;
    } else if (value < 850) {
      return FontWeight.w800;
    } else {
      return FontWeight.w900;
    }
  }
}
