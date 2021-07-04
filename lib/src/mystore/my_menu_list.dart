import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';
import 'my_menu_edit.dart';

// ignore: must_be_immutable
class MyMenuInfoPage extends StatefulWidget {
   List<ItemDetail>? _allItemList;

   MyMenuInfoPage(this._allItemList);

  _MyMenuInfoState createState() => _MyMenuInfoState();
}

class _MyMenuInfoState extends State<MyMenuInfoPage> {
  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  final List<ItemDetail> _itemList = [];

  String searchString = "";


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget._allItemList != null)
    _itemList.addAll(widget._allItemList!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarView.appbar("Item List", true,
          canBesearch: true, context: context, onEditingCompleteText: (query) {
        searchString = query;
        //setState(() {
        List<ItemDetail> dummySearchList = [];
        if (widget._allItemList != null ) dummySearchList.addAll(widget._allItemList!);
        if (query.isNotEmpty) {
          List<ItemDetail> dummyListData = [];
          dummySearchList.forEach((item) {
            if (item.id.toString().contains(query) ||
                (item.itemName != null && item.itemName!.contains(query)) ||
                (item.itemDescr != null && item.itemDescr!.contains(query))) {
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
      }, serarchValue: searchString),
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
                  item.itemMainPicUrl?.isEmpty ?? true
                      ? null
                      : Container(
                          //width: 0.3.sw,
                          constraints: BoxConstraints.tightFor(width: 100.0),
                          child: MBImage(
                            url:item.itemMainPicUrl,
                            fit: BoxFit.fitWidth,
                          )),

              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "${item.id}:${item.itemName}",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                item.itemPrice == null ? "" : item.itemPrice!,
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
                GlobalFun.showSnackBar(context,_scaffoldKey, null,"  Loading...");
                Api.getMyShopItemInfo(context).then(
                  (result) {
                    GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                    setState(
                      () {
                        widget._allItemList = result[1];
                        _itemList.clear();
                        if (widget._allItemList != null) _itemList.addAll(widget._allItemList!);
                      },
                    );
                  },
                ).catchError(
                  (e) {
                    GlobalFun.showSnackBar(context,_scaffoldKey, e, e.toString());
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
