import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/my_store/MyGlobal.dart';

class FB3RowTable extends StatelessWidget {
  final FBTableRowInfo? headerRow;
  final FBTableRowInfo? middleRow;
  final FBTableRowInfo? bottomRow;

  factory FB3RowTable.itemTitle(
      {required BuildContext context, required ItemDetail itemDetail}) {
    final double middleLeftFlex = 2;
    final double middleMidFlex = 7.5;
    final double middleRightFlex = 10 - middleLeftFlex - middleMidFlex;
    FBTableRowInfo headerRow = FBTableRowInfo(rowsInfo: [
      FBTableCellInfo(
          width: 8,
          child: Container(
              padding: EdgeInsets.only(left: 2),
              child: Text(G.ifNullElse(
                  itemDetail.itemNo, "", "No.${itemDetail.itemNo}")))),
      FBTableCellInfo(
          width: 2,
          child: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: Text(
                  "${itemDetail.itemPrice} ${MyGlobal.shopInfo!.tailCurrencyUnit}"))),
    ]);

    FBTableRowInfo middleRow = FBTableRowInfo(rowsInfo: [
      if (G.isNotNullOrEmpty(itemDetail.itemMainPicUrl))
        FBTableCellInfo(
            width: middleLeftFlex,
            child: Container(
              ///width: double.maxFinite,
              constraints: BoxConstraints.tightFor(width: double.maxFinite),
              child: MBImage(
                url: itemDetail.itemMainPicUrl,
                fit: BoxFit.fitWidth,
              ),
            )),
      FBTableCellInfo(
          width: G.isNotNullOrEmpty(itemDetail.itemMainPicUrl)
              ? middleMidFlex
              : middleMidFlex + middleLeftFlex,
          child: Container(
            ///width: double.maxFinite,
            constraints: BoxConstraints.tightFor(width: double.maxFinite),
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      G.ifNull(itemDetail.itemName, ""),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      G.ifNull(itemDetail.itemDescr, ""),
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black54,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      FBTableCellInfo(
          width: middleRightFlex,
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            ///width: double.maxFinite,
            constraints: BoxConstraints.tightFor(width: double.maxFinite),
            child: Icon(Icons.keyboard_arrow_right),
          )),
    ]);

    return FB3RowTable(headerRow: headerRow, middleRow: middleRow);
  }

  FB3RowTable({this.headerRow, this.middleRow, this.bottomRow}) {
    assert(
        this.headerRow != null ||
            this.middleRow != null ||
            this.bottomRow != null,
        "At least one should not be null.");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        child: Table(
          children: [
            if (headerRow != null)
              TableRow(children: [
                subTable(context: context, tableInfo: headerRow!)
              ]),
            if (middleRow != null)
              TableRow(children: [
                subTable(context: context, tableInfo: middleRow!)
              ]),
            if (bottomRow != null)
              TableRow(children: [
                subTable(context: context, tableInfo: bottomRow!)
              ]),
          ],
        ));
  }

  Table subTable(
      {required BuildContext context, required FBTableRowInfo tableInfo}) {
    return Table(
      columnWidths: tableInfo.columnWidths,
      children: [
        TableRow(children: [
          if (tableInfo.rowsInfo != null)
            for (var row in tableInfo.rowsInfo!)
              TableCell(
                verticalAlignment: row.verticalAlignment,
                child: row.child,
              )
        ])
      ],
    );
  }
}

class FBTableRowInfo {

  final List<FBTableCellInfo>? rowsInfo;
  FBTableRowInfoProperty? property;
  FBTableRowInfo({this.property, this.rowsInfo});

  Map<int, TableColumnWidth> get columnWidths {
    Map<int, TableColumnWidth> result = {};
    if (rowsInfo != null)
      for (int i = 0; i < rowsInfo!.length; i++) {
        result[i] = FlexColumnWidth(rowsInfo![i].width);
      }
    return result;
  }
}

class FBTableRowInfoProperty{
  final TextDirection? textDirection;
  final TableBorder? border;
  final TextBaseline? textBaseline;
  FBTableRowInfoProperty({this.textDirection, this.textBaseline, this.border});
}

class FBTableCellInfo {
  final double width;
  final TableCellVerticalAlignment? verticalAlignment;
  Widget child;

  FBTableCellInfo(
      {required this.width, this.verticalAlignment, required this.child});
}
