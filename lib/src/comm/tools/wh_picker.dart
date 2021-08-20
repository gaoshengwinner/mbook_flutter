import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ListHelper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_number_picker.dart';

enum WHOption { px, sw, sh }

String getUnitTitle(WHOption? util) {
  if (util == null) return "px";
  return util == WHOption.px
      ? " px "
      : util == WHOption.sw
          ? "% sw"
          : "% sh";
}

// ignore: must_be_immutable
class WHPickerPage extends StatefulWidget {
  final double? initValue;
  WHOption? selectedUtil;
  final Function onSelectedItemChanged;
  final bool? onlyPX;

  WHPickerPage(
      {this.initValue,
      WHOption? sSelectedUtil,
      required this.onSelectedItemChanged,
      this.onlyPX}) {
    if (selectedUtil == null) {
      selectedUtil = WHOption.px;
    }
  }

  @override
  _WHPickerPageState createState() => _WHPickerPageState();
}

class _WHPickerPageState extends State<WHPickerPage>
    with SingleTickerProviderStateMixin {
  late int _initialItem;
  late int _oldInitialItem;
  WHOption? _oldSelectedUtil;

  int? _changeValue = 0;

  @override
  void initState() {
    _initialItem = ListHelper(0, 1024, tral: "px")
        .getIndexByValue(this.widget.initValue?.toInt() ?? 0);
    _oldInitialItem = _initialItem;
    _oldSelectedUtil = this.widget.selectedUtil;
    _changeValue = _initialItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh,
      child: ListView(
        children: <Widget>[
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
                    this.widget.onSelectedItemChanged(
                        _oldInitialItem.toDouble(),
                        enumToString(_oldSelectedUtil),
                        getUnitTitle(_oldSelectedUtil));
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
          if (widget.onlyPX == null || !widget.onlyPX!)
            Container(
              alignment: Alignment(0.0, 0.0),
              width: 1.sw,
              color: Color(0xfff7f7f7),
              child: CustomRadioButton(
                width: 0.33.sw,
                elevation: 0,
                absoluteZeroSpacing: true,
                unSelectedColor: Theme.of(context).canvasColor,
                buttonLables: [
                  'px',
                  'sw',
                  'sh',
                ],
                buttonValues: [
                  WHOption.px,
                  WHOption.sw,
                  WHOption.sh,
                ],
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16)),
                defaultSelected: this.widget.selectedUtil,
                radioButtonValue: (value) {
                  setState(() {
                    this.widget.selectedUtil = value as WHOption;

                    this.widget.onSelectedItemChanged(
                        _changeValue,
                        enumToString(this.widget.selectedUtil),
                        getUnitTitle(this.widget.selectedUtil));
                  });
                },
                selectedColor: Theme.of(context).accentColor,
              ),
            ),
          // CupertinoRadioChoice(
          //     selectedColor: G.appBaseColor[0],
          //     initialKeyValue: enumToString(this.widget.selectedUtil),
          //     choices: {
          //       enumToString(WHOption.px): 'Pixel',
          //       enumToString(WHOption.sw): 'Screen Width',
          //       enumToString(WHOption.sh): 'Screen Height'
          //     },
          //     onChange: (selectedGender) {
          //       setState(() {
          //         this.widget.selectedUtil =
          //             enumFromString(WHOption.values, selectedGender);
          //
          //         this.widget.onSelectedItemChanged(
          //             ListHelper(0, 1024,
          //                     tral: enumToString(this.widget.selectedUtil))
          //                 .values()[_changeValue]
          //                 .toDouble(),
          //             enumToString(this.widget.selectedUtil),
          //             getUnitTitle(enumToString(this.widget.selectedUtil)));
          //       });
          //     })),
          SizedBox(
              height: 100.0,
              width: 1.sw,
              child: Center(
                  // color: Color(0xfff7f7f7),
                  child: FBNumberPicker(
                minValue: 0,
                step: 1,
                maxValue: 1024,
                canInputByKeyboard: true,
                onValue: (value) {
                  setState(() {
                    _changeValue = value;
                    this.widget.onSelectedItemChanged(
                        value,
                        enumToString(this.widget.selectedUtil),
                        this.widget.selectedUtil == WHOption.px
                            ? " px "
                            : this.widget.selectedUtil == WHOption.sw
                                ? "% sw"
                                : "% sh");
                  });
                },
                initialValue: _changeValue ?? 0,
              )
                  // CupertinoPicker(
                  //     itemExtent: 32.6,
                  //     children: ListHelper(0, 1024,
                  //             tral: (this.widget.selectedUtil == WHOptin.px
                  //                 ? " px "
                  //                 : this.widget.selectedUtil == WHOptin.sw
                  //                     ? "% sw"
                  //                     : "% sh"))
                  //         .list(),
                  //     onSelectedItemChanged: (value) {
                  //       _changeValue = value;
                  //       this.widget.onSelectedItemChanged(
                  //           ListHelper(0, 1024,
                  //                   tral: enumToString(this.widget.selectedUtil))
                  //               .values()[value.toInt()]
                  //               .toDouble(),
                  //           enumToString(this.widget.selectedUtil),
                  //           this.widget.selectedUtil == WHOptin.px
                  //               ? " px "
                  //               : this.widget.selectedUtil == WHOptin.sw
                  //                   ? "% sw"
                  //                   : "% sh");
                  //     },
                  //     scrollController:
                  //         FixedExtentScrollController(initialItem: _initialItem)),
                  ))
        ],
      ),
    );
  }
}
