import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:settings_ui/settings_ui.dart';

class MyMenuEditPage extends StatefulWidget {
  ItemDetail _item;

  MyMenuEditPage(this._item);

  _MyMenuEditState createState() => _MyMenuEditState(this._item);
}

class _MyMenuEditState extends State<MyMenuEditPage> {
  ItemDetail _item;

  _MyMenuEditState(this._item);

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: "商品名",
                  tiles: [
                    SettingsTile(
                      title: _item.itemName,
                      titleMaxLines: 100,
                      //titleTextStyle: TextStyle(li),
                      //subtitle: 'English',
                      //leading: Icon(Icons.language),
                      trailing: Text(""),
                      onPressed: (BuildContext context) {
                        _editValue(context, "商品名", _item.itemName, TextInputAction.done,TextInputType.text, (value) {
                          setState(() {
                            _item.itemName = value;
                          });

                        });
                      },
                    )
                  ],
                ),
                SettingsSection(
                  title: "商品価格",
                  tiles: [
                    SettingsTile(
                      title: _item.itemPrice,
                      titleMaxLines: 1,
                      //subtitle: 'English',
                      //leading: Icon(Icons.language),
                      trailing: Text(""),
                      onPressed: (BuildContext context) {
                        _editValue(context, "商品価格", _item.itemPrice, TextInputAction.done,TextInputType.number, (value) {
                          setState(() {
                            _item.itemPrice = value;
                          });
                        });
                      },
                    )
                  ],
                ),
                SettingsSection(
                  title: "商品説明",
                  tiles: [
                    SettingsTile(
                      //title: _item.itemDescr,
                      titleMaxLines: 100,
                      subtitle: _item.itemDescr,
                      subtitleMaxLines: 100,
                      //leading: Icon(Icons.language),
                      trailing: Text(""),
                      onPressed: (BuildContext context) {
                        _editValue(context, "商品説明", _item.itemDescr, TextInputAction.newline,TextInputType.multiline, (value) {
                          setState(() {
                            _item.itemDescr = value;
                          });
                        });
                      },
                    )
                  ],
                ),
              ],
            )));
  }

  void _editValue(BuildContext context, String hintTextValue,
      String initVlueValue, TextInputAction textInputAction,TextInputType keyboardType, Function onEditingCompleteText) {
    Navigator.push(
        context,
        PopRoute(
            child: InputButtomWidget(
                onEditingCompleteText: (text) {
                  onEditingCompleteText(text);
                },
                hintTextValue: hintTextValue,
                initVlueValue: initVlueValue,
                textInputAction: textInputAction,
              keyboardType: keyboardType,
            )));
  }
}
