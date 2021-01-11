import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/widget_text.dart';
import 'package:settings_ui/settings_ui.dart';

void openColor(
    BuildContext context, Color currentColor, Function onColorChange) {
  Navigator.push(
      context,
      PopRoute(
          child: ColorPickerPage(
              currentColor: currentColor, onColorChange: onColorChange)));
}

class ColorPickerPage extends StatefulWidget {
  Color currentColor = Colors.white;
  Function onColorChange;

  ColorPickerPage({currentColor: Color, Function onColorChange}) {
    this.onColorChange = onColorChange;
    if (currentColor != null) {
      this.currentColor = currentColor;
    }
  }

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState(
      currentColor: currentColor, onColorChange: onColorChange);
}

class _ColorPickerPageState extends State<ColorPickerPage>
    with SingleTickerProviderStateMixin {
  Function onColorChange;

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  _ColorPickerPageState({this.currentColor, this.onColorChange});

  TabController _tabController;
  final tabList = [
    '背景色',
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: this.currentColor,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.transparent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          new Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: new BoxDecoration(
                //border: new Border.all( width: 0.5), // 边色与边宽度
                color: Color(0xFFEFEFF4),
                // 底色
                //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                borderRadius:
                    new BorderRadius.vertical(top: Radius.elliptical(10, 10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0)
                ],
              ),

              height: 0.6.sh,
              //color: Color(0xFFEFEFF4),
              child: new Column(
                children: <Widget>[
                  new Container(
                    // decoration:
                    //     new BoxDecoration(color: Theme.of(context).primaryColor),
                    child: new TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        new Tab(
                          text: "Sliders",
                        ),
                        new Tab(
                          text: "Spectrum",
                        ),
                        new Tab(
                          text: "Grid",
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 400,
                    child: new TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        SlidePicker(
                          pickerColor: currentColor,
                          onColorChanged: (value) {
                            setState(() {
                              currentColor = value;
                            });
                            onColorChange(value);
                          },
                          paletteType: PaletteType.rgb,
                          enableAlpha: true,
                          displayThumbColor: true,
                          showLabel: true,
                          showIndicator: true,
                          indicatorBorderRadius: const BorderRadius.vertical(
                            top: const Radius.circular(25.0),
                          ),
                        ),
                        ColorPicker(
                          pickerColor: currentColor,
                          onColorChanged: (value) {
                            setState(() {
                              currentColor = value;
                            });
                            onColorChange(value);
                          },
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          showLabel: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(2.0),
                            topRight: const Radius.circular(2.0),
                          ),
                        ),
                        SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 100,
                            ),
                            child:

                            MaterialPicker(
                              pickerColor: currentColor,
                              onColorChanged: (value) {
                                setState(() {
                                  currentColor = value;
                                });
                                onColorChange(value);
                              },
                              enableLabel: true,
                            )
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
