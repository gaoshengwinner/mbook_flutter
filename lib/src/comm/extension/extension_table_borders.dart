import 'package:flutter/rendering.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableBorderProperty.dart';

class FBTableBorder extends TableBorder {
  FBTableBorder(
      {BorderSide? top,
      BorderSide? right,
      BorderSide? bottom,
      BorderSide? left,
      BorderSide? horizontalInside,
      BorderSide? verticalInside})
      : super(
          top: top ?? BorderSide.none,
          right: right ?? BorderSide.none,
          bottom: bottom ?? BorderSide.none,
          left: left ?? BorderSide.none,
          horizontalInside: horizontalInside ?? BorderSide.none,
          verticalInside: verticalInside ?? BorderSide.none,
        );

  factory FBTableBorder.fromProperty(FBTableBorderProperty? property) {
    return FBTableBorder(
        top: property?.top?.toBorderSide(),
        right: property?.right?.toBorderSide(),
        bottom: property?.bottom?.toBorderSide(),
        left: property?.left?.toBorderSide(),
        horizontalInside: property?.horizontalInside?.toBorderSide(),
        verticalInside: property?.verticalInside?.toBorderSide());
  }

  TableBorder toTableBorder() {
    return TableBorder(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        horizontalInside: horizontalInside,
        verticalInside: verticalInside);
  }
}
