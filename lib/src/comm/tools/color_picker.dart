import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/pop_route.dart';

void openColor(
    BuildContext context, Color currentColor, Function onColorChange) {
  Navigator.push(
      context,
      PopRoute(
          child: ColorPickerPage(
              currentColor: currentColor, onColorChange: onColorChange)));
}

enum ColorSelectStlye { Sliders, Spectrum, Grid }

// ignore: must_be_immutable
class ColorPickerPage extends StatefulWidget {
  Color currentColor = Colors.white;
  Function? onColorChange = () {};

  ColorPickerPage({this.currentColor = Colors.white, this.onColorChange});

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage>
    with SingleTickerProviderStateMixin {
  //Function onColorChange;

  Color _oldColor = Colors.white;

  _ColorPickerPageState();

  //static const String initSelected = "0";
  //String selected = initSelected;
  ColorSelectStlye selected = ColorSelectStlye.Sliders;

  @override
  void initState() {
    _oldColor = this.widget.currentColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.7.sh,
        child: new ListView(
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
                      if (this.widget.onColorChange == null)
                        this.widget.onColorChange!(_oldColor);
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 1.sw - 5,
              height: 20,
              color: this.widget.currentColor,
            ),

            CustomRadioButton(
              width: 0.33.sw,
              elevation: 0,
              absoluteZeroSpacing: true,
              unSelectedColor: Theme.of(context).canvasColor,
              buttonLables: [
                'Sliders',
                'Spectrum',
                'Grid',
              ],
              buttonValues: [
                ColorSelectStlye.Sliders,
                ColorSelectStlye.Spectrum,
                ColorSelectStlye.Grid,
              ],
              buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: TextStyle(fontSize: 6)),
              defaultSelected: ColorSelectStlye.Sliders,
              radioButtonValue: (value) {
                setState(() {
                  selected = value as ColorSelectStlye;
                });
              },
              selectedColor: Theme.of(context).accentColor,
            ),

            // Row(
            //   children: [
            // RadioListTile<ColorSelectStlye>(
            //   title: const Text('Sliders'),
            //   value: ColorSelectStlye.Sliders,
            //   groupValue: selected,
            //   onChanged: (ColorSelectStlye? value) {
            //     setState(() {
            //       selected = value ?? ColorSelectStlye.Sliders;
            //     });
            //   },
            // ),
            // // RadioListTile<ColorSelectStlye>(
            // //   title: const Text('Spectrum'),
            // //   value: ColorSelectStlye.Spectrum,
            // //   groupValue: selected,
            // //   onChanged: (ColorSelectStlye? value) {
            // //     setState(() {
            // //       selected = value ?? ColorSelectStlye.Sliders;
            // //     });
            // //   },
            // // ),
            // // RadioListTile<ColorSelectStlye>(
            // //   title: const Text('Grid'),
            // //   value: ColorSelectStlye.Grid,
            // //   groupValue: selected,
            // //   onChanged: (ColorSelectStlye? value) {
            // //     setState(() {
            // //       selected = value ?? ColorSelectStlye.Sliders;
            // //     });
            // //   },
            // // ),
            // ],),
            // CupertinoRadioChoice(
            //   initialKeyValue: "0",
            //     choices: {"0": 'Sliders', "1": 'Spectrum', "2": 'Grid'},
            //     onChange: (selectedGender) {
            //       setState(() {
            //         selected = selectedGender;
            //       });
            //       print(selected);
            //     }),
            if (this.selected == ColorSelectStlye.Sliders)
              SlidePicker(
                pickerColor: this.widget.currentColor,
                onColorChanged: (value) {
                  setState(() {
                    this.widget.currentColor = value;
                  });
                  if (this.widget.onColorChange != null)
                    this.widget.onColorChange!(value);
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
            if (this.selected == ColorSelectStlye.Spectrum)
              ColorPicker(
                pickerColor: this.widget.currentColor,
                onColorChanged: (value) {
                  setState(() {
                    this.widget.currentColor = value;
                  });
                  if (this.widget.onColorChange != null)
                    this.widget.onColorChange!(value);
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
            if (this.selected == ColorSelectStlye.Grid)
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
                          if (this.widget.onColorChange != null)
                            this.widget.onColorChange!(value);
                        },
                        enableLabel: true,
                      )))
          ],
        ));
  }
}
