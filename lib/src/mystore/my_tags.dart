import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/model/TagResultList.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_implicitly_animated_reorderable_list.dart';
import 'package:collection/collection.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';

Function deepEq = const DeepCollectionEquality().equals;

class MyTagsPage extends StatefulWidget {
  MyTagsPage({required this.tagInfos}) {
    for (var tagInfo in this.tagInfos) {
      _tagInfos.add(tagInfo.copy());
    }
  }

  List<TagInfo> _tagInfos = [];
  final List<TagInfo> tagInfos;

  _MyTagsPageState createState() => _MyTagsPageState();
}

class _MyTagsPageState extends State<MyTagsPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  late ScrollController scrollController;
  bool inReorder = true;

  int copiedIndex = -1;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<TagInfo> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;
      widget._tagInfos
        ..clear()
        ..addAll(newItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarView.appbar(title: "Tags", canReturn: true, context: context),
      key: _scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(_blankNode);
        },
        child: FBReorderableList<TagInfo>(
            items: widget._tagInfos,
            actions: [
              ActionsParam(
                  kind: ActionsKind.delete,
                  actFuction: (int index) {
                    setState(() {
                      widget._tagInfos.removeAt(index);
                    });
                  })
            ],
            body: (TagInfo tagInfo, int i) {
              return ListTile(
                leading: Text("No.${i + 1}"),
                title: Text("${tagInfo.id} ${tagInfo.desc}"),
                subtitle: Wrap(
                  children: [
                    WidgetTextWidget(
                      property: tagInfo.property,
                      data: tagInfo.data,
                    )
                  ],
                ),
                trailing: Icon(
                  CupertinoIcons.forward,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  TagEditPage.openPage(
                      context: context,
                      tagInfos: widget._tagInfos,
                      index: i,
                      onSaved: (value) {
                        MyGlobal.getTagInfos(context);
                        setState(() {
                          widget.tagInfos.clear();
                          widget.tagInfos.addAll(value);
                          widget._tagInfos = value;
                        });
                      });
                },
              );
            },
            secondaryActions: [
              ActionsParam(
                  kind: ActionsKind.copy,
                  actFuction: (int index) {
                    setState(() {
                      copiedIndex = index;
                    });
                  }),
              if (copiedIndex > 0)
                ActionsParam(
                    kind: ActionsKind.paste,
                    actFuction: (int index) {
                      setState(() {
                        widget._tagInfos[index].property =
                            widget._tagInfos[copiedIndex].property?.copy();
                      });
                    }),
            ],
            needHandle: true,
            footerParam: FooterParam()
              ..title = Text("Add a tag",
                  style: TextStyle(color: Theme.of(context).primaryColor))
              ..icon = Icon(Icons.add, color: Theme.of(context).primaryColor)
              ..onTap = () {
                TagEditPage.openPage(
                    context: context, tagInfos: widget._tagInfos);
              },
            onReorderFinished: (item, rom, to, newItems) {
              final TagInfo item = widget._tagInfos.removeAt(rom!);
              widget._tagInfos.insert(to, item);

              GlobalFun.showSnackBar(
                  context, null, "  Saving...");
              Api.saveMyTagInfo(
                          context, TagResultList(tagLst: widget._tagInfos))
                      .whenComplete(() {
                GlobalFun.removeCurrentSnackBar(context);
                widget.tagInfos.clear();
                widget.tagInfos.addAll(widget._tagInfos);
              })
                  //     .catchError((e) {
                  //   print(e.toString());
                  //   GlobalFun.showSnackBar(context, _scaffoldKey, e, e.toString());
                  // })
                  ;
            }),
      ),
    );
  }
}

typedef SavedFunction = void Function(List<TagInfo> tagInfos);

class TagEditPage extends StatefulWidget {
  final int? index;
  final List<TagInfo> tagInfos;
  final List<TagInfo> _tagInfos = [];
  final SavedFunction? onSaved;

  TagEditPage({Key? key, this.index, required this.tagInfos, this.onSaved})
      : super(key: key) {
    for (var tagInfo in this.tagInfos) {
      _tagInfos.add(tagInfo.copy());
    }
  }

  @override
  _TagEditPageState createState() => _TagEditPageState();

  static void openPage(
      {required BuildContext context,
      final SavedFunction? onSaved,
      required List<TagInfo> tagInfos,
      int? index}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TagEditPage(
                tagInfos: tagInfos, index: index, onSaved: onSaved)));
  }
}

class _TagEditPageState extends State<TagEditPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    //initList();
    _tabController = new TabController(
        initialIndex: G.ifNull(widget.index, 0),
        vsync: this,
        length: widget._tagInfos.length);
    //_tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarView.appbar(
          title: "Edit option",
          canReturn: true,
          whenReturnNeedConfirm: () {
            for (var i = 0; i < widget._tagInfos.length; i++) {
              if (!(widget._tagInfos[i] == widget.tagInfos[i])) {
                return true;
              }
            }
            return false;
          },
          context: context,
          canSave: true,
          onSave: () {
            GlobalFun.showSnackBar(context, null, "  Saving...");
            Api.saveMyTagInfo(context, TagResultList(tagLst: widget._tagInfos))
                    .whenComplete(() {
              GlobalFun.removeCurrentSnackBar(context);
              widget.tagInfos.clear();
              widget.tagInfos.addAll(widget._tagInfos);
              if (widget.onSaved != null) widget.onSaved!(widget._tagInfos);
            })
                //     .catchError((e) {
                //   print(e.toString());
                //   GlobalFun.showSnackBar(context, _scaffoldKey, e, e.toString());
                // })
                ;
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IconButton(
        tooltip: "Setting",
        icon: const Icon(
          Ionicons.md_settings_outline,
        ),
        onPressed: () {
          if (widget._tagInfos.length > _tabController.index)
            showSetting(widget._tagInfos[_tabController.index]);
        },
      ),
      body: TabBarView(
        controller: this._tabController,
        children: [
          for (var i = 0; i < widget._tagInfos.length; i++)
            ListView(children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalFun.fbInputBox(context, "Description",
                              (widget._tagInfos[i].desc?.toString() ?? ""),
                              (value) {
                            setState(() {
                              widget._tagInfos[i].desc = value;
                            });
                          }),
                          GlobalFun.fbInputBox(context, "Text",
                              (widget._tagInfos[i].data?.toString() ?? ""),
                              (value) {
                            setState(() {
                              widget._tagInfos[i].data = value;
                            });
                          }),
                          Divider(),
                          GlobalFun.commonTitle(
                            context,
                            "Look like",
                          ),
                          Center(
                            child: WidgetTextWidget(
                              property: widget._tagInfos[i].property,
                              data: widget._tagInfos[i].data,
                            ),
                          ),
                        ]),
                  ))
            ])
        ],
      ),
    );
  }

  void showSetting(TagInfo taginfo) {
    GlobalFun.showBottomSheetForTextPrperty(
        context,
        TextSettingWidget(
            property: taginfo.property,
            data: taginfo.data,
            onChange: (value) {
              setState(() {
                taginfo.property = value;
              });
            }),
        null);
  }
}
