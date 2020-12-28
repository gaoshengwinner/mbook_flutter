import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/menu.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/login/login.dart';
import 'package:mbook_flutter/src/widgets/raised_button.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    TokenUtil.checkRefreshToken().then((isOK) {
      setState(() {
        isLogin = isOK;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    printScreenInformation();

    return Scaffold(
      appBar: AppBarView.appbar(S.of(context).common_all_title, false),
      endDrawer: MenuBar.menu(
          isLogin,
          context,
          () => {
                setState(() {
                  TokenUtil.checkRefreshToken().then((isOK) {
                    setState(() {
                      isLogin = isOK;
                    });
                  });
                })
              }),
      body: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: <Widget>[
              // 登录页面迁移按钮Start
              // if (!this.isLogin)
              //   Container(
              //       alignment: Alignment.centerRight,
              //       //margin: EdgeInsets.only(top: 10),
              //       padding: EdgeInsets.only(left: 5, right: 5),
              //       //color: Colors.purpleAccent,
              //       child: new SizedBox(
              //           width: 0.95.sw,
              //           height: 0.15.sw,
              //           child: Row(children: [
              //             Container(
              //                 width: 0.6.sw,
              //                 height: 0.1.sw,
              //                 alignment: Alignment.centerLeft,
              //
              //                 // color: Colors.purpleAccent,
              //                 decoration: BoxDecoration(
              //                   color: Colors.red,
              //                   //borderRadius: BorderRadius.circular(5),
              //                   //boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              //                 ),
              //                 child: Text(
              //                   "我爱你塞北的学我爱你塞北的学我爱我爱我爱我爱我爱  ",
              //                   maxLines: 3,
              //                   style: TextStyle(color: Colors.white),
              //                 ))
              //             //, Spacer()
              //             ,
              //             RaisedButton.icon(
              //               onPressed: () async {
              //                 showModalBottomSheet(
              //                     context: context,
              //                     isScrollControlled: true,
              //                     builder: (context) {
              //                       return LoginPage();
              //                     });
              //               },
              //               shape: RoundedRectangleBorder(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(10.0))),
              //               label: Text(
              //                 S.of(context).home_login_button_title,
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //               icon: Icon(
              //                 Icons.login,
              //                 color: Colors.black,
              //               ),
              //               textColor: Colors.blue,
              //               splashColor: Colors.red,
              //               color: Colors.green,
              //             ),
              //           ]))),
              // 登录页面迁移按钮End
              // QrCodeScarn按钮Start
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                width: 0.4.sw,
                child: SizedBox(
                  child: Image.network(
                      "https://cdn-web.qr-code-generator.com/wp-content/themes/qr/new_structure/assets/media/images/api_page/qrcodes/bw/Api_page_-_QR-Code-Generator_com-1.png"),
                ),
              ),
            FBButton.build(context, 0.6.sw, S.of(context).home_scan_button_title, Icons.qr_code_scanner, ()=>{

            })

              // Container(
              //     alignment: Alignment.center,
              //     margin: EdgeInsets.only(top: 10),
              //     child: SizedBox(
              //       width: 0.6.sw,
              //       //height: 0.4.sw,
              //       child: RaisedButton.icon(
              //         onPressed: () {
              //           print('Button Clicked.');
              //         },
              //         shape: RoundedRectangleBorder(
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10.0))),
              //         label: Text(
              //           S.of(context).home_scan_button_title,
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         icon: Icon(Icons.qr_code_scanner, color: Colors.white),
              //         textColor: Colors.black,
              //         //splashColor: Colors.deepOrange,
              //         color: G.appBaseColor[0],
              //       ),
              //     ))
              // QrCodeScarn按钮End
            ],
          )),
    );
  }

  void printScreenInformation() {
    print('Device width dp:${1.sw}dp');
    print('Device height dp:${1.sh}dp');
    print('Device pixel density:${ScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}dp');
    print('Status bar height dp:${ScreenUtil().statusBarHeight}dp');
    print('The ratio of actual width to UI design:${ScreenUtil().scaleWidth}');
    print(
        'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}');
    print('System font scaling:${ScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}dp');
    print('0.5 times the screen height:${0.5.sh}dp');
  }
}
