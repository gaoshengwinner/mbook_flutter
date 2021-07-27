import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';
import 'package:mbook_flutter/src/mystore/my_menu_list.dart';
import 'package:mbook_flutter/src/mystore/my_options.dart';
import 'package:mbook_flutter/src/mystore/my_store_edite.dart';
import 'package:settings_ui/settings_ui.dart';

import 'my_tags.dart';

class MyStorePage extends StatefulWidget {
  //_MyStorePageState createState() => _MyStorePageState();
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // GlobalFun.showSnackBar(_scaffoldKey, "  Loading...");
    // Api.getMyTags(context).then((result) {
    //   GlobalFun.removeCurrentSnackBar(_scaffoldKey);
    //   TabInfosContentEvent.set(result[1]);
    // }).catchError((e){
    //   GlobalFun.showSnackBar(_scaffoldKey, e.toString());
    // });
  }

  @override
  void dispose() {
    super.dispose();
    MyGlobal.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarView.appbar(
            title: S.of(context).mystore_title,
            canReturn: true,
            context: context),
        body: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                GlobalFun.customListGroup(context: context, title: "Base Info"),
                GlobalFun.customListTitle(
                    context: context,
                    icon: Icons.store,
                    title: "Store Info",
                    doTop: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyStoreInfoPage(MyGlobal.shopInfo)));
                    },
                    isFirst: true),
                GlobalFun.customListTitle(
                    context: context,
                    icon: Icons.menu,
                    title: "Menu Info",
                    doTop: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyMenuInfoPage(MyGlobal.itemDetails)));
                    },
                    isBottom: true),
                GlobalFun.customListGroup(context: context, title: "Setting"),
                GlobalFun.customListTitle(
                    context: context,
                    icon: FontAwesome.tags,
                    title: "Tags",
                    doTop: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyTagsPage(
                                  tagInfos: MyGlobal.tagInfos ?? [])));
                    },
                    isFirst: true),
                GlobalFun.customListTitle(
                    context: context,
                    icon: Ionicons.ios_options_outline,
                    title: "Option templates",
                    doTop: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyOptionsPage(MyGlobal.optionTempInfos)));
                    },
                    isBottom: true),
              ],
            ),
          ),
        )

        // SettingsList(
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   sections: [
        //     SettingsSection(
        //       title: 'Base info',
        //       titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        //       tiles: [
        //         SettingsTile(
        //           title: 'Store Info',
        //           subtitle: '',
        //           leading:
        //               Icon(Icons.store, color: Theme.of(context).iconTheme.color),
        //           onPressed: (BuildContext context) async {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         MyStoreInfoPage(MyGlobal.shopInfo)));
        //           },
        //         ),
        //         SettingsTile(
        //           switchActiveColor: G.appBaseColor[0],
        //           title: 'Menu Info',
        //           leading:
        //               Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
        //           onPressed: (BuildContext context) async {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         MyMenuInfoPage(MyGlobal.itemDetails)));
        //           },
        //         ),
        //
        //         // SettingsTile(
        //         //   switchActiveColor: G.appBaseColor[0],
        //         //   title: 'Color Picker',
        //         //   leading: Icon(Icons.tag),
        //         //   onPressed: (BuildContext context) async {
        //         //     GlobalFun.showSnackBar(context,_scaffoldKey, "  Loading...");
        //         //     //Api.getMyShopItemInfo(context).then((result) {
        //         //     // GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        //         //     Navigator.push(
        //         //         context,
        //         //         MaterialPageRoute(
        //         //             builder: (context) => ColorPickerPage()));
        //         //     //}).catchError((e){
        //         //     //  GlobalFun.showSnackBar(_scaffoldKey, e.toString());
        //         //     //});
        //         //   },
        //         // ),
        //       ],
        //     ),
        //     SettingsSection(
        //         title: "Setting",
        //         titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        //         tiles: [
        //           SettingsTile(
        //             switchActiveColor: G.appBaseColor[0],
        //             title: 'Tags',
        //             leading: Icon(FontAwesome.tags,
        //                 color: Theme.of(context).iconTheme.color),
        //             onPressed: (BuildContext context) async {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           MyTagsPage(tagInfos: MyGlobal.tagInfos ?? [])));
        //             },
        //           ),
        //           SettingsTile(
        //             switchActiveColor: G.appBaseColor[0],
        //             title: 'Option templates',
        //
        //             leading: Icon(Ionicons.ios_options_outline,
        //                 color: Theme.of(context).iconTheme.color),
        //             onPressed: (BuildContext context) async {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           MyOptionsPage(MyGlobal.optionTempInfos)));
        //             },
        //           ),
        //         ]),
        //   ],
        // ),
        );
  }
}
