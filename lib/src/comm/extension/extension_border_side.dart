import 'package:flutter/painting.dart';
import 'package:mbook_flutter/src/comm/properties/FBBorderSideProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBColorProperty.dart';

class FBBorderSide extends BorderSide {
  FBBorderSide({Color? color, double? width, BorderStyle? style})
      : super(
            color: color ?? Color(0xFF000000),
            width: width ?? 1.0,
            style: style ?? BorderStyle.solid);

  factory FBBorderSide.fromProperty({FBBorderSideProperty? property}) {
    return FBBorderSide(
        color: property?.colorProperty?.toColor(),
        width: property?.width,
        style: property?.style);
  }
}
