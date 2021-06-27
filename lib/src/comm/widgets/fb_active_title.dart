import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/model/AdditionInfoManaWidget.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/widgets/Image.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_additioninfo_mana.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_htmltext.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_youtuber.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

typedef TitleTapCallBack = void Function(bool expand);

class ActiveTitle extends StatefulWidget {
  String title;
  IconData titleIcon;
  List<AdditionalInfo> infos;
  TitleTapCallBack onTap;
  OnSaveSettingCallBack onSetting;
  bool expand;

  ActiveTitle(
      {this.expand,
      this.title,
      this.titleIcon,
      this.onTap,
      this.onSetting,
      this.infos});

  _ActiveTitleState createState() => _ActiveTitleState();
}

class _ActiveTitleState extends State<ActiveTitle> {
  bool noExpand = true;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap(!noExpand);
          }
          ;
        },
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    if (widget.titleIcon != null)
                      Icon(
                        widget.titleIcon,
                      ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.title == null
                            ? Text("")
                            : Text(widget.title))
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      widget.expand ? Feather.book_open : Feather.book,
                      color: G.appBaseColor[0],
                    ),
                  ],
                )
              ],
            )),
            actions: null,
            secondaryActions: <Widget>[
              IconSlideAction(
                  // caption: 'Setting',
                  color: Colors.white,
                  foregroundColor: G.appBaseColor[0],
                  icon: Feather.settings,
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return AdditionInfoManaWidget(
                              infos: widget.infos, onSave: widget.onSetting);
                        });
                  }
                  //widget.onSetting,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
