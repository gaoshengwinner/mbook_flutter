import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/input_bottom.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';

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

  static const String initSelected = "0";
  String selected = initSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.7.sh,
        child: new Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 1.sw - 5,
              height: 20,
              color: currentColor,
            )
            ,
            CupertinoRadioChoice(
                choices: {"0": 'Sliders', "1": 'Spectrum', "2": 'Grid'},
                onChange: (selectedGender) {
                  setState(() {
                    selected = selectedGender;
                  });
                  print(selected);
                }),
            if (this.selected == "0")
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
                showIndicator: false,
                indicatorBorderRadius: const BorderRadius.vertical(
                  top: const Radius.circular(25.0),
                ),
              ),
            if (this.selected == "1")
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
            if (this.selected == "2")
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 380,
                      ),
                      child: MaterialPicker(
                        pickerColor: currentColor,
                        onColorChanged: (value) {
                          setState(() {
                            currentColor = value;
                          });
                          onColorChange(value);
                        },
                        enableLabel: true,
                      )))
          ],
        ));
  }
}
