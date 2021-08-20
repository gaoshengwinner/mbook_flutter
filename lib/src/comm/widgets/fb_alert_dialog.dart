
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FBAlertDialog extends StatelessWidget{
  final Function? onSave;
  final String? contentTitle;
  final String? title;
  FBAlertDialog({this.onSave, this.contentTitle, this.title});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(contentTitle ?? ""),
      title: Center(
          child: Text(
            title ?? "",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          )),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              if (onSave != null)  onSave!();
              Navigator.of(context).pop();
            },
            child: Text('Do it')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Don't do it")),
      ],
    );
  }

}