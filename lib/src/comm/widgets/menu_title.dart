import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuTitle extends StatelessWidget {
  final IconData? icon;
  final String title;
  final GestureTapCallback? doTop;
  final bool isFirst;
  final bool isBottom;

  MenuTitle(
      {this.icon,
      required this.title,
      this.doTop,
      this.isFirst = false,
      this.isBottom = false});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: doTop,
      child: Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.only(left: 8, right: 8),
          color: Colors.white,
          child: Column(
            children: [
              if (isFirst)
                Container(
                  height: 10,
                  width: 1.sw,
                ),
              Row(
                children: <Widget>[
                  Icon(icon),
                  SizedBox(width: 10),
                  Text(title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.0,
                      )),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
              if (!isBottom)
                Divider(
                  indent: 32.0,
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
              if (isBottom)
                Container(
                  height: 10,
                  width: 1.sw,
                )
            ],
          )),
    );
  }
}
