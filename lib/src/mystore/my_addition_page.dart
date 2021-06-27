import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/AdditionInfoManaWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_active_title.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_additioninfo_mana.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_htmltext.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_webview.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_youtuber.dart';

class MyAdditionPage extends StatefulWidget {
  AdditionalMana addtionInfoMana = new AdditionalMana();

  MyAdditionPage({this.addtionInfoMana});

  _MyAdditionPageState createState() => _MyAdditionPageState();
}

class _MyAdditionPageState extends State<MyAdditionPage> {
  SwitchItem _nowExpanded = SwitchItem.none;

  SwitchItem reserSWTexts(SwitchItem switchItem) {
    return switchItem != SwitchItem.texts ? SwitchItem.texts : SwitchItem.none;
  }

  SwitchItem reserSWPicturs(SwitchItem switchItem) {
    return switchItem != SwitchItem.picturs
        ? SwitchItem.picturs
        : SwitchItem.none;
  }

  SwitchItem reserSWVideos(SwitchItem switchItem) {
    return switchItem != SwitchItem.videos
        ? SwitchItem.videos
        : SwitchItem.none;
  }

  SwitchItem reserSWHtmls(SwitchItem switchItem) {
    return switchItem != SwitchItem.htmlTexts
        ? SwitchItem.htmlTexts
        : SwitchItem.none;
  }

  SwitchItem reserSWWebViewUrl(SwitchItem switchItem) {
    return switchItem != SwitchItem.webViewUrl
        ? SwitchItem.webViewUrl
        : SwitchItem.none;
  }

  @override
  Widget build(BuildContext context) {
    List simpleTexts = getCanUseList(widget.addtionInfoMana.simpleTexts);
    List htmlTexts = getCanUseList(widget.addtionInfoMana.htmlTexts);
    List pictures = getCanUseList(widget.addtionInfoMana.pictures);
    List videos = getCanUseList(widget.addtionInfoMana.videos);
    List webViews = getCanUseList(widget.addtionInfoMana.webViews);

    return Container(
      color: Color(0xFFEFEFF4),
      child: Scrollbar(
        child: ListView(
          children: [
            Container(
              color: Color(0xFFEFEFF4),
              child: Column(
                children: [
                  ActiveTitle(
                    expand: _nowExpanded == SwitchItem.texts,
                    title: "Texts" +
                        "(" +
                        (simpleTexts?.length ?? 0).toString() +
                        ")",
                    titleIcon: Icons.text_snippet_outlined,
                    infos: widget.addtionInfoMana.simpleTexts,
                    onSetting: (infos) {
                      setState(() {
                        widget.addtionInfoMana.simpleTexts = infos;
                      });
                    },
                    onTap: (expanded) {
                      setState(() {
                        _nowExpanded = reserSWTexts(_nowExpanded);
                      });
                    },
                  ),
                  if (SwitchItem.texts == _nowExpanded && simpleTexts != null)
                    new Column(
                        children: simpleTexts.map((item) {
                      return Container(
                        color: Colors.white,
                        child: Card(
                          color: Color(0xFFEFEFF4),
                          child: ListTile(
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey,
                                child: Text('${item.no}'),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            subtitle: Container(
                              constraints: BoxConstraints(
                                minHeight: 40,
                              ),
                              child: GlobalFun.fbInputBox(
                                  context, null, item.value, (value) {
                                setState(() {
                                  item.value = value;
                                });
                              }, width: 0.9.sw),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                  ActiveTitle(
                    expand: _nowExpanded == SwitchItem.htmlTexts,
                    title: "Html texts" +
                        "(" +
                        (htmlTexts?.length ?? 0).toString() +
                        ")",
                    titleIcon: Zocial.html5,
                    infos: widget.addtionInfoMana.htmlTexts,
                    onSetting: (infos) {
                      setState(() {
                        widget.addtionInfoMana.htmlTexts = infos;
                      });
                    },
                    onTap: (expanded) {
                      setState(() {
                        _nowExpanded = reserSWHtmls(_nowExpanded);
                      });
                    },
                  ),
                  if (SwitchItem.htmlTexts == _nowExpanded && htmlTexts != null)
                    new Column(
                        children: htmlTexts.map((item) {
                      return Container(
                        color: Colors.white,
                        child: Card(
                          color: Color(0xFFEFEFF4),
                          child: ListTile(
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey,
                                child: Text('${item.no}'),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            subtitle: Container(
                              constraints: BoxConstraints(
                                minHeight: 40,
                              ),
                              child: GlobalFun.fbInputBox(
                                  context, null, item.value, (value) {
                                setState(() {
                                  item.value = value;
                                });
                              },
                                  valueWidget: FBHtmlTextView(
                                    src: item.value,
                                  ),
                                  width: 0.9.sw),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                  ActiveTitle(
                    expand: _nowExpanded == SwitchItem.picturs,
                    title: "Pictures" +
                        "(" +
                        (pictures?.length ?? 0).toString() +
                        ")",
                    titleIcon: Icons.picture_in_picture_outlined,
                    infos: widget.addtionInfoMana.pictures,
                    onSetting: (infos) {
                      setState(() {
                        widget.addtionInfoMana.pictures = infos;
                      });
                    },
                    onTap: (expanded) {
                      setState(() {
                        _nowExpanded = reserSWPicturs(_nowExpanded);
                      });
                    },
                  ),
                  if (SwitchItem.picturs == _nowExpanded && pictures != null)
                    new Column(
                        children: pictures.map((item) {
                      return Container(
                        color: Colors.white,
                        child: Card(
                          color: Color(0xFFEFEFF4),
                          child: ListTile(
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey,
                                child: Text('${item.no}'),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            subtitle: Container(
                              constraints: BoxConstraints(
                                minHeight: 40,
                              ),
                              child: GlobalFun.fbInputBox(
                                  context, null, item.value, (value) {
                                setState(() {
                                  item.value = value;
                                });
                              },
                                  valueWidget: Row(children: [
                                    Flexible(
                                        child: item.value?.isEmpty ?? true
                                            ? Text("")
                                            : new MBImage(url: item.value))
                                  ]),
                                  width: 0.9.sw),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                  ActiveTitle(
                    expand: _nowExpanded == SwitchItem.values,
                    title:
                        "Videos" + "(" + (videos?.length ?? 0).toString() + ")",
                    titleIcon: Icons.video_collection_outlined,
                    infos: widget.addtionInfoMana.videos,
                    onSetting: (infos) {
                      setState(() {
                        widget.addtionInfoMana.videos = infos;
                      });
                    },
                    onTap: (expanded) {
                      setState(() {
                        _nowExpanded = reserSWVideos(_nowExpanded);
                      });
                    },
                  ),
                  if (SwitchItem.videos == _nowExpanded && videos != null)
                    new Column(
                        children: videos.map((item) {
                      return Container(
                        color: Colors.white,
                        child: Card(
                          color: Color(0xFFEFEFF4),
                          child: ListTile(
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey,
                                child: Text('${item.no}'),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            subtitle: Container(
                              constraints: BoxConstraints(
                                minHeight: 40,
                              ),
                              child: GlobalFun.fbInputBox(
                                  context, null, item.value, (value) {
                                if (mounted)
                                  setState(() {
                                    item.value = value;
                                  });
                              },
                                  valueWidget:
                                      FbYoutubeWidget(item.value, 0.8.sw),
                                  width: 0.9.sw),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                  ActiveTitle(
                    expand: _nowExpanded == SwitchItem.webViewUrl,
                    title: "Web views" +
                        "(" +
                        (webViews?.length ?? 0).toString() +
                        ")",
                    titleIcon: MaterialCommunityIcons.web,
                    infos: widget.addtionInfoMana.webViews,
                    onSetting: (infos) {
                      setState(() {
                        widget.addtionInfoMana.webViews = infos;
                      });
                    },
                    onTap: (expanded) {
                      setState(() {
                        _nowExpanded = reserSWWebViewUrl(_nowExpanded);
                      });
                    },
                  ),
                  if (SwitchItem.webViewUrl == _nowExpanded && webViews != null)
                    new Column(
                        children: webViews.map((item) {
                      return Container(
                        color: Colors.white,
                        child: Card(
                          color: Color(0xFFEFEFF4),
                          child: ListTile(
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey,
                                child: Text('${item.no}'),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            subtitle: Container(
                              constraints: BoxConstraints(
                                minHeight: 40,
                              ),
                              child: GlobalFun.fbInputBox(
                                  context, null, item.value, (value) {
                                setState(() {
                                  item.value = value;
                                });
                              },
                                  valueWidget:
                                      FBWebView(initialUrl: item.value),
                                  width: 0.9.sw),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List getCanUseList(List<AdditionalInfo> list) {
    if (list == null || list.length == 0) {
      return null;
    }
    List result = list.where((element) => element.canBeUse).toList();
    return (list == null || list.length == 0) ? null : result;
  }
}
