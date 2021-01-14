import 'dart:core';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/extension/extension.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ListHelper.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/MyCupertinoRadioChoice.dart';
import 'package:mbook_flutter/src/comm/tools/color_picker.dart';
import 'package:mbook_flutter/src/comm/tools/group.dart';
import 'package:mbook_flutter/src/comm/tools/header.dart';
import 'package:mbook_flutter/src/comm/tools/item.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:settings_ui/settings_ui.dart';

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

  static ListHelper _list_Shadow_Offset = ListHelper(-256, 256);
  static ListHelper _list_Shadow_blurRadius = ListHelper(0, 256);
  static ListHelper _list_Shadow_spreadRadius = _list_Shadow_blurRadius;

  static ListHelper _list_min = ListHelper(0, 1024);

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

  String selected = _TAB_Base;

// create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  static const String _TAB_Base = "Base info";
  static const String _TAB_Padding = "Padding";
  static const String _TAB_Border = "Border";
  static const String _TAB_Shadow = "Shadow";
  static const String _TAB_Other = "Other";

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.85.sh,
        child: new Column(children: [
          Container(
            width: 1.sw - 5,
            height: 100,
            child: Center(
              // margin: EdgeInsets.only(top: 5),
              //width: 1.sw - 5,
              // height: 150,
              //child: //Align(
              //alignment: Alignment.center,
              child: WidgetTextPage(data, property),
              // ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: MyCupertinoRadioChoice(
                //selectedColor: G.appBaseColor[0].withOpacity(0.7),
                //notSelectedColor: Colors.grey.withOpacity(0.5),
                choices: {
                  _TAB_Base: _TAB_Base,
                  _TAB_Padding: _TAB_Padding,
                  _TAB_Border: _TAB_Border,
                  _TAB_Shadow: _TAB_Shadow,
                  _TAB_Other: _TAB_Other
                },
                onChange: (selectedGender) {
                  setState(() {
                    selected = selectedGender;
                  });
                  //print(selected);
                },
                initialKeyValue: _TAB_Base),
          ),
          if (selected == _TAB_Base) _baseSetting(context),
          if (selected == _TAB_Padding) _paddingSetting(context),
          if (selected == _TAB_Border) _borderSetting(context),
          if (selected == _TAB_Shadow) _sgadowSetting(context),
          if (selected == _TAB_Other) _otherSetting(context),
        ]));
  }

  Widget _otherSetting(BuildContext context) {
    return new Container(
        child: Column(children: [
      SettingsGroup(<Widget>[
        SettingsItem(
          label: "Min Width",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_min.getIndexByValue(property.minWidth.toInt()),
                _list_min.list(), (value) {
              setState(() {
                property.minWidth = _list_min
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            });
          },
          value: Text("${property.minWidth.toInt()}"),
        ),
        SettingsItem(
          label: "Min Height",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_min.getIndexByValue(property.minHeight.toInt()),
                _list_min.list(), (value) {
              setState(() {
                property.minHeight = _list_min
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            });
          },
          value: Text("${property.minHeight.toInt()}"),
        ),
        SettingsItem(
          label: "Max width",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_min.getIndexByValue(property.maxWidth.toInt()),
                _list_min.list(), (value) {
              setState(() {
                property.maxWidth = _list_min
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            });
          },
          value: Text("${property.maxWidth.toInt()}"),
        ),
        SettingsItem(
          label: "Max height",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () {
            GlobalFun.showPicker(
                context,
                _list_min.getIndexByValue(property.maxHeight.toInt()),
                _list_min.list(), (value) {
              setState(() {
                property.maxHeight =
                    _list_min.values()[value.toInt()].toDouble();
              });
            });
          },
          value: Text("${property.maxHeight.toInt()}"),
        ),
      ]),
      SettingsGroup(<Widget>[
        SettingsItem(
          label: "Alignment",
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
      ],header: Text(""),)
    ]));
  }

//maxHeight
  Widget _sgadowSetting(BuildContext context) {
    return new Container(
        child: Column(children: [
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
        header: Text("Offset"),
      ),
      SettingsGroup(<Widget>[
        SettingsItem(
          label: 'Color',
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
          label: "Blur radius",
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
          label: "Spread radius",
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
    ]));
  }

  Widget _borderSetting(BuildContext context) {
    return new Container(
      child: Column(
        children: [
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
                icon: Icon(Icons.color_lens_outlined,
                    color: property.borderColor),
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
                      _list_Border_Radius.getIndexByValue(
                          property.borderRadiusTopLeft.toInt()),
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
                      _list_Border_Radius.getIndexByValue(
                          property.borderRadiusTopRight.toInt()),
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
                      _list_Border_Radius.getIndexByValue(
                          property.borderRadiusBottomLeft.toInt()),
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
        ],
      ),
    );
  }

  Widget _paddingSetting(BuildContext context) {
    return new Container(
      child: Column(
        children: [
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
        ],
      ),
    );
  }

  Widget _baseSetting(BuildContext context) {
    return new Container(
      child: Column(
        children: [
          SettingsGroup(
            <Widget>[
              SettingsItem(
                label: 'Background',
                icon:
                    Icon(Icons.color_lens_outlined, color: property.backColor),
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
                label: 'Text',
                icon:
                    Icon(Icons.color_lens_outlined, color: property.textColor),
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
            header: Text('Color'),
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
                      property.textTextAlign =
                          _list_TextAlign[value.toInt()].data;
                    });
                  });
                },
                value: Text("${property.textTextAlign}"),
              ),
            ],
            header: Text(''),
          ),
        ],
      ),
    );
  }

  Widget _fontSetting(BuildContext context) {
    return new Container();
  }
}
