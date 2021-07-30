import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FBTitle extends StatelessWidget {
  String lableText;
  Widget? rightWidget;

  FBTitle({required this.lableText, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(lableText, style: Theme.of(context).textTheme.subtitle1), //
      rightWidget != null ? rightWidget! : Text("")
    ]));
  }
}
