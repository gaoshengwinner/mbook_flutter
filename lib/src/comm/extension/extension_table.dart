import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/extension/extension_table_borders.dart';
import 'package:mbook_flutter/src/comm/model/FBTableTempProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBBoxDecorationProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableCellProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableProperty.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_editable_table.dart';

import 'extension_table_row.dart';

class FBTable extends Table {
  FBTable({
    Key? key,
    List<TableRow> children = const <TableRow>[],
    final Map<int, TableColumnWidth>? columnWidths,
    final TableColumnWidth defaultColumnWidth = const FlexColumnWidth(1.0),
    final TextDirection? textDirection,
    final TableBorder? border,
    final TableCellVerticalAlignment? defaultVerticalAlignment,
    final TextBaseline? textBaseline,
  }) : super(
            key: key,
            children: children,
            columnWidths: columnWidths,
            defaultColumnWidth: defaultColumnWidth,
            textDirection: textDirection,
            border: border,
            defaultVerticalAlignment:
                defaultVerticalAlignment ?? TableCellVerticalAlignment.top,
            textBaseline: textBaseline);

  factory FBTable.frame(
      {Key? key, FBTableProperty? property, List<TableRow>? children}) {
    return FBTable(
        key: key,
        children: children ?? [],
        textDirection: property?.textDirection,
        border: FBTableBorder.fromProperty(property?.border).toTableBorder(),
        defaultVerticalAlignment: property?.defaultVerticalAlignment,
        textBaseline: property?.textBaseline);
  }

  factory FBTable.addRowFromProperty(
      {Key? key, FBTableProperty? property, List<CellSet>? cellSet}) {
    return FBTable(
        key: key,
        children: [
          FBTableRow(
            decoration: BoxDecoration(),
              children: [
            if (cellSet != null)
              for (int i = 0; i < cellSet.length; i++)
                TableCell(
                    verticalAlignment: cellSet[i].property?.verticalAlignment,
                    child: Container(
                      // decoration: BoxDecoration(color: Colors.red[100]),
                      // margin: EdgeInsets.all(10),
                      // height: 80,
                      // constraints: BoxConstraints(
                      //   maxHeight: 100,
                      //   minHeight: 50,
                      // ),
                      child: FBTable(
                        // border: TableBorder(top:BorderSide(color: Colors.red),left:BorderSide(color: Colors.red), right: BorderSide(color: Colors.red),bottom:BorderSide(color: Colors.red) ),
                        children: [
                          if (cellSet[i].fbWidget != null)
                            for (int j = 0;
                                j < cellSet[i].fbWidget!.length;
                                j++)
                              TableRow(children: [
                                Container(
                                    alignment: Alignment.centerRight,
                                    width: double.maxFinite,
                                    child: Text(
                                        "${cellSet[i].fbWidget![j].value}"))
                              ]),
                          if (cellSet[i].fbWidget == null)
                            TableRow(children: [
                              Container(
                                  alignment: Alignment.centerRight,
                                  width: double.maxFinite,
                                  child: Text(
                                      "123"))
                            ]),
                        ],
                      ),
                    )),

            // ,Text("3"),
          ])
          //   if (cellProperties != null)
          //     for (int i = 0; i < cellProperties.length; i++)
          //       TableCell(
          //         verticalAlignment: cellProperties[i].verticalAlignment,
          //         child: Text("11"),
          //       )
          // ])
        ],
        columnWidths: getColumnWidths(cellSet: cellSet),
        textDirection: property?.textDirection,
        border: FBTableBorder.fromProperty(property?.border).toTableBorder(),
        defaultVerticalAlignment: property?.defaultVerticalAlignment,
        textBaseline: property?.textBaseline);
  }

  static Map<int, TableColumnWidth> getColumnWidths({List<CellSet>? cellSet}) {
    Map<int, TableColumnWidth> result = {};
    if (cellSet != null)
      for (int i = 0; i < cellSet.length; i++) {
        result[i] = FlexColumnWidth(cellSet[i].property?.width ?? 100);
      }
    return result;
  }
}
