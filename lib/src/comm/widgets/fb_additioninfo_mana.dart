import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/AdditionInfoManaWidget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/comm/widgets/fb_listview.dart';

class AdditionInfoManaWidget extends StatefulWidget {
  List<AdditionalInfo> infos = [];
  Function onSave;
  AdditionInfoManaWidget({this.infos, this.onSave}) {
    if (infos == null || infos.length == 0) {
      infos = [];
      for (int i = 1; i <= 10; i++) {
        infos.add(new AdditionalInfo(no: i, canBeUse:false));
      }
    }
  }

  @override
  _AdditionInfoManaWidgetState createState() =>
      new _AdditionInfoManaWidgetState();
}

class _AdditionInfoManaWidgetState extends State<AdditionInfoManaWidget> {
  FocusNode _blankNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (widget.onSave != null) {
      widget.onSave(widget.infos);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 0.9.sh,
      color: Colors.greenAccent,
      child: Center(
            child:  GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(_blankNode);
                  },
                  child: new FBListViewWidget<AdditionalInfo>(
                    widget.infos,
                    canBeMove: false,
                    setSubWidget: (c, r, index) {
                      return Container(
                        //color: Color(0xEDE7F6),
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalFun.fbInputBox(
                                  context, "Title", widget.infos[index].title, (value) {
                                setState(() {
                                  widget.infos[index].title = value;
                                });
                              }, width: 0.9.sw),
                              Row(children:[
                                Switch(
                                  value: widget.infos[index].canBeUse,
                                  onChanged: (value){
                                    setState(() {
                                      widget.infos[index].canBeUse = value;
                                    });
                                  },
                                ),
                              ])
                              // Row(
                              //   children: [
                              //     GlobalFun.fbInputBox(
                              //         context, "Tag", tagInfos[index].data, (value) {
                              //       setState(() {
                              //         tagInfos[index].data = value;
                              //       });
                              //     },
                              //         valueWidget: Wrap(
                              //           children: [
                              //             WidgetTextPage(
                              //               property: tagInfos[index].property,
                              //               data: tagInfos[index].data,
                              //             )
                              //           ],
                              //         )),
                              //     GlobalFun.clipOvalIcon(Icons.settings, () {
                              //       return GlobalFun.showBottomSheetForTextPrperty(
                              //           context,
                              //           TextSettingWidget(
                              //               property: tagInfos[index].property,
                              //               data: tagInfos[index].data,
                              //               onChange: (value) {
                              //                 setState(() {
                              //                   tagInfos[index].property = value;
                              //                 });
                              //               }),
                              //           null);
                              //     }),
                              //   ],
                              // ),
                            ]),
                      );
                    },

                  ),
              ),
      ),
    );
  }
}
