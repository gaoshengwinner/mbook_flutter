import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/extension/extension_color.dart';
import 'package:mbook_flutter/src/comm/extension/extension_table.dart';
import 'package:mbook_flutter/src/comm/extension/extension_table_row.dart';
import 'package:mbook_flutter/src/comm/model/FBTableTempProperty.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBBorderSideProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBBoxDecorationProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBColorProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableBorderProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableCellProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableProperty.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';


class FBEditableTable extends StatefulWidget {
  final FBTableTempProperty? property;

  FBEditableTable({this.property});

  @override
  _FBEditableTableState createState() => _FBEditableTableState();
}

class _FBEditableTableState extends State<FBEditableTable> {
  @override
  Widget build(BuildContext context) {
    // FBTableTempProperty? _fBTableData = FBTableTempProperty(
    //     outSideProperty: OutSideProperty(
    //       //backColor: FBColor(Colors.purpleAccent[100]),
    //       topBorder: FBBorderSideProperty(
    //           width: 0,
    //           style: BorderStyle.solid,
    //           colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //       leftBorder: FBBorderSideProperty(
    //           width: 0,
    //           style: BorderStyle.solid,
    //           colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //       bottomBorder: FBBorderSideProperty(
    //           width: 0,
    //           style: BorderStyle.solid,
    //           colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //       rightBorder: FBBorderSideProperty(
    //           width: 0,
    //           style: BorderStyle.solid,
    //           colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //       borderRadiusTopLeft: 5,
    //     ),
    //     property: FBTableProperty(
    //       border: FBTableBorderProperty(
    //         // top: FBBorderSideProperty(
    //         //     width: 0,
    //         //     style: BorderStyle.solid,
    //         //     colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //         // left: FBBorderSideProperty(
    //         //     width: 0,
    //         //     style: BorderStyle.solid,
    //         //     colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //         // bottom: FBBorderSideProperty(
    //         //     width: 0,
    //         //     style: BorderStyle.solid,
    //         //     colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //         // right: FBBorderSideProperty(
    //         //     width: 0,
    //         //     style: BorderStyle.solid,
    //         //     colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //         horizontalInside: FBBorderSideProperty(
    //             width: 0,
    //             style: BorderStyle.solid,
    //             colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //         verticalInside: FBBorderSideProperty(
    //             width: 0,
    //             style: BorderStyle.solid,
    //             colorProperty: FBColorProperty.fromColor(color: Colors.green)),
    //       ),
    //     ),
    //     rowSet: [
    //       RowSet(cellSet: [
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [FBWidget(type: FBWidegetType.text, value: "hello")]),
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [FBWidget(type: FBWidegetType.text, value: "hello")]),
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [
    //               FBWidget(type: FBWidegetType.text, value: "hello"),
    //               FBWidget(type: FBWidegetType.text, value: "hello"),
    //               FBWidget(type: FBWidegetType.text, value: "hello")
    //             ])
    //       ]),
    //       RowSet(cellSet: [
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [FBWidget(type: FBWidegetType.text, value: "hello")]),
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [FBWidget(type: FBWidegetType.text, value: "hello")]),
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [
    //               FBWidget(type: FBWidegetType.text, value: "hello"),
    //               FBWidget(type: FBWidegetType.text, value: "hello"),
    //               FBWidget(type: FBWidegetType.text, value: "hello")
    //             ])
    //       ]),
    //       RowSet(cellSet: [
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [FBWidget(type: FBWidegetType.text, value: "hello")]),
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [FBWidget(type: FBWidegetType.text, value: "hello")]),
    //         CellSet(
    //             property: FBTableCellProperty(
    //               width: 100,
    //             ),
    //             fbWidget: [
    //               FBWidget(type: FBWidegetType.text, value: "hello"),
    //               FBWidget(type: FBWidegetType.text, value: "hello"),
    //               FBWidget(type: FBWidegetType.text, value: "hello")
    //             ])
    //       ]),
    //     ]);
    // return WidgetBaseWidget(
    //   property: widget.property.outSide,
    //   child: FBTable.frame(property: widget.property.property, children: [
    //     if (widget.property.rowSet != null)
    //       for (int i = 0; i < widget.property.rowSet!.length; i++)
    //         FBTableRow.fromProperty(
    //           property: widget.property.rowSet?[i].property,
    //           children: [
    //             FBTable.addRowFromProperty(
    //               property: widget.property.property,
    //               cellSet: widget.property.rowSet?[i].cellSet,
    //               // ],
    //             )
    //           ],
    //         )
    //   ]),
    // );


    return
      WidgetBaseWidget(
      property: widget.property!.outSide,
      child: Table()
        ,
    );
  }

// Table createTableRow({}){
//
// }
}
