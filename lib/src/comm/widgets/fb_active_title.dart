import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/model/AdditionalInfo.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_addition_info_mana.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mbook_flutter/src/comm/widgets/menu_title.dart';

typedef TitleTapCallBack = void Function(bool expand);

class ActiveTitle extends StatefulWidget {
  final String? title;
  final IconData? titleIcon;
  final List<AdditionalInfo>? infos;
  final TitleTapCallBack? onTap;
  final OnSaveSettingCallBack? onSetting;
  final bool? expand;
  final bool? isFirst;
  final bool? isBottom;

  ActiveTitle(
      {this.expand,
      this.title,
      this.titleIcon,
      this.onTap,
      this.onSetting,
      this.infos,
      this.isFirst,
      this.isBottom});

  _ActiveTitleState createState() => _ActiveTitleState();
}

class _ActiveTitleState extends State<ActiveTitle> {
  bool noExpand = true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      //padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!(!noExpand);
          }
        },
        child: Container(
          alignment: Alignment.topCenter,
          // decoration: BoxDecoration(
          //     border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: MenuTitle(
                icon: widget.titleIcon,
                title: G.ifNull(widget.title, ""),
                doTop: null,
                isFirst: widget.isFirst ?? false,
                isBottom: widget.isBottom ?? false),

            // Container(
            //     child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Row(
            //       children: [
            //         if (widget.titleIcon != null)
            //           Icon(
            //             widget.titleIcon,
            //           ),
            //         Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: widget.title == null
            //                 ? Text("")
            //                 : Text(widget.title == null ? "" : widget.title!))
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Icon(
            //           widget.expand == null || widget.expand! == false
            //               ? Feather.book_open
            //               : Feather.book,
            //           color: G.appBaseColor[0],
            //         ),
            //       ],
            //     )
            //   ],
            // )),
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
                              infos: widget.infos!, onSave: widget.onSetting);
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
