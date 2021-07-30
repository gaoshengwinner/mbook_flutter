import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_title.dart';

class FBInputBox extends StatelessWidget {
  final String? lableText;
  final String? value;
  final Function? serValue;
  final Widget? valueWidget;
  final double? width;
  final Axis? axis;
  final String? hintTextValue;

  FBInputBox(
      {this.lableText,
      this.value,
      this.serValue,
      this.valueWidget,
      this.width,
      this.axis,
      this.hintTextValue});

  @override
  Widget build(BuildContext context) {
    double? _width = width == null ? double.maxFinite : width;
    return Container(
        //padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Flex(
      direction: axis == null ? Axis.vertical : axis!,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lableText != null) FBTitle(lableText: lableText!),
        Container(
          constraints: BoxConstraints(
            minHeight: 20,
          ),
          //width: width,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              width: _width,
              child: Stack(children: [
                Container(
                    child: valueWidget == null
                        ? value == null || value == ""
                            ? Text(
                                (hintTextValue == null || hintTextValue!.isEmpty
                                    ? ""
                                    : hintTextValue!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: Colors.black54))
                            : Text(value!,
                                style: Theme.of(context).textTheme.bodyText2)
                        //)
                        : valueWidget),
                if (valueWidget != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.red,
                        )),
                  )
              ]),
            ),
            onTap: () {
              GlobalFun.openEditPage(
                  context: context,
                  hintTextValue: lableText == null ? hintTextValue : lableText,
                  initValue: value,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  onEditingCompleteText: (value) {
                    if (serValue != null) serValue!(value);
                  });
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ));
  }
}
