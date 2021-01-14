import 'package:flutter/material.dart';

class TextWidgetProperty {
  bool fullLineDisp = false;
  Color textColor = Colors.black;
  Color backColor = Colors.white;
  double fontSize = 14;
  int fontWeight = 400;
  bool italic = false;
  double letterSpacing = 0;
  double paddingLeft = 0;
  double paddingTop = 0;
  double paddingRight = 0;
  double paddingBottom = 0;

  double borderWidth = 0;
  Color borderColor = const Color(0xFF000000);
  double borderRadiusTopLeft = 0;
  double borderRadiusTopRight = 0;
  double borderRadiusBottomLeft = 0;
  double borderRadiusBottomRight = 0;

  Color shadowColor = Color(0xFF000000);
  double shadowOffsetX = 0.0;
  double shadowOffsetY = 0.0;
  double shadowBlurRadius = 0.0;
  double shadowSpreadRadius = 0.0;


  TextWidgetProperty({
    backColor: Color,
    textColor: Color,
    fullLineDisp: bool,
    fontSize: double,
    fontWeight: int,
    italic: bool,
    letterSpacing: double,
    paddingLeft: double,
    paddingTop: double,
    paddingRight: double,
    paddingBottom: double,
  }) {
    if (backColor != null && backColor is Color) {
      this.backColor = backColor;
    }
    if (textColor != null && textColor is Color) {
      this.textColor = textColor;
    }

    if (fullLineDisp != null && fullLineDisp is bool) {
      this.fullLineDisp = fullLineDisp;
    }
    if (fontSize != null && fontSize is double) {
      this.fontSize = fontSize;
    }
    if (fontWeight != null && fontWeight is int) {
      this.fontWeight = fontWeight;
    }
    if (italic != null && italic is bool) {
      this.italic = italic;
    }
    if (letterSpacing != null && letterSpacing is double) {
      this.letterSpacing = letterSpacing;
    }
  }
}
