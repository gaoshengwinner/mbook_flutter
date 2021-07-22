import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/theme/MainThemeData.dart';

class FBButton extends StatefulWidget {
  final double? width;
  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  FBButton({this.width, this.title, this.icon, this.onTap});

  @override
  _FBButtonState createState() => _FBButtonState();
}

class _FBButtonState extends State<FBButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          minimumSize: widget.width == null
              ? null
              : MaterialStateProperty.all(
                  Size(widget.width!, FBThemeDate.buttonSizeHeight))),
      onPressed: () {
        if (widget.onTap != null) widget.onTap!();
      },
      label: Text(
        widget.title == null ? "" : widget.title!,
      ),
      icon: Icon(
        // TODO 怎么在Theme里设定？
        widget.icon, color: FBThemeDate.primaryColor,
      ),
    );
  }
}
