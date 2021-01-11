import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';

class WidgetTextPage extends StatefulWidget {
  TextWidgetProperty property = TextWidgetProperty(Colors.white);
  String data = "";

  WidgetTextPage(this.data, this.property);

  _WidgetTextPagetate createState() =>
      _WidgetTextPagetate(this.data, this.property);
}

class _WidgetTextPagetate extends State<WidgetTextPage> {
  TextWidgetProperty _property = TextWidgetProperty(Colors.white);
  String _data = "";

  _WidgetTextPagetate(this._data, this._property);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _property.backColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(_data),
      ),
    );
  }
}
