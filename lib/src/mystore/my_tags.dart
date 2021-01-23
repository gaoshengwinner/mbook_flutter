import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/text_setting.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class MyTagsPage extends StatefulWidget {
  _MyTagsPageState createState() => _MyTagsPageState();
}

class _MyTagsPageState extends State<MyTagsPage>
    with SingleTickerProviderStateMixin {
  final _bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  ScrollController scrollController;
  bool inReorder = true;

  int copiedIndex = -1;

  List<TagInfo> _AllTagInfos = new List<TagInfo>.generate(
      5,
      (i) => TagInfo(
          id: i,
          data: "test${i}",
          property: TextWidgetProperty(backColor: Colors.white)));

  //new TextWidgetProperty(backColor: Colors.white)

  final List<Language> selectedLanguages = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<Language> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;

      selectedLanguages
        ..clear()
        ..addAll(newItems);
    });
  }

  final FocusNode _descriptionNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
        appBar: AppBarView.appbar("Tags", true),
        key: _bottomSheetScaffoldKey,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 点击空白页面关闭键盘
            FocusScope.of(context).requestFocus(_blankNode);
          },
          child: new FBListViewWidget<Language>(
            selectedLanguages,
            setActions: (c, r, index) {
              return [
                FBListViewWidget.getSlideActionDelete(c, () {
                  setState(() {
                    selectedLanguages.remove(r);
                  });
                })
              ];
            },
            //seActions: [ActionOption.Delete],
            canBeMove: true,
            setSubWidget: (c, r, index) {
              return Container(
                color: Color(0xEDE7F6),
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalFun.FBInputBox(context, "Description",
                          selectedLanguages[index].englishName, (value) {
                        setState(() {
                          selectedLanguages[index].englishName = value;
                        });
                      }),
                      Row(
                        children: [
                          GlobalFun.FBInputBox(context, "Tag",
                              selectedLanguages[index].nativeName, (value) {
                            setState(() {
                              selectedLanguages[index].nativeName = value;
                            });
                          },
                              valueWidget: Wrap(
                                children: [
                                  WidgetTextPage.build(
                                    context,
                                    selectedLanguages[index].property,
                                    selectedLanguages[index].nativeName,
                                  )
                                ],
                              )),
                          GlobalFun.ClipOvalIcon(Icons.settings, () {
                            return GlobalFun.showBottomSheet(
                                context,
                                [
                                  TextSettingWidget(
                                      property:
                                          selectedLanguages[index].property,
                                      data: selectedLanguages[index].nativeName,
                                      onChange: (value) {
                                        setState(() {
                                          selectedLanguages[index].property =
                                              value;
                                        });
                                      }),
                                ],
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
                selectedLanguages
                    .add(Language(englishName: "", nativeName: ""));
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
                FBListViewWidget.getSlideActionBrush(c, () {
                  setState(() {
                    if (copiedIndex >= 0)
                      selectedLanguages[index].property =
                          selectedLanguages[copiedIndex].property;
                    //selectedLanguages.remove(r);
                  });
                })
              ];
            },

            // (c, r, index){return FBListViewWidget.getMoveListWidget();},
            // createLeading: (c, r, index) {
            //   return SizedBox(
            //     //width: 36,
            //     //height: 36,
            //     child: Center(
            //       child: Text(
            //         '${index + 1}',
            //         style: textTheme.bodyText2.copyWith(
            //           color: theme.accentColor,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   );
            // },
            // createTitle: (c, r, index) {
            //   return GestureDetector(
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Wrap(
            //           // alignment: WrapAlignment.start,
            //           children: [
            //             GlobalFun.getEditCont(context, selectedLanguages[index].englishName, selectedLanguages[index].englishName, false, (value) {
            //               setState(() {
            //                 selectedLanguages[index].englishName = value;
            //               });
            //             }),
            //             //Icon(Icons.edit),
            //             //Text(selectedLanguages[index].englishName)
            //           ],
            //         ),
            //       ),
            //       onTap: () {
            //         GlobalFun.openEditPage(
            //             context,
            //             "Tag name",
            //             selectedLanguages[index].englishName,
            //             TextInputAction.newline,
            //             TextInputType.multiline, (value) {
            //           setState(() {
            //             selectedLanguages[index].englishName = value;
            //           });
            //         });
            //       });
            // },
            // createSubTitle: (c, r, index) {
            //   return GestureDetector(
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Wrap(
            //           // alignment: WrapAlignment.start,
            //           children: [
            //             GlobalFun.getEditCont(context, selectedLanguages[index].englishName, selectedLanguages[index].englishName, false, (value) {
            //               setState(() {
            //                 selectedLanguages[index].englishName = value;
            //               });
            //             }),
            //             //Icon(Icons.edit),
            //             //Text(selectedLanguages[index].englishName)
            //           ],
            //         ),
            //       ),
            //       onTap: () {
            //         GlobalFun.openEditPage(
            //             context,
            //             "Tag name",
            //             selectedLanguages[index].englishName,
            //             TextInputAction.newline,
            //             TextInputType.multiline, (value) {
            //           setState(() {
            //             selectedLanguages[index].englishName = value;
            //           });
            //         });
            //       });
            // },
          ),
        ));
  }
}

class Language {
  String englishName;

  String nativeName;

  TextWidgetProperty property = TextWidgetProperty(backColor: Colors.white);

  Language({
    @required this.englishName,
    @required this.nativeName,
  });

  @override
  String toString() =>
      'Language englishName: $englishName, nativeName: $nativeName';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Language &&
        o.englishName == englishName &&
        o.nativeName == nativeName;
  }

  @override
  int get hashCode => englishName.hashCode ^ nativeName.hashCode;
}
