import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FBButton {
  static build(BuildContext context, double width, String title, IconData icon,
      Function doTap) {
    return new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10),
        child: SizedBox(
          width: width, //0.6.sw,
          height: 45,
          child: ElevatedButton.icon(
            onPressed: () {
              if (doTap != null) doTap();
            },
            style: ElevatedButton.styleFrom(
                primary: G.appBaseColor[0],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.5)))),
            label: Text(
              title, //S.of(context).home_scan_button_title,
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(icon /**Icons.qr_code_scanner**/, color: Colors.white),
            //textColor: Colors.black,
            //splashColor: Colors.deepOrange,
            //color: G.appBaseColor[0],
          ),
          // RaisedButton.icon(
          //   onPressed: () {
          //     if (doTap != null) doTap();
          //   },
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(22.5))),
          //   label: Text(
          //     title, //S.of(context).home_scan_button_title,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   icon: Icon(icon /**Icons.qr_code_scanner**/, color: Colors.white),
          //   textColor: Colors.black,
          //   //splashColor: Colors.deepOrange,
          //   color: G.appBaseColor[0],
          // ),
        ));
  }
}
