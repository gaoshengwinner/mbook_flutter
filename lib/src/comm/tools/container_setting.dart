import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/color_picker.dart';
import 'package:mbook_flutter/src/comm/tools/group.dart';
import 'package:mbook_flutter/src/comm/tools/item.dart';
import 'package:mbook_flutter/src/comm/tools/wh_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SettingKind { size, backgroundColor, border, borderRadius }
class ContainerSettingPage extends StatefulWidget {
  final List<SettingKind> kinds;
  final TextWidgetProperty? property;
  final Function? onChange;
  final String? data;

  const ContainerSettingPage(
      {Key? key, this.property, this.onChange, this.data, required this.kinds})
      : super(key: key);

  @override
  _ContainerSettingPageState createState() => _ContainerSettingPageState();
}

class _ContainerSettingPageState extends State<ContainerSettingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        initialIndex: 0, vsync: this, length: widget.kinds.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.5.sh,
        child: new Scaffold(
          appBar: TabBar(
              isScrollable: true,
              controller: _tabController,
              //生成Tab菜单
              tabs: widget.kinds.map((e) {
                switch (e) {
                  case SettingKind.size:
                    {
                      return Tab(text: "Size");
                    }
                  case SettingKind.backgroundColor:
                    {
                      return Tab(text: "Background color");
                    }
                  case SettingKind.border:
                    {
                      return Tab(text: "Border");
                    }
                  case SettingKind.borderRadius:
                    {
                      return Tab(text: "Border radius");
                    }
                }
              }).toList()),
          body: TabBarView(
            controller: _tabController,
            children: widget.kinds.map((e) {
              //分别创建对应的Tab页面
              switch (e) {
                case SettingKind.size:
                  {
                    return ListView(children: _sizeTab());
                  }
                case SettingKind.backgroundColor:
                  {
                    return ListView(children: _backgroundColorTab());
                  }
                case SettingKind.border:
                  {
                    return ListView(children: _borderTab());
                  }
                case SettingKind.borderRadius:
                  {
                    return ListView(children: _borderRadiusTab());
                  }
                default:
                  {
                    return Container(
                        alignment: Alignment.center, child: Text("TODO"));
                  }
              }
            }).toList(),
          ),
        ));
  }

  List<Widget> _borderRadiusTab() => <Widget>[
        SettingsGroup(
          //header: Text(""),
          items: <Widget>[
            SettingsItem(
              icon: Icon(Icons.crop_free_outlined),
              label: "Top left",
              type: SettingsItemType.modal,
              hasDetails: true,
              onPress: () {
                return showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return WHPickerPage(
                          onlyPX: true,
                          initValue: widget.property!.borderRadiusTopLeft,
                          onSelectedItemChanged: (value, _, __) {
                            setState(() {
                              widget.property!.borderRadiusTopLeft =
                                  value != null ? (value * 1.0) : null;
                            });
                            if (widget.onChange != null)
                              widget.onChange!(widget.property);
                          });
                    });
              },
              value: Text(
                  "${widget.property!.borderRadiusTopLeft.toInt()}"),
            ),
            SettingsItem(
              icon: Icon(Icons.crop_free_outlined),
              label: "Top right",
              type: SettingsItemType.modal,
              hasDetails: true,
              onPress: () {
                return showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return WHPickerPage(
                          onlyPX: true,
                          initValue: widget.property!.borderRadiusTopRight,
                          onSelectedItemChanged: (value, _, __) {
                            setState(() {
                              widget.property!.borderRadiusTopRight =
                              value != null ? (value * 1.0) : null;
                            });
                            if (widget.onChange != null)
                              widget.onChange!(widget.property);
                          });
                    });
              },
              value: Text(
                  "${widget.property!.borderRadiusTopRight.toInt()}"),
            ),
            SettingsItem(
              icon: Icon(Icons.crop_free_outlined),
              label: "Bottom left",
              type: SettingsItemType.modal,
              hasDetails: true,
              onPress: () {
                return showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return WHPickerPage(
                          onlyPX: true,
                          initValue: widget.property!.borderRadiusBottomLeft,
                          onSelectedItemChanged: (value, _, __) {
                            setState(() {
                              widget.property!.borderRadiusBottomLeft =
                              value != null ? (value * 1.0) : null;
                            });
                            if (widget.onChange != null)
                              widget.onChange!(widget.property);
                          });
                    });
              },
              value: Text(
                  "${widget.property!.borderRadiusBottomLeft.toInt()}"),
            ),
            SettingsItem(
              icon: Icon(Icons.crop_free_outlined),
              label: "Bottom right",
              type: SettingsItemType.modal,
              hasDetails: true,
              onPress: () {
                return showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return WHPickerPage(
                          onlyPX: true,
                          initValue: widget.property!.borderRadiusBottomRight,
                          onSelectedItemChanged: (value, _, __) {
                            setState(() {
                              widget.property!.borderRadiusBottomRight =
                              value != null ? (value * 1.0) : null;
                            });
                            if (widget.onChange != null)
                              widget.onChange!(widget.property);
                          });
                    });
              },
              value: Text(
                  "${widget.property!.borderRadiusBottomRight.toInt()}"),
            ),
          ],
        ),
      ];

  List<Widget> _borderTab() => <Widget>[
        SettingsGroup(
          //header: Text(""),
          items: <Widget>[
            SettingsItem(
              icon: Icon(Icons.arrow_forward_sharp),
              label: "Width",
              type: SettingsItemType.modal,
              hasDetails: true,
              onPress: () {
                return showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return WHPickerPage(
                          onlyPX: true,
                          initValue: widget.property!.borderWidth,
                          onSelectedItemChanged: (value, _, __) {
                            setState(() {
                              widget.property!.borderWidth =
                                  value != null ? (value * 1.0) : null;
                            });
                            if (widget.onChange != null)
                              widget.onChange!(widget.property);
                          });
                    });
              },
              value: Text("${widget.property!.borderWidth?.toInt() ?? ""}"),
            ),
          ],
        ),
        SettingsGroup(items: <Widget>[
          SettingsItem(
              label: 'Color',
              icon: Icon(Icons.color_lens_outlined,
                  color: widget.property!.borderColor),
              hasDetails: true,
              type: SettingsItemType.modal,
              onPress: () {
                return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return ColorPickerPage(
                        currentColor: widget.property!.borderColor,
                        onColorChange: (value) {
                          setState(() {
                            widget.property!.borderColor = value;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  },
                );
              })
        ])
        // SettingsGroup(
        //   items: <Widget>[
        //     SettingsItem(
        //       label: "Top left",
        //       type: SettingsItemType.modal,
        //       hasDetails: true,
        //       onPress: () => GlobalFun.showPicker(
        //           context,
        //           _listBorderRadius
        //               .getIndexByValue(widget.property!.borderRadiusTopLeft.toInt()),
        //           _listBorderRadius.list(), (value) {
        //         setState(() {
        //           widget.property!.borderRadiusTopLeft = _listBorderRadius
        //               .values()[value.toInt()]
        //               .toDouble(); //value.toDouble();
        //         });
        //       }),
        //       value: Text("${widget.property!.borderRadiusTopLeft.toInt()}"),
        //     ),
        //     SettingsItem(
        //       label: "Top right",
        //       type: SettingsItemType.modal,
        //       hasDetails: true,
        //       onPress: () => GlobalFun.showPicker(
        //           context,
        //           _listBorderRadius
        //               .getIndexByValue(widget.property!.borderRadiusTopRight.toInt()),
        //           _listBorderRadius.list(), (value) {
        //         setState(() {
        //           widget.property!.borderRadiusTopRight = _listBorderRadius
        //               .values()[value.toInt()]
        //               .toDouble(); //value.toDouble();
        //         });
        //       }),
        //       value: Text("${widget.property!.borderRadiusTopRight.toInt()}"),
        //     ),
        //     SettingsItem(
        //       label: "Bottom left",
        //       type: SettingsItemType.modal,
        //       hasDetails: true,
        //       onPress: () => GlobalFun.showPicker(
        //           context,
        //           _listBorderRadius
        //               .getIndexByValue(widget.property!.borderRadiusBottomLeft.toInt()),
        //           _listBorderRadius.list(), (value) {
        //         setState(() {
        //           widget.property!.borderRadiusBottomLeft = _listBorderRadius
        //               .values()[value.toInt()]
        //               .toDouble(); //value.toDouble();
        //         });
        //       }),
        //       value: Text("${widget.property!.borderRadiusBottomLeft.toInt()}"),
        //     ),
        //     SettingsItem(
        //       label: "Bottom right",
        //       type: SettingsItemType.modal,
        //       hasDetails: true,
        //       onPress: () => GlobalFun.showPicker(
        //           context,
        //           _listBorderRadius
        //               .getIndexByValue(widget.property!.borderRadiusBottomRight.toInt()),
        //           _listBorderRadius.list(), (value) {
        //         setState(() {
        //           widget.property!.borderRadiusBottomRight = _listBorderRadius
        //               .values()[value.toInt()]
        //               .toDouble(); //value.toDouble();
        //         });
        //       }),
        //       value: Text("${widget.property!.borderRadiusBottomRight.toInt()}"),
        //     ),
        //   ],
        //   header: Text("Radius"),
        // ),
      ];

  List<Widget> _backgroundColorTab() => <Widget>[
        SettingsGroup(items: <Widget>[
          SettingsItem(
              label: 'Background Color',
              icon: Icon(Icons.color_lens_outlined,
                  color: widget.property!.backColor),
              hasDetails: true,
              type: SettingsItemType.modal,
              onPress: () {
                return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return ColorPickerPage(
                        currentColor: widget.property!.backColor,
                        onColorChange: (value) {
                          setState(() {
                            widget.property!.backColor = value;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  },
                );
              })
        ])
      ];

  List<Widget> _sizeTab() => <Widget>[
        SettingsGroup(header: Text("Fixed size"), items: <Widget>[
          SettingsItem(
            icon: Icon(Icons.arrow_forward_sharp),
            label: "Width",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WHPickerPage(
                        initValue: widget.property!.width,
                        sSelectedUtil: widget.property!.widthUnit,
                        onSelectedItemChanged: (value, util, utilTitle) {
                          setState(() {
                            widget.property!.width =
                                (value != null ? (value * 1.0) : null);
                            widget.property!.widthUnit = util;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  });
            },
            value: Text(
                "${widget.property!.width?.toInt() ?? ""}${getUnitTitle(widget.property!.widthUnit)}"),
          ),
          SettingsItem(
            icon: Icon(Icons.arrow_downward_sharp),
            label: "Height",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WHPickerPage(
                        initValue: widget.property!.height,
                        sSelectedUtil: widget.property!.heightUnit,
                        onSelectedItemChanged: (value, util, utilTitle) {
                          setState(() {
                            widget.property!.height =
                                (value != null ? (value * 1.0) : null);
                            widget.property!.heightUnit = util;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  });
            },
            value: Text(
                "${widget.property!.height?.toInt() ?? ""}${getUnitTitle(widget.property!.heightUnit)}"),
          ),
        ]),
        SettingsGroup(header: Text("Range of width"), items: <Widget>[
          SettingsItem(
            icon: Icon(Icons.arrow_forward_sharp),
            label: "Min width",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WHPickerPage(
                        initValue: widget.property!.minWidth,
                        sSelectedUtil: widget.property!.minWidthUnit,
                        onSelectedItemChanged: (value, util, utilTitle) {
                          setState(() {
                            widget.property!.minWidth =
                                (value != null ? (value * 1.0) : null);
                            widget.property!.minWidthUnit = util;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  });
            },
            value: Text(
                "${widget.property?.minWidth?.toInt() ?? ""}${getUnitTitle(widget.property?.minWidthUnit)}"),
          ),
          SettingsItem(
            icon: Icon(Icons.arrow_forward_sharp),
            label: "Max width",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WHPickerPage(
                        initValue: widget.property!.maxWidth,
                        sSelectedUtil: widget.property!.maxWidthUnit,
                        onSelectedItemChanged: (value, util, utilTitle) {
                          setState(() {
                            widget.property!.maxWidth =
                                (value != null ? (value * 1.0) : null);
                            widget.property!.maxWidthUnit = util;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  });
            },
            value: Text(
                "${widget.property!.maxWidth?.toInt() ?? ""}${getUnitTitle(widget.property!.maxWidthUnit)}"),
          ),
        ]),
        SettingsGroup(header: Text("Range of height"), items: <Widget>[
          SettingsItem(
            icon: Icon(Icons.arrow_downward_sharp),
            label: "Min height",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WHPickerPage(
                        initValue: widget.property!.minHeight,
                        sSelectedUtil: widget.property!.minHeightUnit,
                        onSelectedItemChanged: (value, util, utilTitle) {
                          setState(() {
                            widget.property!.minHeight =
                                (value != null ? (value * 1.0) : null);
                            widget.property!.minHeightUnit = util;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  });
            },
            value: Text(
                "${widget.property?.minHeight.toInt() ?? ""}${getUnitTitle(widget.property!.minHeightUnit)}"),
          ),
          SettingsItem(
            icon: Icon(Icons.arrow_downward_sharp),
            label: "Max height",
            type: SettingsItemType.modal,
            hasDetails: true,
            onPress: () {
              return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WHPickerPage(
                        initValue: widget.property!.maxHeight,
                        sSelectedUtil: widget.property!.maxHeightUnit,
                        onSelectedItemChanged: (value, util, utilTitle) {
                          setState(() {
                            widget.property!.maxHeight =
                                (value != null ? (value * 1.0) : null);
                            widget.property!.maxHeightUnit = util;
                          });
                          if (widget.onChange != null)
                            widget.onChange!(widget.property);
                        });
                  });
            },
            value: Text(
                "${widget.property!.maxHeight?.toInt() ?? ""}${getUnitTitle(widget.property!.maxHeightUnit)}"),
          ),
        ]),
      ];
}
