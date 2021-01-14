library cupertino_radio_choice;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCupertinoRadioChoice extends StatefulWidget {
  /// CupertinoRadioChoice displays a radio choice widget with cupertino format
  MyCupertinoRadioChoice(
      {@required this.choices,
        @required this.onChange,
        @required this.initialKeyValue,
       // this.selectedColor = CupertinoColors.systemBlue,
       // this.notSelectedColor = CupertinoColors.inactiveGray,
        this.enabled = true});

  /// Function is called if the user selects another choice
  final Function onChange;

  /// Defines which choice shall be selected initally by key
  final dynamic initialKeyValue;

  /// Contains a map which defines which choices shall be displayed (key => value).
  /// Values are the values displyed in the choices
  final Map<dynamic, String> choices;

  /// The color of the selected radio choice
  // final Color selectedColor;

  /// The color of the not selected radio choice(s)
  // final Color notSelectedColor;

  /// Defines if the widget shall be enabled (clickable) or not
  final bool enabled;

  @override
  _MyCupertinoRadioChoiceState createState() => new _MyCupertinoRadioChoiceState();
}

/// State of the widget
class _MyCupertinoRadioChoiceState extends State<MyCupertinoRadioChoice> {
  dynamic _selectedKey;

  @override
  void initState() {
    super.initState();
    if (widget.choices.keys.contains(widget.initialKeyValue))
      _selectedKey = widget.initialKeyValue;
    else
      _selectedKey = widget.choices.keys.first;
  }

  Widget buildSelectionButton(String key, String value,
      {bool selected = false}) {
    return Container(

        child:


        FlatButton(
            // disabledColor:
            // selected ? widget.selectedColor : widget.notSelectedColor,
            // color: selected ? Colors.blue: Colors.white,//idget.selectedColor : widget.notSelectedColor,
            //focusColor:widget.selectedColor,
            padding: const EdgeInsets.all(10.0),
            shape: Border(
                bottom: BorderSide(color: Colors.black, width: selected ? 3 : 1)
            ),
            child: Text(value, style: TextStyle(color: selected ? Colors.black : Colors.grey),),
            onPressed: !widget.enabled || selected
                ? null
                : () {
              setState(() {
                _selectedKey = key;
              });

              widget.onChange(_selectedKey);
            }
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonList = [];
    for (var key in widget.choices.keys) {
      buttonList.add(buildSelectionButton(key, widget.choices[key],
          selected: _selectedKey == key));
    }
    return
      SingleChildScrollView(
        scrollDirection:Axis.horizontal,
          child:
      Wrap(
      children: buttonList,
      spacing: 10.0,
      runSpacing: 5.0,
      ));
  }
}
