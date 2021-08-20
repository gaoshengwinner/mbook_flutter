import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/my_store/MyGlobal.dart';

class FBListTileInfo {
  double? height;
  CrossAxisAlignment? crossAxisAlignment;
  MainAxisAlignment? mainAxisAlignment;

  Widget? leftWidget;
  int? leftFlex;
  AlignmentGeometry? leftAlignment;
  GestureTapCallbackIndex? leftDoTop;
  EdgeInsetsGeometry? leftPadding;
  Widget? midWidget;
  int? midFlex;
  EdgeInsetsGeometry? midPadding;
  AlignmentGeometry? midAlignment;
  GestureTapCallbackIndex? midDoTop;
  Widget? mightWidget;
  int? rightFlex = 1;
  EdgeInsetsGeometry? rightPadding;
  AlignmentGeometry? rightAlignment;
  GestureTapCallbackIndex? rightDoTop;
  Widget? rightWidget;
}

typedef GestureTapCallbackIndex = void Function(int? index);

class FBListTile extends StatelessWidget {
  final GestureTapCallbackIndex? doTop;
  final EdgeInsetsGeometry? padding;

  final int? index;

  final FBListTileInfo? headerInfo;
  final FBListTileInfo? bodyInfo;
  final FBListTileInfo? bottomInfo;

  factory FBListTile.itemStyle(
      {required BuildContext context,
      required ItemDetail item,
      GestureTapCallbackIndex? doTop}) {
    String price = "";
    if (G.isNotNullOrEmpty(item.itemPrice)) {
      if (MyGlobal.shopInfo != null &&
          G.isNotNullOrEmpty(MyGlobal.shopInfo!.preCurrencyUnit)) {
        price = "${MyGlobal.shopInfo!.preCurrencyUnit}${item.itemPrice}";
      } else {
        price = "${item.itemPrice}${MyGlobal.shopInfo!.tailCurrencyUnit}";
      }
    }
    FBListTileInfo headerInfo = FBListTileInfo()
      ..leftFlex = 10
      ..midFlex = 70
      ..rightFlex = 20
      ..leftWidget = (G.isNotNullOrEmpty(item.itemNo)
          ? AutoSizeText("No.${item.itemNo}",
              maxLines: 1, style: Theme.of(context).textTheme.bodyText1)
          : null)
      ..rightAlignment = Alignment.centerRight
      ..rightPadding = EdgeInsets.only(right: 20)
      ..midWidget = AutoSizeText(G.ifNull(item.itemName, ""),
          maxLines: 1, style: Theme.of(context).textTheme.bodyText1)
      ..rightWidget = AutoSizeText(G.ifNull(price, ""),
          maxLines: 1, style: Theme.of(context).textTheme.bodyText1);

    FBListTileInfo bodyInfo = FBListTileInfo()
      ..leftFlex = G.isNullOrEmpty(item.itemMainPicUrl) ? null : 17
      ..midFlex = G.isNullOrEmpty(item.itemMainPicUrl) ? (17 + 76) : 76
      ..rightFlex = 7
      ..leftWidget = (G.isNotNullOrEmpty(item.itemMainPicUrl)
          ? Container(
              ///width: double.maxFinite,
              constraints: BoxConstraints.tightFor(width: double.maxFinite),
              child: MBImage(
                url: item.itemMainPicUrl,
                fit: BoxFit.fitWidth,
              ),
            )
          : null)
      ..crossAxisAlignment = CrossAxisAlignment.start
      ..mainAxisAlignment = MainAxisAlignment.start
      ..midPadding = EdgeInsets.only(left: 5)
      ..midWidget = AutoSizeText(G.ifNull(item.itemDescr, ""),
          maxLines: 3, style: Theme.of(context).textTheme.bodyText1)
      ..rightWidget = Icon(Icons.keyboard_arrow_right)
      ..leftDoTop = doTop
      ..midDoTop = doTop
      ..rightDoTop = doTop;

    EdgeInsetsGeometry? padding = EdgeInsets.only(top: 0, bottom: 5, left: 2);
    return FBListTile(
        headerInfo: headerInfo,
        bodyInfo: bodyInfo,
        doTop: doTop,
        padding: padding);

    // CrossAxisAlignment? crossAxisAlignment;
    // MainAxisAlignment? mainAxisAlignment;
  }

  FBListTile(
      {this.headerInfo,
      this.bodyInfo,
      this.bottomInfo,
      this.doTop,
      this.padding,
      this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (doTop != null) doTop!(index);
      },
      child: Container(

          width: double.maxFinite,
          height: 100,
          // alignment: Alignment.topLeft,
          padding: padding,
          color: Colors.white,
          child: Column(
            children: [
              if (headerInfo != null)
                Row(
                  children: <Widget>[
                    if (headerInfo!.leftFlex != null)
                      Expanded(
                        flex: headerInfo!.leftFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (headerInfo!.leftDoTop != null)
                              headerInfo!.leftDoTop!(index);
                          },
                          child: Container(
                            padding: headerInfo!.leftPadding,
                            alignment: headerInfo!.leftAlignment,
                            height: headerInfo!.height,
                            width: double.maxFinite,
                            child: headerInfo!.leftWidget,
                          ),
                        ),
                      ),
                    if (headerInfo!.midFlex != null)
                      Expanded(
                        flex: headerInfo!.midFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (headerInfo!.midDoTop != null)
                              headerInfo!.midDoTop!(index);
                          },
                          child: Container(
                            padding: headerInfo!.midPadding,
                            alignment: headerInfo!.midAlignment,
                            height: headerInfo!.height,
                            width: double.maxFinite,
                            child: headerInfo!.midWidget,
                          ),
                        ),
                      ),
                    if (headerInfo!.rightFlex != null)
                      Expanded(
                        flex: headerInfo!.rightFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (headerInfo!.rightDoTop != null)
                              headerInfo!.rightDoTop!(index);
                          },
                          child: Container(
                            padding: headerInfo!.rightPadding,
                            alignment: headerInfo!.rightAlignment,
                            height: headerInfo!.height,
                            width: double.maxFinite,
                            child: headerInfo!.rightWidget,
                          ),
                        ),
                      ),
                  ],
                ),
              if (bodyInfo != null)
                Row(
                  crossAxisAlignment: G.ifNull(
                      bodyInfo!.crossAxisAlignment, CrossAxisAlignment.center),
                  mainAxisAlignment: G.ifNull(
                      bodyInfo!.mainAxisAlignment, MainAxisAlignment.start),
                  children: <Widget>[
                    if (bodyInfo!.leftFlex != null)
                      Expanded(
                        flex: bodyInfo!.leftFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (bodyInfo!.leftDoTop != null)
                              bodyInfo!.leftDoTop!(index);
                          },
                          child: Container(
                            alignment: bodyInfo!.leftAlignment,
                            //height: bodyInfo!.height,
                            width: double.maxFinite,
                            child: bodyInfo!.leftWidget,
                          ),
                        ),
                      ),
                    if (bodyInfo!.midFlex != null)
                      Expanded(
                        flex: bodyInfo!.midFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (bodyInfo!.midDoTop != null)
                              bodyInfo!.midDoTop!(index);
                          },
                          child: Container(
                            padding: bodyInfo!.midPadding,
                            alignment: bodyInfo!.midAlignment,
                            height: bodyInfo!.height,
                            width: double.maxFinite,
                            child: bodyInfo!.midWidget,
                          ),
                        ),
                      ),
                    if (bodyInfo!.rightFlex != null)
                      Expanded(
                        flex: bodyInfo!.rightFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (bodyInfo!.rightDoTop != null)
                              bodyInfo!.rightDoTop!(index);
                          },
                          child: Container(
                            //color: Colors.red,
                            alignment: Alignment.centerRight,
                            // height: bodyInfo!.height,
                            width: double.maxFinite,
                            child: bodyInfo!.rightWidget,
                          ),
                        ),
                      ),
                  ],
                ),
              if (bottomInfo != null)
                Row(
                  children: <Widget>[
                    if (bottomInfo!.leftFlex != null)
                      Expanded(
                        flex: bottomInfo!.leftFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (bottomInfo!.leftDoTop != null)
                              bottomInfo!.leftDoTop!(index);
                          },
                          child: Container(
                            alignment: bottomInfo!.leftAlignment,
                            height: bottomInfo!.height,
                            width: double.maxFinite,
                            child: bottomInfo!.leftWidget,
                          ),
                        ),
                      ),
                    if (bottomInfo!.midFlex != null)
                      Expanded(
                        flex: bottomInfo!.midFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (bottomInfo!.midDoTop != null)
                              bottomInfo!.midDoTop!(index);
                          },
                          child: Container(
                            alignment: bottomInfo!.midAlignment,
                            height: bottomInfo!.height,
                            width: double.maxFinite,
                            child: bottomInfo!.midWidget,
                          ),
                        ),
                      ),
                    if (bottomInfo!.rightFlex != null)
                      Expanded(
                        flex: bottomInfo!.rightFlex!,
                        child: GestureDetector(
                          onTap: () {
                            if (bottomInfo!.rightDoTop != null)
                              bottomInfo!.rightDoTop!(index);
                          },
                          child: Container(
                            alignment: bottomInfo!.rightAlignment,
                            height: bottomInfo!.height,
                            width: double.maxFinite,
                            child: bottomInfo!.rightWidget,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          )),
    );
  }
}
