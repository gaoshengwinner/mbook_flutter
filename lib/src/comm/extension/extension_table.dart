import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/extension/extension_table_borders.dart';
import 'package:mbook_flutter/src/comm/model/FBTableTempProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableProperty.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';

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
      {Key? key,
      FBTableProperty? property,
      List<TableRow>? children,
      bool? isDesign}) {
    Map<int, TableColumnWidth> result = {};

    return FBTable(
        key: key,
        children: children ?? [],
        textDirection: property?.textDirection,
        border: FBTableBorder.fromProperty(property?.border).toTableBorder(),
        columnWidths: result,
        defaultVerticalAlignment: property?.defaultVerticalAlignment,
        textBaseline: property?.textBaseline);
  }

  static TableBorder? designBorder() {
    Color color = Colors.black12;
    double width = 1;
    return TableBorder(
      top: BorderSide(width: width, color: color),
      right: BorderSide(width: width, color: color),
      left: BorderSide(width: width, color: color),
      bottom: BorderSide(width: width, color: color),
      horizontalInside: BorderSide(width: width, color: color),
      verticalInside: BorderSide(width: 1, color: color),
    );
  }

  static TableRow addRowFromProperty(
      {Key? key,
      FBTableProperty? property,
      List<CellSet>? cellSet,
      bool? isDesign,
      Function? onRowDelete}) {
    return TableRow(children: [
      FBTable(
          key: key,
          children: [
            FBTableRow(decoration: BoxDecoration(), children: [
              if (cellSet == null)
                TableCell(
                  child: Text("Todo"),
                ),
              if (cellSet != null)
                for (int i = 0; i < cellSet.length; i++)
                  TableCell(
                      verticalAlignment: cellSet[i].property.verticalAlignment,
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
                            for (int j = 0; j < cellSet[i].fbWidget.length; j++)
                              TableRow(children: [
                                Container(
                                  width: double.maxFinite,
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      child: WidgetTextWidget(
                                        property:
                                            cellSet[i].fbWidget[j].property,
                                        data:
                                            cellSet[i].fbWidget[j].value ?? "",
                                      )),
                                )
                              ]),
                          ],
                        ),
                      )),
              if (isDesign ?? false)
                Row(children:[
                  GestureDetector(
                    child:
                    SizedBox(width: 50, height: 50, child: Icon(Icons.indeterminate_check_box, size: 50,)),
                    onTap: () {
                      if (onRowDelete != null) onRowDelete();
                    },
                  ),
                GestureDetector(
                  child:
                      SizedBox(width: 50, height: 50, child: Icon(Icons.indeterminate_check_box, size: 50,)),
                  onTap: () {
                    if (onRowDelete != null) onRowDelete();
                  },
                )]
                )
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
          columnWidths: getColumnWidths(cellSet: cellSet, isDesign: isDesign),
          textDirection: property?.textDirection,
          border: (isDesign ?? false)
              ? designBorder()
              : FBTableBorder.fromProperty(property?.border).toTableBorder(),
          defaultVerticalAlignment: property?.defaultVerticalAlignment,
          textBaseline: property?.textBaseline)
    ]);
  }

  static Map<int, TableColumnWidth> getColumnWidths(
      {List<CellSet>? cellSet, bool? isDesign}) {
    Map<int, TableColumnWidth> result = {};
    if (cellSet != null)
      for (int i = 0; i < cellSet.length; i++) {
        result[i] = FlexColumnWidth(cellSet[i].property.width);
      }
    if (isDesign ?? false) {
      result[result.length] = FlexColumnWidth(10);
    }
    return result;
  }
}
