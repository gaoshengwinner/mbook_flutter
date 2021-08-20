import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/extension/extension_color.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/FBTableTempProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBBoxDecorationProperty.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/daos/BaseTemplateDao.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/daos/base/AppDatabase.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/daos/base/DBManager.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/entities/BaseTemplate.dart';
import 'package:mbook_flutter/src/comm/tools/container_setting.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_alert_dialog.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_editable_table.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_footer.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_implicitly_animated_reorderable_list.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_input_box.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_title.dart';
import 'package:mbook_flutter/src/comm/widgets/menu_title.dart';

typedef EditBaseTemplateSaveFunction = void Function(BaseTemplate);

class MyBaseTemplatePage extends StatefulWidget {
  //final List<BaseTemplate>? servicesTemps;

  MyBaseTemplatePage();

  _MyBaseTemplatePageState createState() => _MyBaseTemplatePageState();
}

class _MyBaseTemplatePageState extends State<MyBaseTemplatePage> {
  List<BaseTemplate> _baseTemps = [];

  _getList() async {
    BaseTemplateDao dao = await BaseTemplateDao.ins();
    try {
      _baseTemps = await dao.findAllBaseTemplates();
    } on Exception {
      await dao.deleteAllData();
      _baseTemps = await dao.findAllBaseTemplates();
    }
  }

  _delete(BaseTemplate o) async {
    BaseTemplateDao dao = await BaseTemplateDao.ins();
    try {
      await dao.deleteData(o);
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  _deleteAllData() async{
    BaseTemplateDao dao = await BaseTemplateDao.ins();
    try {
      await dao.deleteAllData();
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }
  //
  // _save(BaseTemplate o) async {
  //   BaseTemplateDao dao = await BaseTemplateDao.ins();
  //   await dao.insetOrUpdateData(o);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    DBManager.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView.appbar(
          title: "Base temps",
          canReturn: true,
          context: context,
          canSave: false),
      key: GlobalKey<ScaffoldState>(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FutureBuilder(
          future: _getList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              _deleteAllData();
              return Text("${snapshot.error.toString()}");
            } else if (snapshot.connectionState == ConnectionState.done) {
              return FBReorderableList<BaseTemplate>(
                items: _baseTemps,
                body: (BaseTemplate temp, int i) {
                  return Container(
                    //width: 0.95.sw,
                    child: ListTile(
                        onTap: () {
                          openEditPage(
                              baseTemplates: _baseTemps,
                              index: i,
                              onSave: (baseTemplate) {
                                setState(() {
                                  _baseTemps[i] = baseTemplate;
                                });
                              });
                        },
                        leading: Icon(Ionicons.ios_options_outline,
                            color: Theme.of(context).iconTheme.color),
                        title: Text(G.ifNull(temp.property.desc, "")),
                        trailing: Icon(
                          CupertinoIcons.forward,
                          color: Theme.of(context).primaryColor,
                        )),
                  );
                },
                actions: [
                  ActionsParam(
                      kind: ActionsKind.delete,
                      actFuction: (int index) {

                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return
                                FBAlertDialog(
                                  onSave:(){
                                    setState(() {
                                      _delete(_baseTemps[index]);
                                      _baseTemps.removeAt(index);
                                    });
                                  },
                                  contentTitle:"Do you want to delete this item?",
                                  title:"Confirm delete",);
                            });



                      })
                ],
                needHandle: true,
                footerParam: FooterParam()
                  ..title = Text("Add a base template",
                      style: TextStyle(color: Theme.of(context).primaryColor))
                  ..icon =
                      Icon(Icons.add, color: Theme.of(context).primaryColor)
                  ..onTap = () {
                    openEditPage(
                        baseTemplate: BaseTemplate.newItem(),
                        onSave: (baseTemplate) {
                          setState(() {
                            _baseTemps.add(baseTemplate);
                          });
                        });
                  },
              );
            } else
              return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor));
          },
        ),
      ),
      floatingActionButton: GlobalFun.saveFloatingActionButton(() {
        GlobalFun.showSnackBar(context, null, "  Saving...");
        // Api.saveMyBaseTemplatenfo(
        // context, BaseTemplateResultList(optionTempLst: this._servicesTemps))
        //     .whenComplete(() {
        // GlobalFun.removeCurrentSnackBar(context);
        // }).catchError((e) {
        // GlobalFun.showSnackBar(context, null, e.toString());
        // });
      }),
    );
  }

  void openEditPage(
      {BaseTemplate? baseTemplate,
      EditBaseTemplateSaveFunction? onSave,
      List<BaseTemplate>? baseTemplates,
      int? index}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BaseTemplateEditPage(
                baseTemplate: baseTemplate,
                baseTemplates: baseTemplates,
                index: index,
                onSave: onSave)));
  }
}

class BaseTemplateEditPage extends StatefulWidget {
  final BaseTemplate? baseTemplate;
  final List<BaseTemplate>? baseTemplates;
  final int? index;
  final EditBaseTemplateSaveFunction? onSave;

  BaseTemplateEditPage(
      {this.baseTemplate, this.baseTemplates, this.index, this.onSave}) {
    assert((baseTemplates == null && index == null) ||
        (baseTemplates != null && index != null));
    assert(baseTemplate == null || baseTemplates == null);
  }

  @override
  _BaseTemplateEditPageState createState() => _BaseTemplateEditPageState();
}

class _BaseTemplateEditPageState extends State<BaseTemplateEditPage>
    with SingleTickerProviderStateMixin {
  BaseTemplate _baseTemplate = BaseTemplate.newItem();
  List<BaseTemplate> _baseTemplates = [];

  //OptionWidgetProperty _optionWidgetProperty = OptionWidgetProperty.init();
  //ItemOptionList _itemOptionList = ItemOptionList.forTemp();

  late TabController _tabController;

  void initState() {
    super.initState();
    initList();
    _tabController = new TabController(
        initialIndex: G.ifNull(widget.index, 0),
        vsync: this,
        length: _baseTemplates.length);
    //_tabController.addListener(_handleTabSelection);
  }

  _save(BaseTemplate o) async {
    BaseTemplateDao dao = await BaseTemplateDao.ins();
    await dao.insetOrUpdateData(o);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initList() {
    _baseTemplates = [];
    if (widget.baseTemplate != null) {
      _baseTemplate = widget.baseTemplate!;
      _baseTemplates.add(_baseTemplate);
    } else if (widget.index != null) {
      _baseTemplate = widget.baseTemplates![widget.index!];
      _baseTemplates.addAll(widget.baseTemplates!);
    } else {
      _baseTemplates.add(_baseTemplate);
    }
  }

  @override
  Widget build(BuildContext context) {
    initList();
    return
        // DefaultTabController(
        //   initialIndex: G.ifNull(widget.index, 0),
        //   length: _optionTemps.length,
        //   child:
        Scaffold(
      appBar: AppBarView.appbar(
          title: "Edit base template",
          canReturn: true,
          context: context,
          canSave: true,
          onSave: () async {
            _baseTemplate.refresh();
            _save(_baseTemplate);
            if (widget.onSave != null) widget.onSave!(_baseTemplate);
          }),
      key: GlobalKey<ScaffoldState>(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: IconButton(
      //   tooltip: "Setting",
      //   icon: const Icon(
      //     Ionicons.md_settings_outline,
      //   ),
      //   onPressed: () {
      //     //showSetting(_optionTemps[_tabController.index]);
      //   },
      // ),
      body:
          //SingleChildScrollView(child:
          TabBarView(
        controller: this._tabController,
        children: [
          for (var i = 0; i < _baseTemplates.length; i++)
            ListView(children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // 点击空白页面关闭键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FBInputBox(
                              lableText: "Description",
                              value: (G.ifNull(
                                  _baseTemplates[i].property.desc, "")),
                              serValue: (value) {
                                setState(() {
                                  _baseTemplates[i].property.desc = value;
                                });
                              }),
                          Divider(),
                          FBTitle(lableText: "Design", rightWidget:
                          IconButton(icon: Icon(AntDesign.profile), onPressed: ()  {

                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                              return ContainerSettingPage(
                                kinds: [SettingKind.size, SettingKind.backgroundColor, SettingKind.border, SettingKind.borderRadius],
                                  property: _baseTemplates[i].property.outSide,
                                  data: "",
                                  onChange: (value) {
                                    setState(() {
                                      _baseTemplates[i].property.outSide = value;
                                    });
                                  });
                            });

                            // GlobalFun.showBottomSheetForTextPrperty(
                            //     context,
                            //     ContainerSettingPage(
                            //         property: _baseTemplates[i].property.outSide,
                            //         data: "",
                            //         onChange: (value) {
                            //           setState(() {
                            //             _baseTemplates[i].property.outSide = value;
                            //           });
                            //         }),
                            //     null);
                          },),),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(1),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            child: FBEditableTable(
                                property: _baseTemplates[i].property),
                          ),
                          Footer(
                              footerParam: FooterParam()
                                ..title = Text("Add a line",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor))
                                ..icon = Icon(Icons.add,
                                    color: Theme.of(context).primaryColor)
                                ..onTap = () {
                                  setState(() {
                                    _baseTemplate
                                        .property.outSide.borderWidth = 1;
                                    // _baseTemplate.property.outSideProperty.
                                    _baseTemplates[i]
                                        .property
                                        .rowSet!
                                        .add(
                                            RowSet(
                                                property:
                                                    FBBoxDecorationProperty(),
                                                cellSet: [
                                              CellSet(),
                                              CellSet(),
                                              CellSet()
                                            ]));
                                  });
                                }),
                          //
                          // Container(
                          //     //height: 100,
                          //     constraints: BoxConstraints(
                          //         //minHeight: 100,
                          //         ),
                          //     child: Column(
                          //       children: [
                          //         SizedBox(
                          //            height: 700,
                          //           width: double.maxFinite,
                          //           child: IntrinsicHeight(
                          //             child: Row(
                          //               children: <Widget>[
                          //                 Expanded(
                          //                   flex: 2,
                          //                   child: Container(
                          //                       alignment:
                          //                           Alignment.centerRight,
                          //                       color: Colors.red,
                          //                       child: Column(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.start,
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.center,
                          //                         children: [
                          //                           Text("1"),
                          //                           Text("2"),
                          //                           Text("3"),
                          //                           Text("4"),
                          //                           Text("5"),
                          //                           Text("6"),
                          //                           Text("7"),
                          //                           Text("8"),
                          //                         ],
                          //                       )
                          //                       // ,height: 100,
                          //                       ),
                          //                 ),
                          //                 Expanded(
                          //                   flex: 2,
                          //                   child:  Container(
                          //                         height: double.maxFinite,
                          //                         color: Colors.yellow,
                          //                         child: Column(
                          //                           children: [
                          //                             Container(
                          //                               color:Colors.red,
                          //                                 child: ListTile(),
                          //                                 //Text("1fsafdsfsaf¥nfdasfsaf dfsafa sadf dsf sdf as fds fdsf dsaf adsdf sd sadf sd ds fsd dfs")
                          //                           ),
                          //                           ],
                          //                         )
                          //                         //,height: 100,
                          //                         ),
                          //
                          //                 ),
                          //                 // Container(
                          //                 //   color: Colors.blue,
                          //                 //   height: 100,
                          //                 //   width: 50,
                          //                 // ),
                          //                 Expanded(
                          //                   flex: 1,
                          //                   child: Container(
                          //                       color: Colors.amber,
                          //                       child: Column(
                          //                         children: [
                          //                           Text("1"),
                          //                           Text("1"),
                          //                         ],
                          //                       )
                          //                       //height: 100,
                          //                       ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                        ]),
                  ))
            ])
        ],
      ),
      //) ,
    ) //,
        // )
        ;
  }

// void showSetting(OptionTemp optionTemp) {
//   GlobalFun.showBottomSheet(
//       context,
//       [
//         MenuTitle(
//             icon: Ionicons.md_settings_outline,
//             title: "Title style",
//             doTop: () {
//               Navigator.pop(context);
//               GlobalFun.showBottomSheetForTextPrperty(
//                   context,
//                   TextSettingWidget(
//                       property: optionTemp.property.titlePr,
//                       //data: _itemOptionList.title,
//                       onChange: (value) {
//                         setState(() {
//                           optionTemp.property.titlePr = value;
//                         });
//                       }),
//                   null);
//             },
//             isFirst: true),
//       ],
//       Colors.white);
// }
}
