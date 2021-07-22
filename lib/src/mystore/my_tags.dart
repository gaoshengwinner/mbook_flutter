import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/model/TagResultList.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';
import 'package:collection/collection.dart';

Function deepEq = const DeepCollectionEquality().equals;

class MyTagsPage extends StatefulWidget {
  MyTagsPage(this.tagInfos);

  final List<TagInfo>? tagInfos;

  _MyTagsPageState createState() => _MyTagsPageState(this.tagInfos);
}

class _MyTagsPageState extends State<MyTagsPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _MyTagsPageState(this.tagInfos) {
    if (tagInfos == null) {
      this.tagInfos = [];
    }
  }

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  late ScrollController scrollController;
  bool inReorder = true;

  int copiedIndex = -1;

  //new TextWidgetProperty(backColor: Colors.white)

  List<TagInfo>? tagInfos = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<TagInfo> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;

      tagInfos!
        ..clear()
        ..addAll(newItems);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarView.appbar(title:"Tags", canReturn:true, context: context),
      key: _scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(_blankNode);
        },
        child: new FBListViewWidget<TagInfo>(
          tagInfos!,
          setActions: (c, r, index) {
            return [
              FBListViewWidget.getSlideActionDelete(c, () {
                setState(() {
                  tagInfos!.remove(r);
                });
              })
            ];
          },
          //seActions: [ActionOption.Delete],
          canBeMove: true,
          setSubWidget: (c, r, index) {
            return Container(
              //color: Color(0xEDE7F6),
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalFun.fbInputBox(
                        context, "Description", tagInfos![index].desc!, (value) {
                      setState(() {
                        tagInfos![index].desc = value;
                      });
                    }),
                    Row(
                      children: [
                        GlobalFun.fbInputBox(
                            context, "Tag", tagInfos![index].data!, (value) {
                          setState(() {
                            tagInfos![index].data = value;
                          });
                        },
                            valueWidget: Wrap(
                              children: [
                                WidgetTextPage(
                                  property: tagInfos![index].property,
                                  data: tagInfos![index].data,
                                )
                              ],
                            )),
                        GlobalFun.clipOvalIcon(Icons.settings, () {
                          return GlobalFun.showBottomSheetForTextPrperty(
                              context,
                              TextSettingWidget(
                                  property: tagInfos![index].property,
                                  data: tagInfos![index].data,
                                  onChange: (value) {
                                    setState(() {
                                      tagInfos![index].property = value;
                                    });
                                  }),
                              null);
                        }),
                      ],
                    ),
                  ]),
            );
          },
          footer: FBListViewWidget.buildFooter(context,
              icon: Icons.add, title: "Add a tag", onTap: () {
            setState(() {
              tagInfos!.add(TagInfo(data: "", desc: ""));
            });
          }),
          setSeActions: (c, r, index) {
            return [
              FBListViewWidget.getSlideActionCopy(c, () {
                setState(() {
                  copiedIndex = index;
                  //selectedLanguages.remove(r);
                });
              }),
              if (copiedIndex >= 0 && copiedIndex != index)
                FBListViewWidget.getSlideActionBrush(c, () {
                  setState(() {
                    if (copiedIndex >= 0)
                      tagInfos![index].property =
                          tagInfos![copiedIndex].property?.copy();
                    //selectedLanguages.remove(r);
                  });
                })
            ];
          },
        ),
      ),
      floatingActionButton: GlobalFun.saveFloatingActionButton(() {
        GlobalFun.showSnackBar(context,_scaffoldKey, null, "  Saving...");
        Api.saveMyTagInfo(context, TagResultList(tagLst: this.tagInfos))
            .whenComplete(() {
          GlobalFun.removeCurrentSnackBar(_scaffoldKey);
        }).catchError((e) {
          print(e.toString());
          GlobalFun.showSnackBar(context,_scaffoldKey, e, e.toString());
        });
      }),
    );
  }
}
