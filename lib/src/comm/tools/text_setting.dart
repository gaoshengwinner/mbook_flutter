import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/extension/extension_text_align.dart';
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

  final TextWidgetProperty? property;
  final Function? onChange;
  final String? data;

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

  Function? onChange;
  String? data;
  TextWidgetProperty? property =
      TextWidgetProperty(backColor: Colors.white, fullLineDisp: false);

  static final _listSize = ListHelper(10, 128, b: 2);
  static final _listFontWeight = ListHelper(100, 900, b: 100);
  static final _listLetterSpace = ListHelper(0, 30);
  static final _listPaddingLeft = ListHelper(0, 256);
  static final _listPaddingTop = _listPaddingLeft;
  static final _listPaddingRight = _listPaddingLeft;
  static final _listPaddingBottom = _listPaddingLeft;
  static final ListHelper _listBorderWidth = ListHelper(0, 256);
  static final ListHelper _listBorderRadius = ListHelper(0, 256);

  static final ListHelper _listMarginLeft = ListHelper(0, 256);
  static final ListHelper _listMarginTop = _listMarginLeft;
  static final ListHelper _listMarginRight = _listMarginLeft;
  static final ListHelper _listMarginBottom = _listMarginLeft;

  static final ListHelper _listShadowOffset = ListHelper(-256, 256);
  static final ListHelper _listShadowBlurRadius = ListHelper(0, 256);
  static final ListHelper _listShadowSpreadRadius = _listShadowBlurRadius;

  static final List<Text> _listTextAlign = FBTextAlign.toTextList();

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
      onChange!(property);
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
    prs.addAll(_spacingSetting(context));

    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            width: 1.sw - 5,
            height: 100,
            child: Center(
              child: WidgetTextWidget(property: property, data: data),
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
      SettingsGroup(items: <Widget>[
        SettingsItem(
          label: "Width",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () => GlobalFun.showBottomSheet(
              context,
              [
                WHPickerPage(
                    initValue: property!.minWidth,
                    sSelectedUtil: property!.minWidthUnit,
                    onSelectedItemChanged: (value, util, utilTitle) {
                      setState(() {
                        property!.minWidth = value;
                        property!.minWidthUnit = util;
                      });
                    })
              ],
              property!.shadowColor),
          value: Text(
              "${property!.minWidth?.toInt() ?? "" }${getUnitTitle(property!.minWidthUnit)}"),
        ),
        SettingsItem(
          label: "Height",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () => GlobalFun.showBottomSheet(
              context,
              [
                WHPickerPage(
                    initValue: property!.minHeight,
                    sSelectedUtil: property!.minHeightUnit,
                    onSelectedItemChanged: (value, util, utilTitle) {
                      setState(() {
                        property!.minHeight = value;
                        property!.minHeightUnit = util;
                      });
                    })
              ],
              property!.shadowColor),
          value: Text(
              "${property!.minHeight.toInt()}${getUnitTitle(property!.minHeightUnit)}"),
        ),
      ]),
      SettingsGroup(
        items: <Widget>[
          SettingsItem(
            label: "Text alignment",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                FBAlignment.getIndexByString(property!.alignment),
                FBAlignment.getAligmentList(), (value) {
              setState(() {
                property!.alignment =
                    FBAlignment.getAligmentList()[value.toInt()].data!;
              });
            }),
            value: Text("${property!.alignment}"),
          ),
          SettingsItem(
            label: "Backgroup Alignment",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                FBAlignment.getIndexByString(property!.backalignment),
                FBAlignment.getAligmentList(), (value) {
              setState(() {
                property!.backalignment =
                    FBAlignment.getAligmentList()[value.toInt()].data!;
              });
            }),
            value: Text("${property!.backalignment}"),
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
        items: <Widget>[
          SettingsItem(
            label: "X",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listShadowOffset
                    .getIndexByValue(property!.shadowOffsetX.toInt()),
                _listShadowOffset.list(), (value) {
              setState(() {
                property!.shadowOffsetX = _listShadowOffset
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.shadowOffsetX.toInt()}"),
          ),
          SettingsItem(
            label: "Y",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listShadowOffset
                    .getIndexByValue(property!.shadowOffsetY.toInt()),
                _listShadowOffset.list(), (value) {
              setState(() {
                property!.shadowOffsetY = _listShadowOffset
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.shadowOffsetY.toInt()}"),
          ),
        ],
        header: Text("Border Offset"),
      ),
      SettingsGroup(items: <Widget>[
        SettingsItem(
          label: 'Border Color',
          icon: Icon(Icons.color_lens_outlined, color: property!.shadowColor),
          hasDetails: true,
          type: SettingsItemType.modal,
          onPress: () => GlobalFun.showBottomSheet(
              context,
              [
                ColorPickerPage(
                    currentColor: property!.shadowColor,
                    onColorChange: (value) {
                      setState(() {
                        property!.shadowColor = value;
                      });
                    })
              ],
              property!.shadowColor),
        ),
        SettingsItem(
          label: "Border Blur radius",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () => GlobalFun.showPicker(
              context,
              _listShadowBlurRadius
                  .getIndexByValue(property!.shadowBlurRadius.toInt()),
              _listShadowBlurRadius.list(), (value) {
            setState(() {
              property!.shadowBlurRadius = _listShadowBlurRadius
                  .values()[value.toInt()]
                  .toDouble(); //value.toDouble();
            });
          }),
          value: Text("${property!.shadowBlurRadius.toInt()}"),
        ),
        SettingsItem(
          label: "Border Spread radius",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () => GlobalFun.showPicker(
              context,
              _listShadowSpreadRadius
                  .getIndexByValue(property!.shadowSpreadRadius.toInt()),
              _listShadowSpreadRadius.list(), (value) {
            setState(() {
              property!.shadowSpreadRadius = _listShadowSpreadRadius
                  .values()[value.toInt()]
                  .toDouble(); //value.toDouble();
            });
          }),
          value: Text("${property!.shadowSpreadRadius.toInt()}"),
        ),
      ])
    ];
    //
    // ));
  }

  List<Widget> _spacingSetting(BuildContext context) {
    return [
      SettingsGroup(items: <Widget>[
        // SettingsItem(
        //   label: 'Spacing Color',
        //   icon: Icon(Icons.color_lens_outlined, color: property.spacingColor),
        //   hasDetails: true,
        //   type: SettingsItemType.modal,
        //   onPress: () {
        //     GlobalFun.showBottomSheet(
        //         context,
        //         [
        //           ColorPickerPage(
        //               currentColor: property.spacingColor,
        //               onColorChange: (value) {
        //                 setState(() {
        //                   property.spacingColor = value;
        //                 });
        //               })
        //         ],
        //         property.spacingColor);
        //   },
        // ),
        SettingsItem(
          label: "Spacing H Width",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () => GlobalFun.showPicker(
              context,
              _listShadowBlurRadius
                  .getIndexByValue(property!.spacingHWidth.toInt()),
              _listShadowBlurRadius.list(), (value) {
            setState(() {
              property!.spacingHWidth = _listShadowBlurRadius
                  .values()[value.toInt()]
                  .toDouble(); //value.toDouble();
            });
          }),
          value: Text("${property!.spacingHWidth.toInt()}"),
        ),
        SettingsItem(
          label: "Spacing V Width",
          type: SettingsItemType.modal,
          hasDetails: true,
          onPress: () => GlobalFun.showPicker(
              context,
              _listShadowSpreadRadius
                  .getIndexByValue(property!.spacingVWidth.toInt()),
              _listShadowSpreadRadius.list(), (value) {
            setState(() {
              property!.spacingVWidth = _listShadowSpreadRadius
                  .values()[value.toInt()]
                  .toDouble(); //value.toDouble();
            });
          }),
          value: Text("${property!.spacingVWidth.toInt()}"),
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
        items: <Widget>[
          SettingsItem(
            label: "Border Width",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listBorderWidth.getIndexByValue(property!.borderWidth?.toInt() ?? 0),
                _listBorderWidth.list(), (value) {
              setState(() {
                property!.borderWidth = _listBorderWidth
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.borderWidth?.toInt() ?? 0}"),
          ),
          SettingsItem(
            label: 'Background',
            icon: Icon(Icons.color_lens_outlined, color: property!.borderColor),
            hasDetails: true,
            type: SettingsItemType.modal,
            onPress: () => GlobalFun.showBottomSheet(
                context,
                [
                  ColorPickerPage(
                      currentColor: property!.borderColor,
                      onColorChange: (value) {
                        setState(() {
                          property!.borderColor = value;
                        });
                      })
                ],
                property!.borderColor),
          ),
          // SettingsItem(
          //   label: 'Background',
          //   icon: Icon(Icons.color_lens_outlined, color: property!.borderColorTop),
          //   hasDetails: true,
          //   type: SettingsItemType.modal,
          //   onPress: () => GlobalFun.showBottomSheet(
          //       context,
          //       [
          //         ColorPickerPage(
          //             currentColor: property!.borderColorTop,
          //             onColorChange: (value) {
          //               setState(() {
          //                 property!.borderColorTop = value;
          //               });
          //             })
          //       ],
          //       property!.borderColorTop),
          // ),
          // SettingsItem(
          //   label: 'Background',
          //   icon: Icon(Icons.color_lens_outlined, color: property!.borderColorRight),
          //   hasDetails: true,
          //   type: SettingsItemType.modal,
          //   onPress: () => GlobalFun.showBottomSheet(
          //       context,
          //       [
          //         ColorPickerPage(
          //             currentColor: property!.borderColorRight,
          //             onColorChange: (value) {
          //               setState(() {
          //                 property!.borderColorRight = value;
          //               });
          //             })
          //       ],
          //       property!.borderColorTop),
          // ),
          // SettingsItem(
          //   label: 'Background',
          //   icon: Icon(Icons.color_lens_outlined, color: property!.borderColorBottom),
          //   hasDetails: true,
          //   type: SettingsItemType.modal,
          //   onPress: () => GlobalFun.showBottomSheet(
          //       context,
          //       [
          //         ColorPickerPage(
          //             currentColor: property!.borderColorBottom,
          //             onColorChange: (value) {
          //               setState(() {
          //                 property!.borderColorBottom = value;
          //               });
          //             })
          //       ],
          //       property!.borderColorBottom),
          // ),
        ],
        header: Text("Border"),
      ),
      SettingsGroup(
        items: <Widget>[
          SettingsItem(
            label: "Top left",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listBorderRadius
                    .getIndexByValue(property!.borderRadiusTopLeft.toInt()),
                _listBorderRadius.list(), (value) {
              setState(() {
                property!.borderRadiusTopLeft = _listBorderRadius
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.borderRadiusTopLeft.toInt()}"),
          ),
          SettingsItem(
            label: "Top right",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listBorderRadius
                    .getIndexByValue(property!.borderRadiusTopRight.toInt()),
                _listBorderRadius.list(), (value) {
              setState(() {
                property!.borderRadiusTopRight = _listBorderRadius
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.borderRadiusTopRight.toInt()}"),
          ),
          SettingsItem(
            label: "Bottom left",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listBorderRadius
                    .getIndexByValue(property!.borderRadiusBottomLeft.toInt()),
                _listBorderRadius.list(), (value) {
              setState(() {
                property!.borderRadiusBottomLeft = _listBorderRadius
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.borderRadiusBottomLeft.toInt()}"),
          ),
          SettingsItem(
            label: "Bottom right",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listBorderRadius
                    .getIndexByValue(property!.borderRadiusBottomRight.toInt()),
                _listBorderRadius.list(), (value) {
              setState(() {
                property!.borderRadiusBottomRight = _listBorderRadius
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.borderRadiusBottomRight.toInt()}"),
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
      SettingsGroup(items: <Widget>[
        SettingsItem(
          label: "Letter space",
          type: SettingsItemType.modal,
          onPress: () => GlobalFun.showPicker(
              context,
              _listLetterSpace.getIndexByValue(property!.letterSpacing.toInt()),
              _listLetterSpace.list(), (value) {
            setState(() {
              property!.letterSpacing = _listLetterSpace
                  .values()[value.toInt()]
                  .toDouble(); //value.toDouble();
            });
          }),
          value: Text("${property!.letterSpacing.toInt()}"),
        ),
      ]),
      SettingsGroup(
        items: <Widget>[
          SettingsItem(
            label: "Left",
            type: SettingsItemType.modal,
            value: Text("${property!.paddingLeft.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listPaddingLeft.getIndexByValue(property!.paddingLeft.toInt()),
                _listPaddingLeft.list(), (value) {
              setState(() {
                property!.paddingLeft = _listPaddingLeft
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Top",
            type: SettingsItemType.modal,
            value: Text("${property!.paddingTop.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listPaddingTop.getIndexByValue(property!.paddingTop.toInt()),
                _listPaddingTop.list(), (value) {
              setState(() {
                property!.paddingTop = _listPaddingTop
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Right",
            type: SettingsItemType.modal,
            value: Text("${property!.paddingRight.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listPaddingRight
                    .getIndexByValue(property!.paddingRight.toInt()),
                _listPaddingRight.list(), (value) {
              setState(() {
                property!.paddingRight = _listPaddingRight
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Bottem",
            type: SettingsItemType.modal,
            value: Text("${property!.paddingBottom.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listPaddingBottom
                    .getIndexByValue(property!.paddingBottom.toInt()),
                _listPaddingBottom.list(), (value) {
              setState(() {
                property!.paddingBottom = _listPaddingBottom
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
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
        items: <Widget>[
          SettingsItem(
            label: "Left",
            type: SettingsItemType.modal,
            value: Text("${property!.marginLeft.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listMarginLeft.getIndexByValue(property!.marginLeft.toInt()),
                _listMarginLeft.list(), (value) {
              setState(() {
                property!.marginLeft = _listMarginLeft
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Top",
            type: SettingsItemType.modal,
            value: Text("${property!.marginTop.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listMarginTop.getIndexByValue(property!.marginTop.toInt()),
                _listMarginTop.list(), (value) {
              setState(() {
                property!.marginTop = _listMarginTop
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Right",
            type: SettingsItemType.modal,
            value: Text("${property!.marginRight.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listMarginRight.getIndexByValue(property!.marginRight.toInt()),
                _listMarginRight.list(), (value) {
              setState(() {
                property!.marginRight = _listMarginRight
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Bottem",
            type: SettingsItemType.modal,
            value: Text("${property!.marginBottom.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listMarginBottom
                    .getIndexByValue(property!.marginBottom.toInt()),
                _listMarginBottom.list(), (value) {
              setState(() {
                property!.marginBottom = _listMarginBottom
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
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
        items: <Widget>[
          SettingsItem(
            label: 'Background Color',
            icon: Icon(Icons.color_lens_outlined, color: property!.backColor),
            hasDetails: true,
            type: SettingsItemType.modal,
            onPress: () => GlobalFun.showBottomSheet(
                context,
                [
                  ColorPickerPage(
                      currentColor: property!.backColor,
                      onColorChange: (value) {
                        setState(() {
                          property!.backColor = value;
                        });
                      })
                ],
                property!.backColor),
          ),
          SettingsItem(
            label: 'Text Color',
            icon: Icon(Icons.color_lens_outlined, color: property!.textColor),
            hasDetails: true,
            type: SettingsItemType.modal,
            onPress: () => GlobalFun.showBottomSheet(
                context,
                [
                  ColorPickerPage(
                      currentColor: property!.textColor,
                      onColorChange: (value) {
                        setState(() {
                          property!.textColor = value;
                        });
                      })
                ],
                property!.backColor),
          ),
        ],
        //header: Text('Color'),
      ),
      SettingsGroup(
        items: <Widget>[
          SettingsItem(
            label: "Size",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                _listSize.getIndexByValue(property!.fontSize.toInt()),
                _listSize.list(), (value) {
              setState(() {
                property!.fontSize = _listSize
                    .values()[value.toInt()]
                    .toDouble(); //value.toDouble();
              });
            }),
            value: Text("${property!.fontSize.toInt()}"),
          ),
          SettingsItem(
            label: "Weight",
            type: SettingsItemType.modal,
            hasDetails: true,
            value: Text("${property!.fontWeight.toInt()}"),
            onPress: () => GlobalFun.showPicker(
                context,
                _listFontWeight.getIndexByValue(property!.fontWeight.toInt()),
                _listFontWeight.list(), (value) {
              setState(() {
                property!.fontWeight =
                    _listFontWeight.values()[value.toInt()]; //value.toDouble();
              });
            }),
          ),
          SettingsItem(
            label: "Italic",
            type: SettingsItemType.toggle,
            value: CupertinoSwitch(
              activeColor: G.appBaseColor[0],
              value: property!.italic,
              onChanged: (bool value) {
                setState(() {
                  property!.italic = value;
                });
              },
            ),
          )
        ],
        header: Text('Font'),
      ),
      SettingsGroup(
        items: <Widget>[
          SettingsItem(
            label: "Text align",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () => GlobalFun.showPicker(
                context,
                FBTextAlign.getIndexByValue(property!.textTextAlign),
                _listTextAlign, (value) {
              setState(() {
                property!.textTextAlign =
                    _listTextAlign[value.toInt()].data?.toString() ?? "";
              });
            }),
            value: Text("${property!.textTextAlign}"),
          ),
        ],
        header: Text(''),
      ),
    ];
  }
}
