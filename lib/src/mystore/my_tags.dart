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

Language english = Language(
  englishName: 'English',
  nativeName: 'English',
);

Language french = Language(
  englishName: 'French',
  nativeName: 'Français',
);

Language german = Language(
  englishName: 'German',
  nativeName: 'Deutsch',
);

Language spanish = Language(
  englishName: 'Spanish',
  nativeName: 'Español',
);

Language chinese = Language(
  englishName: 'Chinese',
  nativeName: '中文',
);

Language danish = Language(
  englishName: 'Danish',
  nativeName: 'Dansk',
);

Language hindi = Language(
  englishName: 'Hindi',
  nativeName: 'हिंदी',
);

Language afrikaans = Language(
  englishName: 'Afrikaans',
  nativeName: 'Afrikaans',
);

Language portuguese0 = Language(
  englishName: 'Portuguese0',
  nativeName: 'Português',
);

Language portuguese1 = Language(
  englishName: 'Portuguese1',
  nativeName: 'Português',
);
Language portuguese2 = Language(
  englishName: 'Portuguese2',
  nativeName: 'Português',
);

Language portuguese3 = Language(
  englishName: 'Portuguese3',
  nativeName: 'Português',
);
Language portuguese4 = Language(
  englishName: 'Portuguese4',
  nativeName: 'Português',
);
Language portuguese5 = Language(
  englishName: 'Portuguese5',
  nativeName: 'Português',
);
Language portuguese6 = Language(
  englishName: 'Portuguese6',
  nativeName: 'Português',
);

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

  List<TagInfo> _AllTagInfos = new List<TagInfo>.generate(
      5,
      (i) => TagInfo(
          id: i,
          data: "test${i}",
          property: TextWidgetProperty(backColor: Colors.white)));

  //new TextWidgetProperty(backColor: Colors.white)

  final List<Language> selectedLanguages = [
    afrikaans,
    english,
    french,
    german,
    spanish,
    chinese,
    danish,
    hindi,
    portuguese0,
    portuguese1,
    portuguese2,
    portuguese4,
    portuguese5,
    portuguese6
  ];

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
            actions: [ActionOption.Delete],
            seActions: [ActionOption.Delete],
            canBeMove: true,
            createLeading: (c, r, index) {
              return SizedBox(
                width: 36,
                height: 36,
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: textTheme.bodyText2.copyWith(
                      color: theme.accentColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
            createTitle: (c, r, index) {
              return GestureDetector(
                child: Text(r.englishName),
                onTap: () {
                  GlobalFun.openEditPage(
                      context,
                      "Tag name",
                      selectedLanguages[index].englishName,
                      TextInputAction.newline,
                      TextInputType.multiline, (value) {
                    setState(() {
                      selectedLanguages[index].englishName = value;
                    });
                  });
                },
              );
            },
            createSubTitle: (c, r, index) {
              return GestureDetector(
                  child: Wrap(
                    children: [
                      WidgetTextPage.build(
                        context,
                        selectedLanguages[index].property,
                        selectedLanguages[index].englishName,
                      )
                    ],
                  ),
                  onTap: () {
                    return GlobalFun.showBottomSheet(
                        context,
                        [
                          TextSettingWidget(
                              property: selectedLanguages[index].property,
                              data: selectedLanguages[index].englishName,
                              onChange: (value) {
                                setState(() {
                                  selectedLanguages[index].property = value;
                                });
                              }),
                        ],
                        null);
                  });
            },
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
