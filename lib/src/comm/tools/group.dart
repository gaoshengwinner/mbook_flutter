import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item.dart';

const Color mediumGrayColor = Color(0xFFC7C7CC);
const Color itemPressedColor = Colors.white;//Colors.red;//Color(0xFFD9D9D9);
const Color borderColor = Color(0xFFBCBBC1);
const Color backgroundGray = Color(0xFFEFEFF4);
const Color groupSubtitle = Color(0xFF777777);

class SettingsGroup extends StatelessWidget {
  const SettingsGroup(
      {required this.items,

       this.header,
      this.footer,
    }
  );

  final List<Widget> items;

  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    List<Widget> dividedItems = items;
    if (items.length > 1) {
      dividedItems = dividedItems.map<Widget>((Widget item) {
        if (dividedItems.last == item) {
          return item;
        } else {
          final leftPadding = item is SettingsItem
              ? item.icon == null
                  ? 15.0
                  : 58.0
              : 0.0;
          // Add inner dividers.
          return Stack(
            children: <Widget>[
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: leftPadding,
                child: new Container(
                  color: borderColor,
                  height: 1,
                ),
              ),
              item,
            ],
          );
        }
      }).toList();
    }

    final List<Widget> columnChildren = [];

    if (header != null) {
      columnChildren.add(
        DefaultTextStyle(
          style: TextStyle(
            color: CupertinoColors.inactiveGray,
            fontSize: 13.5,
            letterSpacing: -0.5,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 6.0,
            ),
            child: header,
          ),
        )
      );
    }

    columnChildren.add(
      Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border(
            top: const BorderSide(
              color: borderColor,
              width: 0.0,
            ),
            bottom: const BorderSide(
              color: borderColor,
              width: 0.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: dividedItems,
        ),
      ),
    );

    if (footer != null) {
      columnChildren.add(
        DefaultTextStyle(
          style: TextStyle(
            color: groupSubtitle,
            fontSize: 13.0,
            letterSpacing: -0.08,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 7.5,
            ),
            child: footer,
          ),
        )
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: header == null ? 35.0 : 22.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}
