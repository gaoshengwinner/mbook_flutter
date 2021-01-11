import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/color_picker.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:settings_ui/settings_ui.dart';

class TextSettingWidget extends StatefulWidget {
  @override
  _TextSettingWidget createState() => _TextSettingWidget();
}

class _TextSettingWidget extends State<TextSettingWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextWidgetProperty _property = TextWidgetProperty(Colors.white);
  final tabList = [
    '背景色',
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

// create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.transparent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          new Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: new BoxDecoration(
                //border: new Border.all( width: 0.5), // 边色与边宽度
                color: Color(0xFFEFEFF4),
                // 底色
                //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                borderRadius:
                    new BorderRadius.vertical(top: Radius.elliptical(10, 10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0)
                ],
              ),

              height: 0.6.sh,
              //color: Color(0xFFEFEFF4),
              child: new Column(
                children: <Widget>[
                  new Container(
                    // decoration:
                    //     new BoxDecoration(color: Theme.of(context).primaryColor),
                    child: new TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        new Tab(
                          text: "${tabList[0]}",
                        )
                      ],
                    ),
                  ),
                  new Container(
                    height: 200,
                    child: new TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        SettingsList(
                          sections: [
                            SettingsSection(
                              title: '',
                              tiles: [
                                SettingsTile(
                                  title: 'Background color',
                                  subtitle: '',
                                  leading: Icon(Icons.color_lens_outlined, color: _property.backColor,),
                                  trailing: Icon(Icons.open_in_browser_sharp),
                                  onPressed: (BuildContext context) {
                                    openColor(context, _property.backColor,
                                        (value) {
                                      setState(() {
                                        _property.backColor = value;
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        )

                        // SingleChildScrollView(
                        //     child: ColorPicker(
                        //       pickerColor: pickerColor,
                        //       //onColorChanged: changeColor,
                        //       showLabel: true,
                        //       pickerAreaHeightPercent: 0.8,
                        //     ),
                        // )
                        // for (var i = 0; i < tabList.length; i++)
                        //   new Card(
                        //     child: new ListTile(
                        //       //leading: const Icon(Icons.home),
                        //       title: new TextField(
                        //         decoration: const InputDecoration(
                        //             hintText: 'Search for address...'),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: WidgetTextPage(
                      "Hello",
                      _property,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//
// @override
// Widget build(BuildContext context) {
//   return new MaterialApp(
//     title: 'msc',
//     home:
//     new DefaultTabController(
//       length: 2,
//       child: new Scaffold(
//         appBar: new PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: new Container(
//             color: Colors.green,
//             child: new SafeArea(
//               child: Column(
//                 children: <Widget>[
//                   new Expanded(child: new Container()),
//                   new TabBar(
//                     tabs: [new Text("Lunches"), new Text("Cart")],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: new TabBarView(
//           children: <Widget>[
//             new Column(
//               children: <Widget>[new Text("Lunches Page")],
//             ),
//             new Column(
//               children: <Widget>[new Text("Cart Page")],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
