import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';

class MyStoreInfoPage extends StatefulWidget {
  final ShopInfo _shopInfo;

  MyStoreInfoPage(this._shopInfo);
  _MyStoreInfoPageState createState() => _MyStoreInfoPageState();
}

class _MyStoreInfoPageState extends State<MyStoreInfoPage> {
  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();

String shopPicUrl;
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
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFFEFEFF4),
            //margin: EdgeInsets.only(left: 20, right: 20),
            child: ListView(children: [
              GlobalFun.fbInputBox(context, "Store name", widget._shopInfo.shopName,
                  (value) {
                setState(() {
                  widget._shopInfo.shopName = value;
                });
              }, width: 0.9.sw),
              GlobalFun.fbInputBox(context, "Tel", widget._shopInfo.shopTel, (value) {
                setState(() {
                  widget._shopInfo.shopTel = value;
                });
              }, width: 0.9.sw),
              GlobalFun.fbInputBox(context, "Locate", widget._shopInfo.shopAddr,
                  (value) {
                setState(() {
                  widget._shopInfo.shopAddr = value;
                });
              }, width: 0.9.sw),
              GlobalFun.fbInputBox(context, "Image", widget._shopInfo.shopPicUrl,
                      (value) {
                    setState(() {
                      widget._shopInfo.shopPicUrl = value;
                      shopPicUrl = value;
                    });
                  },
                  width: 0.9.sw,
                  valueWidget: Row(children: [
                    //MBImage(url: widget._shopInfo.shopPicUrl, defImagePath: shopPicUrl,),
                    Flexible(child: new MBImage(url: widget._shopInfo.shopPicUrl, ))
                  ])),

            ]),

            // Form(
            //     child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //       TextFormField(
            //         maxLines: 1,
            //         maxLength: 128,
            //         inputFormatters: [
            //           // 不能输入回车符
            //           FilteringTextInputFormatter.singleLineFormatter,
            //         ],
            //         decoration: InputDecoration(
            //             counterText: '',
            //             focusedBorder: UnderlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: G.appBaseColor[0])),
            //             labelText: 'Store name',
            //             labelStyle: TextStyle(
            //                 color: G.appBaseColor[0], fontSize: 26)),
            //         initialValue: _shopInfo.shopName,
            //         onChanged: (value) {
            //           _shopInfo.shopName = value;
            //         },
            //       ),
            //       TextFormField(
            //         maxLines: 1,
            //         maxLength: 11,
            //         inputFormatters: [
            //           // 不能输入回车符
            //           FilteringTextInputFormatter.singleLineFormatter,
            //         ],
            //         decoration: InputDecoration(
            //             counterText: '',
            //             focusedBorder: UnderlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: G.appBaseColor[0])),
            //             labelText: 'Tel',
            //             labelStyle: TextStyle(
            //                 color: G.appBaseColor[0], fontSize: 26)),
            //         initialValue: _shopInfo.shopTel,
            //         onChanged: (value) {
            //           _shopInfo.shopTel = value;
            //         },
            //       ),
            //       TextFormField(
            //         maxLines: 1,
            //         maxLength: 526,
            //         inputFormatters: [
            //           // 不能输入回车符
            //           FilteringTextInputFormatter.singleLineFormatter,
            //         ],
            //         decoration: InputDecoration(
            //             counterText: '',
            //             focusedBorder: UnderlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: G.appBaseColor[0])),
            //             labelText: 'Locate',
            //             labelStyle: TextStyle(
            //                 color: G.appBaseColor[0], fontSize: 26)),
            //         initialValue: _shopInfo.shopAddr,
            //         onChanged: (value) {
            //           _shopInfo.shopAddr = value;
            //         },
            //       ),
            //       // Row(children: [
            //       TextFormField(
            //         maxLines: 1,
            //         maxLength: 255,
            //         inputFormatters: [
            //           // 不能输入回车符
            //           FilteringTextInputFormatter.singleLineFormatter,
            //         ],
            //         decoration: InputDecoration(
            //             counterText: '',
            //             focusedBorder: UnderlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: G.appBaseColor[0])),
            //             labelText: 'Image',
            //             labelStyle: TextStyle(
            //                 color: G.appBaseColor[0], fontSize: 26)),
            //         initialValue: _shopInfo.shopPicUrl,
            //         onChanged: (value) {
            //           setState(() {
            //             _shopInfo.shopPicUrl = value;
            //           });
            //         },
            //       ),
            //       //   IconButton(icon: Icon(Icons.picture_in_picture), onPressed: null)
            //       //Icon(Icons.picture_in_picture)
            //       // ]),
            //       if (_shopInfo.shopPicUrl != null &&
            //           !_shopInfo.shopPicUrl.isEmpty)
            //         Image.network(_shopInfo.shopPicUrl),
            //       Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 16.0),
            //           child: FBButton.build(
            //               context, 0.6.sw, "Save", Icons.save, () {
            //             GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
            //             Api.saveMyShopInfo(context, _shopInfo)
            //                 .whenComplete(() {
            //               GlobalFun.removeCurrentSnackBar(_scaffoldKey);
            //             }).catchError((e){
            //               GlobalFun.showSnackBar(_scaffoldKey, e.toString());
            //             });
            //           })),
            //     ])
            // )
          )),
      floatingActionButton: GlobalFun.saveFloatingActionButton(() {
        GlobalFun.showSnackBar(_scaffoldKey, "  Saving...");
        Api.saveMyShopInfo(context, widget._shopInfo).whenComplete(() {
          GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        }).catchError((e) {
          GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        });
      }),
    );
  }
}
