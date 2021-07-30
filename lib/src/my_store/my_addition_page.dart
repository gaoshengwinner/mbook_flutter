import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/AdditionalInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/model/AdditionalMana.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_active_title.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_addition_info_mana.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_htmltext.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_input_box.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_list_group.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_webview.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_youtuber.dart';

class MyAdditionPage extends StatefulWidget {
  final AdditionalMana? addtionInfoMana;

  MyAdditionPage({this.addtionInfoMana});

  AdditionalMana get _addtionInfoMana {
    AdditionalMana tmpAddtionInfoMana = G.ifNull(
        this.addtionInfoMana,
        new AdditionalMana(
            htmlTexts: [],
            webViews: [],
            simpleTexts: [],
            pictures: [],
            videos: []));

    if (tmpAddtionInfoMana.htmlTexts == null) {
      tmpAddtionInfoMana.htmlTexts = [];
    }
    if (tmpAddtionInfoMana.webViews == null) {
      tmpAddtionInfoMana.webViews = [];
    }
    if (tmpAddtionInfoMana.simpleTexts == null) {
      tmpAddtionInfoMana.simpleTexts = [];
    }
    if (tmpAddtionInfoMana.pictures == null) {
      tmpAddtionInfoMana.pictures = [];
    }
    if (tmpAddtionInfoMana.videos == null) {
      tmpAddtionInfoMana.videos = [];
    }
    return tmpAddtionInfoMana;
  }

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
    List? simpleTexts = getCanUseList(widget._addtionInfoMana.simpleTexts);
    List? htmlTexts = getCanUseList(widget._addtionInfoMana.htmlTexts);
    List? pictures = getCanUseList(widget._addtionInfoMana.pictures);
    List? videos = getCanUseList(widget._addtionInfoMana.videos);
    List? webViews = getCanUseList(widget._addtionInfoMana.webViews);

    return Container(
      //color: Color(0xFFEFEFF4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //color: Color(0xFFEFEFF4),
              child: Column(
                children: [
                  FBListGroup(),
                  ActiveTitle(
                    isFirst: true,
                    expand: _nowExpanded == SwitchItem.texts,
                    title: "Texts" +
                        "(" +
                        (simpleTexts?.length ?? 0).toString() +
                        ")",
                    titleIcon: Icons.text_snippet_outlined,
                    infos: widget._addtionInfoMana.simpleTexts,
                    onSetting: (infos) {
                      setState(() {
                        widget._addtionInfoMana.simpleTexts = infos;
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
                        //color: Colors.white,
                        child: Card(
                          //color: Color(0xFFEFEFF4),
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
                              child: FBInputBox(
                                  value: item.value,
                                  serValue: (value) {
                                    setState(() {
                                      item.value = value;
                                    });
                                  },
                                  width: 0.9.sw),
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
                    infos: widget._addtionInfoMana.htmlTexts,
                    onSetting: (infos) {
                      setState(() {
                        widget._addtionInfoMana.htmlTexts = infos;
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
                              child: FBInputBox(
                                  value: item.value,
                                  serValue: (value) {
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
                    infos: widget._addtionInfoMana.pictures,
                    onSetting: (infos) {
                      setState(() {
                        widget._addtionInfoMana.pictures = infos;
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
                              child: FBInputBox(
                                  value: item.value,
                                  serValue: (value) {
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
                    expand: _nowExpanded == SwitchItem.videos,
                    title:
                        "Videos" + "(" + (videos?.length ?? 0).toString() + ")",
                    titleIcon: Icons.video_collection_outlined,
                    infos: widget._addtionInfoMana.videos,
                    onSetting: (infos) {
                      setState(() {
                        widget._addtionInfoMana.videos = infos;
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
                              child: FBInputBox(
                                  value: item.value,
                                  serValue: (value) {
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
                    infos: widget._addtionInfoMana.webViews,
                    onSetting: (infos) {
                      setState(() {
                        widget._addtionInfoMana.webViews = infos;
                      });
                    },
                    onTap: (expanded) {
                      setState(() {
                        _nowExpanded = reserSWWebViewUrl(_nowExpanded);
                      });
                    },
                    isBottom: true,
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
                              child: FBInputBox(
                                  value: item.value,
                                  serValue: (value) {
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

  List? getCanUseList(List<AdditionalInfo>? list) {
    if (list == null || list.length == 0) {
      return null;
    }
    List result = list
        .where(
            (element) => element.canBeUse == null ? false : element.canBeUse!)
        .toList();
    return (result.length == 0) ? null : result;
  }
}
