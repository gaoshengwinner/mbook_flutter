import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'consts.dart';

class InputButtomWidget extends StatelessWidget {
  final ValueChanged onEditingCompleteText;

  String hintTextValue = "";
  String initVlueValue = "";
  TextInputAction textInputAction = TextInputAction.search;
  TextInputType keyboardType = TextInputType.multiline;

  final TextEditingController _controller = new TextEditingController();


  InputButtomWidget(
      {this.onEditingCompleteText,
      this.hintTextValue,
      this.initVlueValue,
      this.textInputAction,
      this.keyboardType}){
    _controller.text = initVlueValue;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body:
      new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.transparent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          // new Container(
          //   color: G.appBaseColor[0],
          //     child:
          //     Center( child:
          //     IconButton(icon: Icon(Icons.add_link, size: 40,), onPressed: () async {
          //
          //       ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
          //       if (data != null)
          //       _controller.text = '${data.text}';
          //     },)
          //
          //     )),
          new Container(
              color:Color(0xFFEFEFF4),
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
              child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextFormField(
                    controller: _controller,
                    autofocus: true,
                    style: TextStyle(fontSize: 16),
                    //设置键盘按钮为发送
                    textInputAction: textInputAction,
                    keyboardType: keyboardType,
                    //initialValue: initVlueValue,
                    onChanged: (value) {
                      onEditingCompleteText(value);
                    },
                    onEditingComplete: () {
                      Navigator.pop(context);
                    },
                    decoration: InputDecoration(
                      hintText: hintTextValue,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 10, top: 5, bottom: 5, right: 10),
                      border: const OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 5,
                  )

                  //Text("Te")

                  ))
        ],
      ),
    );
  }
}

//过度路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
