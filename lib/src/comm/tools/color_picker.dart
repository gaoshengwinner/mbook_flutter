import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';

void openColor(
    BuildContext context, Color currentColor, Function onColorChange) {
  Navigator.push(
      context,
      PopRoute(
          child: ColorPickerPage(
              currentColor: currentColor, onColorChange: onColorChange)));
}

// ignore: must_be_immutable
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
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage>
    with SingleTickerProviderStateMixin {
  //Function onColorChange;

  Color oldColor;
  // create some values
  Color pickerColor = Color(0xff443a49);
  //Color currentColor = Color(0xff443a49);

  _ColorPickerPageState();

  static const String initSelected = "0";
  String selected = initSelected;

  @override
  void initState() {
    oldColor = this.widget.currentColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.7.sh,
        child: new Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff999999),
                    width: 0.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'Revoke',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      this.widget.onColorChange(oldColor);
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  // CupertinoButton(
                  //   child: Text('Confirm',
                  //       style: TextStyle(color: G.appBaseColor[0])),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 16.0,
                  //     vertical: 5.0,
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 1.sw - 5,
              height: 20,
              color: this.widget.currentColor,
            )
            ,
            CupertinoRadioChoice(
              initialKeyValue: "0",
                choices: {"0": 'Sliders', "1": 'Spectrum', "2": 'Grid'},
                onChange: (selectedGender) {
                  setState(() {
                    selected = selectedGender;
                  });
                  print(selected);
                }),
            if (this.selected == "0")
              SlidePicker(
                pickerColor: this.widget.currentColor,
                onColorChanged: (value) {
                  setState(() {
                    this.widget.currentColor = value;
                  });
                  this.widget.onColorChange(value);
                },
                paletteType: PaletteType.rgb,
                enableAlpha: true,
                displayThumbColor: true,
                showLabel: true,
                showIndicator: false,
                indicatorBorderRadius: const BorderRadius.vertical(
                  top: const Radius.circular(25.0),
                ),
              ),
            if (this.selected == "1")
              ColorPicker(
                pickerColor: this.widget.currentColor,
                onColorChanged: (value) {
                  setState(() {
                    this.widget.currentColor = value;
                  });
                  this.widget.onColorChange(value);
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
            if (this.selected == "2")
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 380,
                      ),
                      child: MaterialPicker(
                        pickerColor: this.widget.currentColor,
                        onColorChanged: (value) {
                          setState(() {
                            this.widget.currentColor = value;
                          });
                          this.widget.onColorChange(value);
                        },
                        enableLabel: true,
                      )))
          ],
        ));
  }
}
