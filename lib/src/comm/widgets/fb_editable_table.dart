import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/extension/extension_table.dart';
import 'package:mbook_flutter/src/comm/model/FBTableTempProperty.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';

class FBEditableTable extends StatefulWidget {
  final FBTableTempProperty property;
  final bool isDesign;

  FBEditableTable({required this.property, this.isDesign = false});

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

    // double? tableHeight = widget.property.outSide.height != null
    //     ? widget.property.outSide.getRealHeight()
    //     : widget.property.outSide.getRealMinHeight();
    return WidgetBaseWidget(
      property: widget.property.outSide,
      child: FBTable.frame(isDesign: widget.isDesign, children: [
        for (int outRow = 0;
            outRow < (widget.property.rowSet?.length ?? 0);
            outRow++)
          FBTable.addRowFromProperty(isDesign: widget.isDesign,
              onRowDelete:()
              {
                setState(() {
                  widget.property.rowSet!.removeAt(outRow);
                });
              },


              cellSet: [
            for (int cellIndex = 0;
                cellIndex <
                    (widget.property.rowSet![outRow].cellSet?.length ?? 0);
                cellIndex++)
              CellSet(
                  property: widget
                      .property.rowSet![outRow].cellSet![cellIndex].property,
                  fbWidget: widget
                      .property.rowSet![outRow].cellSet![cellIndex].fbWidget),
          ]),
        // FBTable.addRowFromProperty(property: FBTableProperty(), cellSet: [
        //   CellSet(
        //       property: FBTableCellProperty(
        //           verticalAlignment: TableCellVerticalAlignment.top,
        //           width: 10),
        //       fbWidget: [FBWidget(value: "123123 adf ddf asf asf sadf sd dfasd f fdsf asf sadf ds dadf ds dfad  afddsfd dfasd ")]),
        //   CellSet(
        //       property: FBTableCellProperty(
        //           verticalAlignment: TableCellVerticalAlignment.bottom,
        //           width: 40),
        //       fbWidget: [FBWidget(value: "123123 dfas  dfa sd dfds ds dsaf dfsdf afd dsf daf das afd dsa dfaf adfds df asf asdf sfsd dsfdsaf dsfsd fasdds fsdaf dsaf dasf asdf df asd")]),
        // ]),
      ]),
    );
  }

// Table createTableRow({}){
//
// }
}
