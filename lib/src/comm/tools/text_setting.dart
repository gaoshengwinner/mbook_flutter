import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/extension/extension.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ListHelper.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/color_picker.dart';
import 'package:mbook_flutter/src/comm/tools/group.dart';
import 'package:mbook_flutter/src/comm/tools/item.dart';
import 'package:mbook_flutter/src/comm/tools/wh_picker.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';

class TextSettingWidget extends StatefulWidget {
  TextSettingWidget({this.property, this.onChange, this.data});

  TextWidgetProperty property;
  Function onChange;
  String data;

  @override
  _TextSettingWidget createState() => _TextSettingWidget(
      property: this.property, onChange: this.onChange, data: this.data);
}

class _TextSettingWidget extends State<TextSettingWidget>
    with SingleTickerProviderStateMixin {
  _TextSettingWidget({this.property, this.onChange, this.data}) {
    if (property == null || !(property is TextWidgetProperty)) {
      this.property = TextWidgetProperty();
    }
    if (data == null || !(data is String)) {
      this.data = "Hello word";
    }
  }

  Function onChange;
  String data;
  TextWidgetProperty property =
      TextWidgetProperty(backColor: Colors.white, fullLineDisp: false);

  static ListHelper _list_size = ListHelper(10, 128, b: 2);
  static ListHelper _list_font_Weight = ListHelper(100, 900, b: 100);
  static ListHelper _list_Letter_space = ListHelper(0, 30);
  static ListHelper _list_Padding_left = ListHelper(0, 256);
  static ListHelper _list_Padding_top = _list_Padding_left;
  static ListHelper _list_Padding_right = _list_Padding_left;
  static ListHelper _list_Padding_bottom = _list_Padding_left;
  static ListHelper _list_Border_Width = ListHelper(0, 256);
  static ListHelper _list_Border_Radius = ListHelper(0, 256);

  static ListHelper _list_Margin_Left = ListHelper(0, 256);
  static ListHelper _list_Margin_Top = _list_Margin_Left;
  static ListHelper _list_Margin_right = _list_Margin_Left;
  static ListHelper _list_Margin_bottom = _list_Margin_Left;

  static ListHelper _list_Shadow_Offset = ListHelper(-256, 256);
  static ListHelper _list_Shadow_blurRadius = ListHelper(0, 256);
  static ListHelper _list_Shadow_spreadRadius = _list_Shadow_blurRadius;

  static List<Text> _list_TextAlign = FBTextAlign.toTextList();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(() {
      fn();
    });
    if (onChange != null) {
      onChange(property);
    }
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    List<Widget> prs = [];
    prs.addAll(_baseSetting(context));
    prs.addAll(_paddingSetting(context));
    prs.addAll(_marginSetting(context));
    prs.addAll(_borderSetting(context));
    prs.addAll(_sgadowSetting(context));
    prs.addAll(_otherSetting(context));

    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            width: 1.sw - 5,
            height: 100,
            child: Center(
              child: WidgetTextPage.build(context, property, data),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: Color(0xEDE7F6),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: prs),
            ),
          ),
        )
      ],
    ));
  }

  List<Widget> _otherSetting(BuildContext context) {
    return [
      SettingsGroup(<Widget>[
        SettingsItem(
          label: "Width",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showBottomSheet(
                context,
                [WHPickerPage(property.minWidth, property.minWidthUnit, (value, util, utilTitle) {
                    setState(() {
                      property.minWidth = value;
                      property.minWidthUnit = util;
                    });
                })],
                property.shadowColor);
          },
          value: Text("${property.minWidth.toInt()}${getUnitTitle(property.minWidthUnit)}"),
        ),
        SettingsItem(
          label: "Height",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showBottomSheet(
                context,
                [WHPickerPage(property.minHeight, property.minHeightUnit, (value, util, utilTitle) {
                  setState(() {
                    property.minHeight = value;
                    property.minHeightUnit = util;
                  });
                })],
                property.shadowColor);
          },
          value: Text("${property.minHeight.toInt()}${getUnitTitle(property.minHeightUnit)}"),
        ),


        // SettingsItem(
        //   label: "Height",
        //   type: SettingsItemType.modal,
        //   hasDetails: true,
        //   onPress: () {
        //     GlobalFun.showPicker(
        //         context,
        //         _list_min.getIndexByValue(property.minHeight.toInt()),
        //         _list_min.list(), (value) {
        //       setState(() {
        //         property.minHeight = _list_min
        //             .values()[value.toInt()]
        //             .toDouble(); //value.toDouble();
        //       });
        //     });
        //   },
        //   value: Text("${property.minHeight.toInt()}"),
        // ),
      ]),
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Text alignment",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  FBAlignment.getIndexByString(property.alignment),
                  FBAlignment.getAligmentList(), (value) {
                setState(() {
                  property.alignment =
                      FBAlignment.getAligmentList()[value.toInt()].data;
                });
              });
            },
            value: Text("${property.alignment}"),
          ),
          SettingsItem(
            label: "Backgroup Alignment",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  FBAlignment.getIndexByString(property.backalignment),
                  FBAlignment.getAligmentList(), (value) {
                setState(() {
                  property.backalignment =
                      FBAlignment.getAligmentList()[value.toInt()].data;
                });
              });
            },
            value: Text("${property.backalignment}"),
          ),
        ],
        header: Text(""),
      )
    ];
  }

//maxHeight
  List<Widget> _sgadowSetting(BuildContext context) {
    return
        // new Container(
        //   child: Column(children:
        //
        [
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "X",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Shadow_Offset
                      .getIndexByValue(property.shadowOffsetX.toInt()),
                  _list_Shadow_Offset.list(), (value) {
                setState(() {
                  property.shadowOffsetX = _list_Shadow_Offset
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.shadowOffsetX.toInt()}"),
          ),
          SettingsItem(
            label: "Y",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Shadow_Offset
                      .getIndexByValue(property.shadowOffsetY.toInt()),
                  _list_Shadow_Offset.list(), (value) {
                setState(() {
                  property.shadowOffsetY = _list_Shadow_Offset
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.shadowOffsetY.toInt()}"),
          ),
        ],
        header: Text("Border Offset"),
      ),
      SettingsGroup(<Widget>[
        SettingsItem(
          label: 'Border Color',
          icon: Icon(Icons.color_lens_outlined, color: property.shadowColor),
          hasDetails: true,
          type: SettingsItemType.modal,
          onPress: () {
            GlobalFun.showBottomSheet(
                context,
                [
                  ColorPickerPage(
                      currentColor: property.shadowColor,
                      onColorChange: (value) {
                        setState(() {
                          property.shadowColor = value;
                        });
                      })
                ],
                property.shadowColor);
          },
        ),
        SettingsItem(
          label: "Border Blur radius",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_Shadow_blurRadius
                    .getIndexByValue(property.shadowBlurRadius.toInt()),
                _list_Shadow_blurRadius.list(), (value) {
              setState(() {
                property.shadowBlurRadius = _list_Shadow_blurRadius
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            });
          },
          value: Text("${property.shadowBlurRadius.toInt()}"),
        ),
        SettingsItem(
          label: "Border Spread radius",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_Shadow_spreadRadius
                    .getIndexByValue(property.shadowSpreadRadius.toInt()),
                _list_Shadow_spreadRadius.list(), (value) {
              setState(() {
                property.shadowSpreadRadius = _list_Shadow_spreadRadius
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            });
          },
          value: Text("${property.shadowSpreadRadius.toInt()}"),
        ),
      ])
    ];
    //
    // ));
  }

  List<Widget> _borderSetting(BuildContext context) {
    return
        // new Container(
        // child: Column(
        //   children:
        [
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Border Width",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Border_Width
                      .getIndexByValue(property.borderWidth.toInt()),
                  _list_Border_Width.list(), (value) {
                setState(() {
                  property.borderWidth = _list_Border_Width
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.borderWidth.toInt()}"),
          ),
          SettingsItem(
            label: 'Background',
            icon: Icon(Icons.color_lens_outlined, color: property.borderColor),
            hasDetails: true,
            type: SettingsItemType.modal,
            onPress: () {
              GlobalFun.showBottomSheet(
                  context,
                  [
                    ColorPickerPage(
                        currentColor: property.borderColor,
                        onColorChange: (value) {
                          setState(() {
                            property.borderColor = value;
                          });
                        })
                  ],
                  property.borderColor);
            },
          ),
        ],
        header: Text("Border"),
      ),
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Top left",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Border_Radius
                      .getIndexByValue(property.borderRadiusTopLeft.toInt()),
                  _list_Border_Radius.list(), (value) {
                setState(() {
                  property.borderRadiusTopLeft = _list_Border_Radius
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.borderRadiusTopLeft.toInt()}"),
          ),
          SettingsItem(
            label: "Top right",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Border_Radius
                      .getIndexByValue(property.borderRadiusTopRight.toInt()),
                  _list_Border_Radius.list(), (value) {
                setState(() {
                  property.borderRadiusTopRight = _list_Border_Radius
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.borderRadiusTopRight.toInt()}"),
          ),
          SettingsItem(
            label: "Bottom left",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Border_Radius
                      .getIndexByValue(property.borderRadiusBottomLeft.toInt()),
                  _list_Border_Radius.list(), (value) {
                setState(() {
                  property.borderRadiusBottomLeft = _list_Border_Radius
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.borderRadiusBottomLeft.toInt()}"),
          ),
          SettingsItem(
            label: "Bottom right",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Border_Radius.getIndexByValue(
                      property.borderRadiusBottomRight.toInt()),
                  _list_Border_Radius.list(), (value) {
                setState(() {
                  property.borderRadiusBottomRight = _list_Border_Radius
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.borderRadiusBottomRight.toInt()}"),
          ),
        ],
        header: Text("Radius"),
      ),
    ];
    //     ,
    //   ),
    // );
  }

  List<Widget> _paddingSetting(BuildContext context) {
    return
        // new Container(
        // child: Column(
        //   children:
        [
      SettingsGroup(<Widget>[
        SettingsItem(
          label: "Letter space",
          type: SettingsItemType.modal,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_Letter_space
                    .getIndexByValue(property.letterSpacing.toInt()),
                _list_Letter_space.list(), (value) {
              setState(() {
                property.letterSpacing = _list_Letter_space
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            });
          },
          value: Text("${property.letterSpacing.toInt()}"),
        ),
      ]),
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Left",
            type: SettingsItemType.modal,
            value: Text("${property.paddingLeft.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Padding_left
                      .getIndexByValue(property.paddingLeft.toInt()),
                  _list_Padding_left.list(), (value) {
                setState(() {
                  property.paddingLeft = _list_Padding_left
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Top",
            type: SettingsItemType.modal,
            value: Text("${property.paddingTop.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Padding_top
                      .getIndexByValue(property.paddingTop.toInt()),
                  _list_Padding_top.list(), (value) {
                setState(() {
                  property.paddingTop = _list_Padding_top
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Right",
            type: SettingsItemType.modal,
            value: Text("${property.paddingRight.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Padding_right
                      .getIndexByValue(property.paddingRight.toInt()),
                  _list_Padding_right.list(), (value) {
                setState(() {
                  property.paddingRight = _list_Padding_right
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Bottem",
            type: SettingsItemType.modal,
            value: Text("${property.paddingBottom.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Padding_bottom
                      .getIndexByValue(property.paddingBottom.toInt()),
                  _list_Padding_bottom.list(), (value) {
                setState(() {
                  property.paddingBottom = _list_Padding_bottom
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
        ],
        header: Text("Padding"),
      )
    ];
    //     ,
    //   ),
    // );
  }

  List<Widget> _marginSetting(BuildContext context) {
    return
        // new Container(
        // child: Column(
        //   children:
        [
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Left",
            type: SettingsItemType.modal,
            value: Text("${property.marginLeft.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Margin_Left
                      .getIndexByValue(property.marginLeft.toInt()),
                  _list_Margin_Left.list(), (value) {
                setState(() {
                  property.marginLeft = _list_Margin_Left
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Top",
            type: SettingsItemType.modal,
            value: Text("${property.marginTop.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Margin_Top.getIndexByValue(property.marginTop.toInt()),
                  _list_Margin_Top.list(), (value) {
                setState(() {
                  property.marginTop = _list_Margin_Top
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Right",
            type: SettingsItemType.modal,
            value: Text("${property.marginRight.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Margin_right
                      .getIndexByValue(property.marginRight.toInt()),
                  _list_Margin_right.list(), (value) {
                setState(() {
                  property.marginRight = _list_Margin_right
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Bottem",
            type: SettingsItemType.modal,
            value: Text("${property.marginBottom.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_Margin_bottom
                      .getIndexByValue(property.marginBottom.toInt()),
                  _list_Margin_bottom.list(), (value) {
                setState(() {
                  property.marginBottom = _list_Margin_bottom
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
          ),
        ],
        header: Text("Margin"),
      )
    ];
    //     ,
    //   ),
    // );
  }

  List<Widget> _baseSetting(BuildContext context) {
    // return new Container(
    //   child: Column(
    //     children: [
    return [
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: 'Background Color',
            icon: Icon(Icons.color_lens_outlined, color: property.backColor),
            hasDetails: true,
            type: SettingsItemType.modal,
            onPress: () {
              GlobalFun.showBottomSheet(
                  context,
                  [
                    ColorPickerPage(
                        currentColor: property.backColor,
                        onColorChange: (value) {
                          setState(() {
                            property.backColor = value;
                          });
                        })
                  ],
                  property.backColor);
            },
          ),
          SettingsItem(
            label: 'Text Color',
            icon: Icon(Icons.color_lens_outlined, color: property.textColor),
            hasDetails: true,
            type: SettingsItemType.modal,
            onPress: () {
              GlobalFun.showBottomSheet(
                  context,
                  [
                    ColorPickerPage(
                        currentColor: property.textColor,
                        onColorChange: (value) {
                          setState(() {
                            property.textColor = value;
                          });
                        })
                  ],
                  property.backColor);
            },
          ),
        ],
        //header: Text('Color'),
      ),
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Size",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_size.getIndexByValue(property.fontSize.toInt()),
                  _list_size.list(), (value) {
                setState(() {
                  property.fontSize = _list_size
                      .values()[value.toInt()]
                      .toDouble(); //value.toDouble();
                });
              });
            },
            value: Text("${property.fontSize.toInt()}"),
          ),
          SettingsItem(
            label: "Weight",
            type: SettingsItemType.modal,
            hasDetails: true,
            value: Text("${property.fontWeight.toInt()}"),
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  _list_font_Weight
                      .getIndexByValue(property.fontWeight.toInt()),
                  _list_font_Weight.list(), (value) {
                setState(() {
                  property.fontWeight = _list_font_Weight
                      .values()[value.toInt()]; //value.toDouble();
                });
              });
            },
          ),
          SettingsItem(
            label: "Italic",
            type: SettingsItemType.toggle,
            value: CupertinoSwitch(
              activeColor: G.appBaseColor[0],
              value: property.italic,
              onChanged: (bool value) {
                setState(() {
                  property.italic = value;
                });
              },
            ),
          )
        ],
        header: Text('Font'),
      ),
      SettingsGroup(
        <Widget>[
          SettingsItem(
            label: "Text align",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              GlobalFun.showPicker(
                  context,
                  FBTextAlign.getIndexByValue(property.textTextAlign),
                  _list_TextAlign, (value) {
                setState(() {
                  property.textTextAlign = _list_TextAlign[value.toInt()].data;
                });
              });
            },
            value: Text("${property.textTextAlign}"),
          ),
        ],
        header: Text(''),
      ),
    ];
  }

  Widget _fontSetting(BuildContext context) {
    return new Container();
  }
}
