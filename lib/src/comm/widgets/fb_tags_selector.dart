import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';

class TagsSelectWidget extends StatefulWidget {
  final List<TagInfo>? tagInfos;
  final List<TagInfo>? selectedTagInfos;
  final Function? onSelected;

  TagsSelectWidget({this.tagInfos, this.selectedTagInfos, this.onSelected});

  _TagsSelectWidget createState() => _TagsSelectWidget(
      oldTagInfos: this.tagInfos,
      selectedTagInfos: selectedTagInfos,
      onSelected: onSelected);
}

class _TagsSelectWidget extends State<TagsSelectWidget> {
  _TagsSelectWidget(
      {this.oldTagInfos, this.selectedTagInfos, this.onSelected}) {
    if (this.selectedTagInfos == null) {
      this.selectedTagInfos = [];
    }

    this.tagInfos = [];
    if (this.oldTagInfos != null) {
      for (TagInfo tag in this.oldTagInfos!) {
        bool have = false;
        for (TagInfo added in this.selectedTagInfos!) {
          if (added.id == tag.id) {
            have = true;
            break;
          }
        }
        if (!have) {
          this.tagInfos!.add(tag.copy());
        }
      }
    }
  }

  List<TagInfo>? tagInfos = [];
  List<TagInfo>? oldTagInfos = [];
  List<TagInfo>? selectedTagInfos = [];
  Function? onSelected;

  late ScrollController scrollController;

  int copiedIndex = -1;

  bool inReorder = false;

  void onReorderFinished(List<TagInfo> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;
      selectedTagInfos!
        ..clear()
        ..addAll(newItems);
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(() {
      fn();
    });
    if (onSelected != null) {
      onSelected!(this.selectedTagInfos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        // Expanded(
        //   flex: 1,
        //   child: Container(
        //     width: 1.sw - 5,
        //     height: 100,
        //     //color:Color.fromRGBO(243, 229, 245, 1),
        //     child: Center(
        //
        //       // margin: EdgeInsets.only(top: 5),
        //       //width: 1.sw - 5,
        //       // height: 150,
        //       //child: //Align(
        //       //alignment: Alignment.center,
        //       child:
        //             Wrap(
        //               spacing: 3,
        //               children: [
        //
        //                 for(TagInfo item in this.selectedTagInfos)
        //                   WidgetTextPage.build(
        //                     context,
        //                     item.property,
        //                     item.data,
        //                   )
        //               ],
        //             ),
        //       ),
        //
        //   ),
        // ),
        Expanded(
          //flex: 5,
          child: Container(
            color: Color(0xFFEFEFF4),
            width: double.infinity,
            child:
                //SingleChildScrollView(

                //child:
                new ImplicitlyAnimatedReorderableList<TagInfo>(
              key: GlobalKey<ScaffoldState>(),
              items: selectedTagInfos!,
              areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
              onReorderFinished: (item, from, to, newItems) {
                setState(() {
                  selectedTagInfos!
                    ..clear()
                    ..addAll(newItems);
                });
              },
              itemBuilder: (context, itemAnimation, item, index) {
                return Reorderable(
                  key: ValueKey(item),
                  builder: (context, dragAnimation, inDrag) {
                    final t = dragAnimation.value;
                    final elevation = lerpDouble(0, 8, t);
                    final color = Color.lerp(
                        Colors.white, Colors.white.withOpacity(0.8), t);

                    return SizeFadeTransition(
                      sizeFraction: 0.7,
                      curve: Curves.easeInOut,
                      animation: itemAnimation,
                      child: Material(
                          color: color,
                          elevation: elevation!,
                          type: MaterialType.transparency,
                          child: Slidable(
                            actionPane: const SlidableBehindActionPane(),
                            child: ListTile(
                              leading: GlobalFun.clipOvalIcon(Icons.clear, () {
                                setState(() {
                                  this.tagInfos!.add(item.copy());
                                  this.selectedTagInfos!.remove(item);
                                  this.tagInfos!.sort(
                                      (a, b) => a.orders!.compareTo(b.orders!));
                                });
                              }),
                              //title: Text(item.desc),
                              title: Wrap(
                                spacing: 3,
                                children: [
                                  WidgetTextWidget(
                                    property: item.property,
                                    data: item.data,
                                  ),
                                  Text(item.desc == null ? "" : item.desc!),
                                ],
                              ),
                              trailing: Handle(
                                delay: const Duration(milliseconds: 100),
                                child: Icon(
                                  Icons.list,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                );
              },
              footer: FBListViewWidget.buildFooter(context,
                  icon: Icons.add, title: "Add a tag", onTap: () {
                GlobalFun.showBottomSheetCommon(
                    context,
                    SingleChildScrollView(
                      child: new ImplicitlyAnimatedReorderableList<TagInfo>(
                        key: GlobalKey<ScaffoldState>(),
                        items: tagInfos!,
                        areItemsTheSame: (TagInfo oldItem, TagInfo newItem) =>
                            oldItem.id == newItem.id,
                        onReorderFinished: (TagInfo item, int? from, int to, List<TagInfo> newItems) {
                          // Remember to update the underlying data when the list has been
                          // reordered.
                          setState(() {
                            tagInfos!
                              ..clear()
                              ..addAll(newItems);
                          });
                        },
                        itemBuilder: (context, itemAnimation, item, index) {
                          return Reorderable(
                            key: ValueKey(item),
                            builder: (context, dragAnimation, inDrag) {
                              final t = dragAnimation.value;
                              final elevation = lerpDouble(0, 8, t);
                              final color = Color.lerp(Colors.white,
                                  Colors.white.withOpacity(0.8), t);

                              return SizeFadeTransition(
                                sizeFraction: 0.7,
                                curve: Curves.easeInOut,
                                animation: itemAnimation,
                                child: Material(
                                    color: color,
                                    elevation: elevation!,
                                    type: MaterialType.transparency,
                                    child: Slidable(
                                      actionPane:
                                          const SlidableBehindActionPane(),
                                      child: ListTile(
                                        leading: GlobalFun.clipOvalIcon(
                                            Icons.add, () {
                                          setState(() {
                                            this
                                                .selectedTagInfos!
                                                .add(item.copy());
                                            this.tagInfos!.remove(item);
                                            Navigator.pop(context);
                                          });
                                        }),
                                        //title: Text(item.desc),
                                        title: Wrap(
                                          spacing: 4,
                                          children: [
                                            WidgetTextWidget(
                                              property: item.property,
                                              data: item.data,
                                            ),
                                            Text(item.desc == null? "" : item.desc!)
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            },
                          );
                        },
                        shrinkWrap: true,
                      ),
                    ));
              }),
              shrinkWrap: true,
            ),

            //),
          ),
        ),
        // Expanded(
        //   //flex: 5,
        //   child: Container(
        //     color:Color(0xEDE7F6),
        //     width: double.infinity,
        //     child:
        //     SingleChildScrollView(
        //
        //       child: new ImplicitlyAnimatedReorderableList<TagInfo>(
        //         key: GlobalKey<ScaffoldState>(),
        //         items: tagInfos,
        //         areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
        //         onReorderFinished: (item, from, to, newItems) {
        //           // Remember to update the underlying data when the list has been
        //           // reordered.
        //           setState(() {
        //             tagInfos
        //               ..clear()
        //               ..addAll(newItems);
        //           });
        //         },
        //         itemBuilder: (context, itemAnimation, item, index) {
        //           return Reorderable(
        //             key: ValueKey(item),
        //             builder: (context, dragAnimation, inDrag) {
        //               final t = dragAnimation.value;
        //               final elevation = lerpDouble(0, 8, t);
        //               final color = Color.lerp(
        //                   Colors.white, Colors.white.withOpacity(0.8), t);
        //
        //               return SizeFadeTransition(
        //                 sizeFraction: 0.7,
        //                 curve: Curves.easeInOut,
        //                 animation: itemAnimation,
        //                 child: Material(
        //                     color: color,
        //                     elevation: elevation,
        //                     type: MaterialType.transparency,
        //                     child: Slidable(
        //                       actionPane: const SlidableBehindActionPane(),
        //                       //actions: [getSlideActionDelete(context, () {})],
        //                       child: ListTile(
        //                           leading: GlobalFun.ClipOvalIcon(Icons.add, () {
        //                             setState(() {
        //                               this.selectedTagInfos.add(item.copy());
        //                               this.tagInfos.remove(item);
        //                             });
        //                           }),
        //                           title: Text(item.desc),
        //                           subtitle: Wrap(
        //                             children: [
        //                               WidgetTextPage.build(
        //                                 context,
        //                                 item.property,
        //                                 item.data,
        //                               ),
        //                             ],
        //                           ),
        //
        //                       ),
        //                     )),
        //               );
        //             },
        //           );
        //         },
        //         // Since version 0.2.0 you can also display a widget
        //         // before the reorderable items...
        //         // header: Container(
        //         //   height: 200,
        //         //   color: Colors.red,
        //         // ),
        //         // // ...and after. Note that this feature - as the list itself - is still in beta!
        //         footer: Container(
        //           height: 50,
        //           color: Colors.green,
        //         ),
        //         // If you want to use headers or footers, you should set shrinkWrap to true
        //         shrinkWrap: true,
        //       ),
        //
        //     ),
        //   ),
        // ),
      ],
    ));

    // return Scaffold(
    //   body: GestureDetector(
    //     behavior: HitTestBehavior.translucent,
    //     onTap: () {
    //       // 点击空白页面关闭键盘
    //       FocusScope.of(context).requestFocus(_blankNode);
    //     },
    //     child: ListView(controller: scrollController, children: [
    //       Wrap(
    //         spacing: 3,
    //         children: [
    //
    //           for(TagInfo item in this.selectedTagInfos)
    //             WidgetTextPage.build(
    //               context,
    //               item.property,
    //               item.data,
    //             )
    //         ],
    //       ),
    //       new ImplicitlyAnimatedReorderableList<TagInfo>(
    //         items: tagInfos,
    //         areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
    //         onReorderFinished: (item, from, to, newItems) {
    //           // Remember to update the underlying data when the list has been
    //           // reordered.
    //           setState(() {
    //             tagInfos
    //               ..clear()
    //               ..addAll(newItems);
    //           });
    //         },
    //         itemBuilder: (context, itemAnimation, item, index) {
    //           return Reorderable(
    //             key: ValueKey(item),
    //             builder: (context, dragAnimation, inDrag) {
    //               final t = dragAnimation.value;
    //               final elevation = lerpDouble(0, 8, t);
    //               final color = Color.lerp(
    //                   Colors.white, Colors.white.withOpacity(0.8), t);
    //
    //               return SizeFadeTransition(
    //                 sizeFraction: 0.7,
    //                 curve: Curves.easeInOut,
    //                 animation: itemAnimation,
    //                 child: Material(
    //                     color: color,
    //                     elevation: elevation,
    //                     type: MaterialType.transparency,
    //                     child: Slidable(
    //                       actionPane: const SlidableBehindActionPane(),
    //                       //actions: [getSlideActionDelete(context, () {})],
    //                       child: ListTile(
    //                           leading: GlobalFun.ClipOvalIcon(Icons.add, () {
    //                             setState(() {
    //                               this.selectedTagInfos.add(item.copy());
    //                               this.tagInfos.remove(item);
    //                             });
    //                           }),
    //                           title: Text(item.desc),
    //                           subtitle: Wrap(
    //                             children: [
    //                               WidgetTextPage.build(
    //                                 context,
    //                                 item.property,
    //                                 item.data,
    //                               ),
    //                             ],
    //                           )),
    //                     )),
    //               );
    //             },
    //           );
    //         },
    //         // Since version 0.2.0 you can also display a widget
    //         // before the reorderable items...
    //         // header: Container(
    //         //   height: 200,
    //         //   color: Colors.red,
    //         // ),
    //         // // ...and after. Note that this feature - as the list itself - is still in beta!
    //         footer: Container(
    //           height: 50,
    //           color: Colors.green,
    //         ),
    //         // If you want to use headers or footers, you should set shrinkWrap to true
    //         shrinkWrap: true,
    //       ),
    //     ]),
    //   ),
    // );
  }

  // static Widget getSlideActionDelete(BuildContext context, Function onTap) {
  //   final theme = Theme.of(context);
  //   final textTheme = theme.textTheme;
  //
  //   return SlideAction(
  //     closeOnTap: true,
  //     color: Color.fromRGBO(255, 205, 210, 1),
  //     onTap: () {
  //       onTap();
  //     },
  //     child: Center(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           const Icon(
  //             Icons.delete,
  //             color: Colors.red,
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             'Delete',
  //             style: textTheme.bodyText2.copyWith(
  //               color: Colors.red,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
