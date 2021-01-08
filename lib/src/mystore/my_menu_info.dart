import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';

class MyMenuInfoPage extends StatefulWidget {
  List<ItemDetail> _itemList;

  MyMenuInfoPage(this._itemList);

  _MyMenuInfoState createState() => _MyMenuInfoState(this._itemList);
}

class _MyMenuInfoState extends State<MyMenuInfoPage> {
  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  List<ItemDetail> _itemList;

  _MyMenuInfoState(this._itemList);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarView.appbar("My Menu", true),
        endDrawer:Icon(Icons.search_rounded),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 点击空白页面关闭键盘
              FocusScope.of(context).requestFocus(_blankNode);
            },
            child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: ListView.builder(
                    itemCount: _itemList.length,
                    itemBuilder: (context, index) {
                      var item = _itemList[index];
                      return Container(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            leading: item.itemMainPicUrl == null ||
                                    item.itemMainPicUrl.isEmpty
                                ? null
                                : Container(
                                    constraints:
                                        BoxConstraints.tightFor(width: 100.0),
                                    child: Image.network(
                                      item.itemMainPicUrl,
                                      fit: BoxFit.fitWidth,
                                    )),
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Row(
                                children: [Text("${item.id}:${item.itemName}", maxLines: 2), Spacer(), Text(item.itemPrice, maxLines: 2)]),
                            subtitle: Text(item.itemDescr, maxLines: 2),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))));
                    }))));
  }
}
