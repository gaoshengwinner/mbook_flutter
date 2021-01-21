import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/menu.dart';
import 'package:mbook_flutter/src/mystore/my_menu_info.dart';
import 'package:mbook_flutter/src/samples/color_picker.dart';
import 'package:settings_ui/settings_ui.dart';

import 'my_store_info.dart';
import 'my_tags.dart';

class MyStorePage extends StatefulWidget {
  //_MyStorePageState createState() => _MyStorePageState();
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  bool _value = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarView.appbar(S.of(context).mystore_title, true),
       // backgroundColor:Color(0xf5f5f5).withOpacity(1),
        //endDrawer: Text("test"),//MenuBar.menu(true, true, context, null),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'Base info',
              titleTextStyle: TextStyle(color: G.appBaseColor[0]),
              tiles: [
                SettingsTile(
                  title: 'Store Base Info',
                  subtitle: '',
                  leading: Icon(Icons.store),
                  onPressed: (BuildContext context) async {
                    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
                    Api.getMyShopInfo(context).then((result) {
                      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyStoreInfoPage(result[1])));
                    }).catchError((e) {
                      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                    });
                  },
                ),
                SettingsTile(
                  switchActiveColor: G.appBaseColor[0],
                  title: 'Menu Info',
                  leading: Icon(Icons.menu),
                  onPressed: (BuildContext context) async {
                    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
                    Api.getMyShopItemInfo(context).then((result) {
                      GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyMenuInfoPage(result[1])));
                    }).catchError((e) {
                      GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                    });
                  },
                ),
                SettingsTile(
                  switchActiveColor: G.appBaseColor[0],
                  title: 'Tags',
                  leading: Icon(Icons.tag),
                  onPressed: (BuildContext context) async {
                    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
                    //Api.getMyShopItemInfo(context).then((result) {
                    // GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyTagsPage()));
                    //}).catchError((e){
                    //  GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                    //});
                  },
                ),
                SettingsTile(
                  switchActiveColor: G.appBaseColor[0],
                  title: 'Color Picker',
                  leading: Icon(Icons.tag),
                  onPressed: (BuildContext context) async {
                    GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
                    //Api.getMyShopItemInfo(context).then((result) {
                    // GlobalFun.removeCurrentSnackBar(_scaffoldKey);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ColorPickerPage()));
                    //}).catchError((e){
                    //  GlobalFun.showSnackBar(_scaffoldKey, e.toString());
                    //});
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
