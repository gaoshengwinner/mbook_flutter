import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
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
      this.keyboardType}) {
    _controller.text = initVlueValue;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.7),
      body: new Column(
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
              child: Container(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    autofocus: true,
                    style:
                        TextStyle(fontSize: 16, backgroundColor: Colors.white),
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
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.grey,
                        ),
                      ),
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
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        _controller.clear();
                        onEditingCompleteText("");
                      }, icon: Icon(Icons.clear)),
                      IconButton(onPressed: () async {
                        await Clipboard.getData(Clipboard.kTextPlain).then((cdata){
                          if (cdata != null && cdata.text !=null && cdata.text.isNotEmpty){
                            final String inputText = _controller.text;
                            final int beginBaseOffset = _controller.selection.baseOffset;
                            if (inputText?.isEmpty ?? true){
                              _controller.text = cdata.text;
                            } else {
                              _controller.text = inputText.substring(0, beginBaseOffset) + cdata.text
                                  + inputText.substring(_controller.selection.extentOffset);
                            }
                            _controller.selection = new TextSelection(baseOffset: (beginBaseOffset + cdata.text.length), extentOffset: beginBaseOffset + cdata.text.length);
                            onEditingCompleteText(_controller.text);
                          }
                        });

                      }, icon: Icon(Icons.attach_file)),
                    ],
                  ),
                ],
              )
                  //Text("Te")

                  ))
        ],
      ),
    );
  }
}
