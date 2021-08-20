import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/properties/FBBoxDecorationProperty.dart';

class FBTableRow extends TableRow {
  FBTableRow({LocalKey? key, Decoration? decoration, List<Widget>? children})
      : super(key: key, decoration: decoration, children: children);

  factory FBTableRow.fromProperty(
      {LocalKey? key,
      FBBoxDecorationProperty? property,
      List<Widget>? children}) {
    return FBTableRow(
        key: key, decoration: property?.toBoxDecoration(), children: children);
  }
}
