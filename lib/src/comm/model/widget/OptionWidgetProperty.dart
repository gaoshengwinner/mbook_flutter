import 'package:flutter/material.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/wh_picker.dart';

@JsonSerializable()
@CustomColorConverter()
class OptionWidgetProperty {

  TextWidgetProperty framPr = TextWidgetProperty(paddingRight:5, minWidth: 100, minWidthUnit: enumToString(WHOptin.sw));
  TextWidgetProperty titlePr = TextWidgetProperty();

  TextWidgetProperty buttonPr = TextWidgetProperty(minHeight: 50, minWidth: 100, minWidthUnit: enumToString(WHOptin.sw));

  TextWidgetProperty buttonSelectPr = TextWidgetProperty(minHeight: 50);


}

class FrameProperty{

  Color backColor = Colors.white;

  FrameProperty({this.backColor});
}


class OptionBean{
  String mainTitle;
  String subTitle;
  int price;

}
