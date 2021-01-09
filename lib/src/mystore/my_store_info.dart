import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/widgets/raised_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyStoreInfoPage extends StatefulWidget {
  ShopInfo _shopInfo = ShopInfo("", "", "", "");

  MyStoreInfoPage(ShopInfo shopInfo) {
    if (shopInfo == null) {
      _shopInfo = ShopInfo("", "", "", "");
    } else {
      _shopInfo = shopInfo;
    }
  }

  _MyStoreInfoPageState createState() => _MyStoreInfoPageState(_shopInfo);
}

class _MyStoreInfoPageState extends State<MyStoreInfoPage> {
  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  ShopInfo _shopInfo = ShopInfo("", "", "", "");

  _MyStoreInfoPageState(this._shopInfo);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Api.getMyShopInfo(context).then((result) {
    //   setState(() {
    //     if (result[0] == 200){
    //       _shopInfo = result[1];
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarView.appbar("Store base info", true),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 点击空白页面关闭键盘
              FocusScope.of(context).requestFocus(_blankNode);
            },
            child:
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        maxLength: 128,
                        inputFormatters: [
                          // 不能输入回车符
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        decoration: InputDecoration(
                            counterText: '',
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: G.appBaseColor[0])),
                            labelText: 'Store name',
                            labelStyle: TextStyle(
                                color: G.appBaseColor[0], fontSize: 26)),
                        initialValue: _shopInfo.shopName,
                        onChanged: (value) {
                          _shopInfo.shopName = value;
                        },
                      ),
                      TextFormField(
                        maxLines: 1,
                        maxLength: 11,
                        inputFormatters: [
                          // 不能输入回车符
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        decoration: InputDecoration(
                            counterText: '',
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: G.appBaseColor[0])),
                            labelText: 'Tel',
                            labelStyle: TextStyle(
                                color: G.appBaseColor[0], fontSize: 26)),
                        initialValue: _shopInfo.shopTel,
                        onChanged: (value) {
                          _shopInfo.shopTel = value;
                        },
                      ),
                      TextFormField(
                        maxLines: 1,
                        maxLength: 526,
                        inputFormatters: [
                          // 不能输入回车符
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        decoration: InputDecoration(
                            counterText: '',
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: G.appBaseColor[0])),
                            labelText: 'Locate',
                            labelStyle: TextStyle(
                                color: G.appBaseColor[0], fontSize: 26)),
                        initialValue: _shopInfo.shopAddr,
                        onChanged: (value) {
                          _shopInfo.shopAddr = value;
                        },
                      ),
                      // Row(children: [
                      TextFormField(
                        maxLines: 1,
                        maxLength: 255,
                        inputFormatters: [
                          // 不能输入回车符
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        decoration: InputDecoration(
                            counterText: '',
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: G.appBaseColor[0])),
                            labelText: 'Image',
                            labelStyle: TextStyle(
                                color: G.appBaseColor[0], fontSize: 26)),
                        initialValue: _shopInfo.shopPicUrl,
                        onChanged: (value) {
                          setState(() {
                            _shopInfo.shopPicUrl = value;
                          });
                        },
                      ),
                      //   IconButton(icon: Icon(Icons.picture_in_picture), onPressed: null)
                      //Icon(Icons.picture_in_picture)
                      // ]),
                      if (_shopInfo.shopPicUrl != null &&
                          !_shopInfo.shopPicUrl.isEmpty)
                        Image.network(_shopInfo.shopPicUrl),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: FBButton.build(
                              context, 0.6.sw, "Save", Icons.save, () {
                            GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
                            Api.saveMyShopInfo(context, _shopInfo)
                                .whenComplete(() {
                              GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                            }).catchError((e){
                              GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                            });
                          })),
                    ])))));
  }
}
