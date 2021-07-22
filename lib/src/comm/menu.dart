import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';
import 'package:mbook_flutter/src/home/home.dart';
import 'package:mbook_flutter/src/login/login.dart';
import 'package:mbook_flutter/src/mystore/MyGlobal.dart';
import 'package:mbook_flutter/src/mystore/my_store.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'consts.dart';

class MenuBar {
  static Drawer menu(bool isLogin, bool notDispMystore, BuildContext _context, GlobalKey<ScaffoldState> _scaffoldKey, Function doReturn) {
    return Drawer(
      child:
      ListView(
        children: <Widget>[
          DrawerHeader(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   colors: G.appBaseColor,
            // )),
            child: Column(
              children: [
                Material(
                  borderRadius:
                      BorderRadius.all(Radius.circular((0.25 / 2).sw)),
                  elevation: 10,
                  child: Image.asset(
                    'assets/graphics/logo_shu.png',
                    width: 100,
                    height:100,
                  ),
                )
              ],
            ),
          ),
          if (isLogin && !notDispMystore)
            GlobalFun.customListTitle(Icons.store, S.of(_context).menu_mystore_title,
                () => {gotoMyStore(_context, _scaffoldKey)}),
          if (isLogin)
            GlobalFun.customListTitle(Icons.logout, S.of(_context).menu_logout_title,
                    () => {logout(_context)}),
          if (!isLogin)
            GlobalFun.customListTitle(Icons.login, S.of(_context).menu_login_title,
                () => {login(_context, doReturn)}),
        ],
      ),
    );
  }

  static login(BuildContext _context, Function doReturn) async {
     Navigator.pop(_context);
    //await Navigator.pushNamed(_context, G.ROUTES_LOGIN);
    await showModalBottomSheet(
        context: _context,
        isScrollControlled: true,
        builder: (context) {
          return LoginPage();
        });
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }



  static gotoMyStore(BuildContext _context, GlobalKey<ScaffoldState> _scaffoldKey) async{
     Navigator.pop(_context);
    await MyGlobal.init(_context, _scaffoldKey, (){
      Navigator.push(_context, MaterialPageRoute(builder: (context) => MyStorePage()));
    }).whenComplete(() {

    });
  }

  static logout(BuildContext _context) async {
    await TokenUtil.clearToken();
    Navigator.push(
        _context, MaterialPageRoute(builder: (context) => HomePage()));
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }


}
