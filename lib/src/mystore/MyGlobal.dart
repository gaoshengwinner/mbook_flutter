import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';

class MyGlobal {
  static List<TagInfo> tagInfos = [];
  static List<ItemDetail> itemDetails = [];
  static ShopInfo shopInfo = ShopInfo("", "", "", "");

  static Future getTagInfos(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    if (_scaffoldKey != null)
      GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
    Api.getMyTags(context).then((result) {
      if (_scaffoldKey != null) GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      tagInfos = result[1];
    })
        //     .catchError((e) {
        //   print(e.toString());
        //   if (_scaffoldKey != null)
        //     GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        // })
        ;
  }

  static Future getShopItemInfo(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
    Api.getMyShopItemInfo(context).then((result) {
      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      itemDetails = result[1];
    }).catchError((e) {
      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    });
  }

  static Future getShopInfo(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
    Api.getMyShopInfo(context).then((result) {
      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      shopInfo = result[1];
    }).catchError((e) {
      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    });
  }

  static Future init(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey, Function onLoaded) async {
    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
    int count = 0;
    await Api.getMyTags(context).then((result) {
      tagInfos = result[1];
      count++;
      if (count >= 3) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= 3) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    }).catchError((e) {
      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    });

    await Api.getMyShopItemInfo(context).then((result) {
      itemDetails = result[1];
      count++;
      if (count >= 3) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= 3) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    }).catchError((e) {
      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    });

    await Api.getMyShopInfo(context).then((result) {
      shopInfo = result[1];
      count++;
      if (count >= 3) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= 3) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    }).catchError((e) {
      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    });
  }

  static void release() {
    tagInfos = null;
    itemDetails = null;
    shopInfo = null;
  }
}
