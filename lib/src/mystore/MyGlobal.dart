import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';

class MyGlobal {
  static List<TagInfo>? tagInfos = [];
  static List<OptionTemp>? optionTempInfos = [];
  static List<ItemDetail>? itemDetails = [];
  static ShopInfo? shopInfo = ShopInfo(shopTel: '', shopPicUrl: '', shopAddr: '', shopName: '', );

  static OptionTemp? getOptionTempById(int? id){
    if (optionTempInfos == null || id == null) {
      return null;
    }
    for (var i=0; i<optionTempInfos!.length; i++) {
      if (optionTempInfos![i].id == id){
        return optionTempInfos![i];
      }
    }
    return null;
  }

  static Future getTagInfos(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {

      GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Loading...");
    Api.getMyTags(context).then((result) {
      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      // ignore: null_aware_before_operator
      if (result.length > 0 ) {
        tagInfos = result[1];
      } else {
        tagInfos = [];
      }
    })
        //     .catchError((e) {
        //   print(e.toString());
        //   if (_scaffoldKey != null)
        //     GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        // })
        ;
  }

  static Future getOptionTemInfos(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {

      GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Loading...");
    Api.getMyOptionTemps(context).then((result) {
      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      optionTempInfos = result.length> 0  ? result[1] : [];
    });
  }

  static Future getShopItemInfo(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Loading...");
    Api.getMyShopItemInfo(context).then((result) {
      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      itemDetails = result.length > 0 ? result[1] : [];
    })
    //     .catchError((e) {
    //
    //   GlobalFun.showSnackBar(context,_scaffoldKey, null, e.toString());
    // })
    ;
  }

  static Future getShopInfo(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Loading...");
    Api.getMyShopInfo(context)?.then((result) {
      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      shopInfo = result.length > 0 ? result[1] : [];
    })
    //     .catchError((e) {
    //   GlobalFun.showSnackBar(context,_scaffoldKey,e, e.toString());
    // })
    ;
  }

  static Future init(BuildContext context,
      GlobalKey<ScaffoldState> _scaffoldKey, Function onLoaded) async {
    GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Loading...");
    int count = 0;
     const int API_COUNT = 4;
    await Api.getMyTags(context).then((result) {
      tagInfos = result.length> 0 ? result[1] : [];
      count++;
      if (count >= API_COUNT) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= API_COUNT) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    })
    //     .catchError((e) {
    //   GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    // })
    ;

    await Api.getMyShopItemInfo(context).then((result) {
      itemDetails = result.length > 0 ? result[1] : [];
      count++;
      if (count >= API_COUNT) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= API_COUNT) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    })
    //     .catchError((e) {
    //   GlobalFun.showSnackBar(context,_scaffoldKey, e, e.toString());
    // })
    ;

    await Api.getMyShopInfo(context)?.then((result) {
      shopInfo = result.length > 0 ? result[1] : [];
      count++;
      if (count >= API_COUNT) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= API_COUNT) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    })
    //     .catchError((e) {
    //   GlobalFun.showSnackBar(context,_scaffoldKey, e, e.toString());
    // })
    ;

    await Api.getMyOptionTemps(context).then((result) {
      optionTempInfos = result.length > 0 ? result[1] : [];
      count++;
      if (count >= API_COUNT) {
        onLoaded();
      }
    }).whenComplete(() {
      if (count >= API_COUNT) {
        GlobalFun.removeCurrentSnackBar(_scaffoldKey);
      }
    })
    //     .catchError((e) {
    //   GlobalFun.showSnackBar(context,_scaffoldKey, e, e.toString());
    // })
    ;

  }



  static void release() {
    tagInfos = null;
    itemDetails = null;
    shopInfo = null;
  }
}
