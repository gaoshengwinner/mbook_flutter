import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FBListGroup extends StatelessWidget {
  final String? title;

   FBListGroup({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 2),
      alignment: Alignment.bottomLeft,
      child: Text(
        title ?? "",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
