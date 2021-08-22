import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/extension/extension_text_align.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';

class WidgetBaseWidget extends StatelessWidget {
  final TextWidgetProperty property;
  final Widget? child;

  WidgetBaseWidget({required this.property, this.child});

  Widget build(BuildContext context) {
    // BuildContext context, TextWidgetProperty property, {Widget? child}) {
    return Container(
      alignment: FBAlignment.map()[property.backalignment],
      width: property.getRealWidth(),
      height: property.getRealHeight(),
      child: Container(
        margin: EdgeInsets.only(
            left: property.marginLeft,
            right: property.marginRight,
            top: property.marginTop,
            bottom: property.marginBottom),
        width: property.getRealWidth(),
        height: property.getRealHeight(),
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
          border: property.borderWidth == null || property.borderWidth == 0
              ? null
              : Border.all(
              color: property.borderColor, width: property.borderWidth!),
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
        constraints: BoxConstraints(
          minHeight: property.getRealMinHeight() ?? 0.0,
          minWidth: property.getRealMinWidth() ?? 0.0,
          maxWidth: property.getRealMaxWidth() ?? double.infinity,
          maxHeight: property.getRealMaxHeight() ?? double.infinity,
        ),
        child: child,
      ),
    );
  }

  static FontWeight getFontWeightByInt(int value) {
    if (value < 150) {
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

class WidgetTextWidget extends StatelessWidget {
  final TextWidgetProperty? property;
  final String? data;

  WidgetTextWidget({this.property, this.data});

  @override
  Widget build(BuildContext context) {
    TextWidgetProperty _property = G.ifNull(property, new TextWidgetProperty());
    String _data = G.ifNull(data, "");
    return WidgetBaseWidget(
        property: _property,
        child: Text(
          _data,
          softWrap: true,
          textAlign: FBTextAlign.getByString(_property.textTextAlign),
          style: TextStyle(
            color: _property.textColor,
            fontSize: _property.fontSize,
            fontWeight:
                WidgetBaseWidget.getFontWeightByInt(_property.fontWeight),
            fontStyle: _property.italic ? FontStyle.italic : null,
            letterSpacing: _property.letterSpacing,
          ),
        ));
  }
}

class WidgetContainerWidget extends StatelessWidget {
  final TextWidgetProperty? property;
  final Widget? child;

  WidgetContainerWidget({this.property, this.child});

  @override
  Widget build(BuildContext context) {
    TextWidgetProperty _property = G.ifNull(property, new TextWidgetProperty());
    Widget _widget = G.ifNull(child, Text(""));
    return WidgetBaseWidget(property: _property, child: _widget);
  }
}
