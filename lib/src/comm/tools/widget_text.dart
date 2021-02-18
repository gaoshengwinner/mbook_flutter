import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/extension/extension.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';

class WidgetBasePage {
  static Widget build(
      BuildContext context, TextWidgetProperty property, {Widget child}) {
    return Container(
      alignment: FBAlignment.map()[property.backalignment],
      color: Colors.transparent,
      width: property.getRealMinWidth(),
      height: property.getRealMinHeight(),
      child: Container(
        margin: EdgeInsets.only(
            left: property.marginLeft,
            right: property.marginRight,
            top: property.marginTop,
            bottom: property.marginBottom),
        width: property.getRealMinWidth(),
        height: property.getRealMinHeight(),
        //property.minHeight,
        alignment: FBAlignment.map()[property.alignment],
        padding: EdgeInsets.only(
            left: property.paddingLeft,
            top: property.paddingTop,
            right: property.paddingRight,
            bottom: property.paddingBottom),
        //margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: property.backColor,
          border: property.borderWidth == null || property.borderWidth < 1
              ? null
              : Border.all(
                  color: property.borderColor, width: property.borderWidth),
          boxShadow: [
            BoxShadow(
                color:
                    property.shadowOffsetX == 0 && property.shadowOffsetY == 0
                        ? Colors.transparent
                        : property.shadowColor,
                offset: Offset(property.shadowOffsetX, property.shadowOffsetY),
                blurRadius: property.shadowBlurRadius,
                spreadRadius: property.shadowSpreadRadius)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(property.borderRadiusTopLeft),
              topRight: Radius.circular(property.borderRadiusTopRight),
              bottomLeft: Radius.circular(property.borderRadiusBottomLeft),
              bottomRight: Radius.circular(property.borderRadiusBottomRight)),
          // image: DecorationImage(
          //     image: NetworkImage("http://pic.qianye88.com/4kmeinv2989f765-5bdd-3cee-8482-574732cc2af2.jpg"), fit: BoxFit.fitWidth),
        ),
        // constraints: BoxConstraints(
        //   minHeight: property.minHeight,
        //   minWidth: property.minWidth,
        //   maxWidth: property.maxWidth < 10 ? double.infinity : property.maxWidth,
        //   maxHeight:
        //       property.maxHeight < 10 ? double.infinity : property.maxHeight,
        // ),
        child: child,
      ),
    );
  }

  static FontWeight getFontWeightByInt(int value) {
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

class WidgetTextPage extends StatelessWidget {
  TextWidgetProperty property;
  String data;

  WidgetTextPage({this.property, this.data});

  @override
  Widget build(BuildContext context) {
    return WidgetBasePage.build(context, property, child: Text(
      data,
      softWrap: true,
      textAlign: FBTextAlign.getByString(property.textTextAlign),
      style: TextStyle(
        color: property.textColor,
        fontSize: property.fontSize,
        fontWeight: WidgetBasePage.getFontWeightByInt(property.fontWeight),
        fontStyle: property.italic ? FontStyle.italic : null,
        letterSpacing: property.letterSpacing,
      ),
    ));
  }
}
