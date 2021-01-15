import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class MyTagsPage extends StatefulWidget {
  _MyTagsPageState createState() => _MyTagsPageState();
}

class _MyTagsPageState extends State<MyTagsPage> {
  final _bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();

  List<TagInfo> _AllTagInfos = new List<TagInfo>.generate(
      5,
      (i) => TagInfo(
          id: i,
          data: "test${i}",
          property: TextWidgetProperty(backColor: Colors.white)));

  //new TextWidgetProperty(backColor: Colors.white)

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView.appbar("Tags", true),
      key: _bottomSheetScaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(_blankNode);
        },
        child: Container(
            padding: EdgeInsets.only(top: 3),
            child: Column(
              children: [
                for (int i = 0; i < 3; i++)
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigoAccent.withOpacity(0),
                          child: Text("${i}"),
                          foregroundColor: Colors.black,
                        ),
                        title: Text('焼肉'),

                        subtitle:
                        Wrap(children: [
                        WidgetTextPage.build(
                          context,
                          _AllTagInfos[i].property,
                          _AllTagInfos[i].data,
                        )])
                      ),
                    ),
                    actions: <Widget>[
                      // IconSlideAction(
                      //   caption: 'Archive',
                      //   color: Colors.blue,
                      //   icon: Icons.archive,
                      //   //onTap: () => _showSnackBar('Archive'),
                      // ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        //onTap: () => _showSnackBar('Share'),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.deepPurpleAccent,
                        icon: Icons.edit,
                        onTap: () {
                          GlobalFun.openEditPage(
                              context,
                              "Tag name",
                              _AllTagInfos[i].data,
                              TextInputAction.newline,
                              TextInputType.multiline, (value) {
                            setState(() {
                              _AllTagInfos[i].data = value;
                            });
                          });
                        },
                      ),
                      IconSlideAction(
                        caption: 'Setting',
                        color: G.appBaseColor[0],
                        icon: Icons.build,
                        onTap: () {
                          GlobalFun.showBottomSheet(
                              context,
                              [
                                TextSettingWidget(
                                    property: _AllTagInfos[i].property,
                                    data: _AllTagInfos[i].data,
                                    onChange: (value) {
                                      setState(() {
                                        _AllTagInfos[i].property = value;
                                      });
                                    }),
                              ],
                              null);
                        },
                      ),
                    ],
                  )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: G.appBaseColor[0],
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
    );
  }
}
