import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ListHelper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum WHOptin { px, sw, sh }

//
// void openWHPicker(BuildContext context, double initValue,
//     String selectedUtil, Function onSelectedItemChanged) {
//   Navigator.push(
//       context,
//       PopRoute(
//           child: WHPickerPage(
//               initValue, selectedUtil, onSelectedItemChanged)));
// }

String getUnitTitle(String util) {
  return enumFromString(WHOptin.values, util) == WHOptin.px
      ? " px "
      : enumFromString(WHOptin.values, util) == WHOptin.sw
          ? "% sw"
          : "% sh";
}

class WHPickerPage extends StatefulWidget {
  double initValue;
  WHOptin selectedUtil;
  Function onSelectedItemChanged;

  WHPickerPage(
      this.initValue, String sSelectedUtil, this.onSelectedItemChanged) {
    if (sSelectedUtil != null && sSelectedUtil != "") {
      selectedUtil = enumFromString(WHOptin.values, sSelectedUtil);
    }
    if (selectedUtil == null) {
      selectedUtil = WHOptin.px;
    }
  }

  @override
  _WHPickerPageState createState() => _WHPickerPageState();
}

class _WHPickerPageState extends State<WHPickerPage>
    with SingleTickerProviderStateMixin {
  int _initialItem;
  int _oldInitialItem;
  WHOptin _oldSelectedUtil;

  int _changeValue = 0;

  @override
  void initState() {
    _initialItem = ListHelper(0, 1024, tral: "px")
        .getIndexByValue(this.widget.initValue.toInt());
    _oldInitialItem = _initialItem;
    _oldSelectedUtil = this.widget.selectedUtil;
    _changeValue = _initialItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
                      _oldInitialItem.toDouble(), enumToString(_oldSelectedUtil),getUnitTitle(enumToString(_oldSelectedUtil)) );
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
            alignment: Alignment(0.0, 0.0),
            width: 1.sw,
            color: Color(0xfff7f7f7),
            child: CupertinoRadioChoice(
                selectedColor: G.appBaseColor[0],
                initialKeyValue: enumToString(this.widget.selectedUtil),
                choices: {
                  enumToString(WHOptin.px): 'Pixel',
                  enumToString(WHOptin.sw): 'Screen Width',
                  enumToString(WHOptin.sh): 'Screen Height'
                },
                onChange: (selectedGender) {
                  setState(() {
                    this.widget.selectedUtil =
                        enumFromString(WHOptin.values, selectedGender);

                    this.widget.onSelectedItemChanged(
                        ListHelper(0, 1024,
                                tral: enumToString(this.widget.selectedUtil))
                            .values()[_changeValue]
                            .toDouble(),
                        enumToString(this.widget.selectedUtil),
                        getUnitTitle(enumToString(this.widget.selectedUtil)));
                  });
                })),
        Container(
          height: 320.0,
          color: Color(0xfff7f7f7),
          child: CupertinoPicker(
              itemExtent: 32.6,
              children: ListHelper(0, 1024,
                      tral: (this.widget.selectedUtil == WHOptin.px
                          ? " px "
                          : this.widget.selectedUtil == WHOptin.sw
                              ? "% sw"
                              : "% sh"))
                  .list(),
              onSelectedItemChanged: (value) {
                _changeValue = value;
                this.widget.onSelectedItemChanged(
                    ListHelper(0, 1024,
                            tral: enumToString(this.widget.selectedUtil))
                        .values()[value.toInt()]
                        .toDouble(),
                    enumToString(this.widget.selectedUtil),
                    this.widget.selectedUtil == WHOptin.px
                        ? " px "
                        : this.widget.selectedUtil == WHOptin.sw
                            ? "% sw"
                            : "% sh");
              },
              scrollController:
                  FixedExtentScrollController(initialItem: _initialItem)),
        )
      ],
    );
  }
}
