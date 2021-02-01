import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';
import 'my_menu_edit.dart';

class MyMenuInfoPage extends StatefulWidget {
  List<ItemDetail> _itemList;

  MyMenuInfoPage(this._itemList);

  _MyMenuInfoState createState() => _MyMenuInfoState(this._itemList);
}

class _MyMenuInfoState extends State<MyMenuInfoPage> {
  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  List<ItemDetail> _AllitemList;
  List<ItemDetail> _itemList = List<ItemDetail>();

  String serchString = "";

  _MyMenuInfoState(this._AllitemList);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (_AllitemList != null)
    _itemList.addAll(_AllitemList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarView.appbar("Item List", true,
          canBesearch: true, context: context, onEditingCompleteText: (query) {
        serchString = query;
        //setState(() {
        List<ItemDetail> dummySearchList = [];
        dummySearchList.addAll(_AllitemList);
        if (query.isNotEmpty) {
          List<ItemDetail> dummyListData = [];
          dummySearchList.forEach((item) {
            if (item.id.toString().contains(query) ||
                item.itemName.contains(query) ||
                item.itemDescr.contains(query)) {
              dummyListData.add(item);
            }
          });
          setState(() {
            _itemList.clear();
            _itemList.addAll(dummyListData);
          });
          return;
        } else {
          setState(() {
            _itemList.clear();
            _itemList.addAll(dummySearchList);
          });
        }
        // }
        // );
      }, serarchValue: serchString),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(_blankNode);
        },
        child: FBListViewWidget<ItemDetail>(
          _itemList,
          setActions: (c, r, index) {
            return [
              FBListViewWidget.getSlideActionDelete(c, () {
                setState(() {
                  _itemList.remove(r);
                });
              })
            ];
          },
          setSubWidget: (c, item, index) {
            return ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading:
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(item.itemMainPicUrl,),
                  // ),
                  item.itemMainPicUrl == null || item.itemMainPicUrl.isEmpty
                      ? null
                      : Container(
                          //width: 0.3.sw,
                          constraints: BoxConstraints.tightFor(width: 100.0),
                          child: Image.network(
                            item.itemMainPicUrl,
                            fit: BoxFit.fitWidth,
                          )),

              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "${item.id}:${item.itemName}",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              //Text("${item.id}:${item.itemName}", softWrap: true, overflow: TextOverflow.ellipsis,),
              subtitle: Text(
                item.itemPrice,
                maxLines: 2,
                style: TextStyle(color: Colors.red),
              ),

              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyMenuEditPage(item)));
              },
            );
          },
          footer: FBListViewWidget.buildFooter(context,
              icon: Icons.add, title: "Add a item", onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyMenuEditPage(ItemDetail.newItem()))).then(
              (value) {
                GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
                Api.getMyShopItemInfo(context).then(
                  (result) {
                    GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                    setState(
                      () {
                        this._AllitemList = result[1];
                        _itemList.clear();
                        _itemList.addAll(_AllitemList);
                      },
                    );
                  },
                ).catchError(
                  (e) {
                    GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                  },
                );
              },
            );
          }),
        ),

        // Container(
        //   margin: EdgeInsets.only(left: 5, right: 5),
        //   child: ListView.builder(
        //     itemCount: _itemList.length,
        //     itemBuilder: (context, index) {
        //       var item = _itemList[index];
        //       return Container(
        //           child: ListTile(
        //             contentPadding: EdgeInsets.all(10.0),
        //             leading:
        //                 // CircleAvatar(
        //                 //   backgroundImage: NetworkImage(item.itemMainPicUrl,),
        //                 // ),
        //                 item.itemMainPicUrl == null ||
        //                         item.itemMainPicUrl.isEmpty
        //                     ? null
        //                     : Container(
        //                         //width: 0.3.sw,
        //                         constraints:
        //                             BoxConstraints.tightFor(width: 100.0),
        //                         child: Image.network(
        //                           item.itemMainPicUrl,
        //                           fit: BoxFit.fitWidth,
        //                         )),
        //
        //             trailing: Icon(Icons.arrow_forward_ios),
        //             title: Text(
        //               "${item.id}:${item.itemName}",
        //               softWrap: true,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             //Text("${item.id}:${item.itemName}", softWrap: true, overflow: TextOverflow.ellipsis,),
        //             subtitle: Text(
        //               item.itemPrice,
        //               maxLines: 2,
        //               style: TextStyle(color: Colors.red),
        //             ),
        //
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => MyMenuEditPage(item))).then(
        //                 (value) {
        //                   GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
        //                   Api.getMyShopItemInfo(context).then(
        //                     (result) {
        //                       GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        //                       setState(
        //                         () {
        //                           this._AllitemList = result[1];
        //                           _itemList.clear();
        //                           _itemList.addAll(_AllitemList);
        //                         },
        //                       );
        //                     },
        //                   ).catchError(
        //                     (e) {
        //                       GlobalFun.showSnackBar(
        //                           _scaffoldKey, e.toString());
        //                     },
        //                   );
        //                 },
        //               );
        //             },
        //           ),
        //           decoration: BoxDecoration(
        //               border: Border(
        //                   bottom:
        //                       BorderSide(width: 1, color: Color(0xffe5e5e5)))));
        //     },
        //   ),
        // ),
      ),
    );
  }
}
