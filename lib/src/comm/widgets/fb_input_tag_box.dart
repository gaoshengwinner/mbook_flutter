import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FBInputTagBox extends StatelessWidget {
  final String lableText;
  final List<TagInfo>? tags;
  final List<TagInfo>? selectedTags;
  final Function onSelected;
  final double? width;

  FBInputTagBox(
      {required this.lableText,
      this.tags,
      this.selectedTags,
      required this.onSelected,
      this.width});

  @override
  Widget build(BuildContext context) {
    double _width = width == null ? double.maxFinite : width!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          child: Text(
            lableText,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: G.appBaseColor[0]),
          ),
        ),
        Container(
          width: _width,
          constraints: BoxConstraints(
            minHeight: 30,
          ),
          child: GestureDetector(
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                width: 0.8.sw,
                child: Wrap(
                  spacing: 4,
                  children: [
                    if (selectedTags != null)
                      for (TagInfo tag in selectedTags!)
                        WidgetTextWidget(
                          property: tag.property,
                          data: tag.data,
                        )
                  ],
                )),
            onTap: () {
              GlobalFun.openEditTagPage(
                  context, tags, selectedTags, onSelected);
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
