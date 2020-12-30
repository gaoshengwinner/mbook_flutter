import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';
import 'package:mbook_flutter/src/home/home.dart';
import 'package:mbook_flutter/src/login/login.dart';
import 'package:mbook_flutter/src/mystore/my_store.dart';

import 'consts.dart';

class MenuBar {
  static Drawer menu(bool isLogin, bool notDispMystore, BuildContext _context, Function doReturn) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: G.appBaseColor,
            )),
            child: Column(
              children: [
                Material(
                  borderRadius:
                      BorderRadius.all(Radius.circular((0.25 / 2).sw)),
                  elevation: 10,
                  child: Image.asset(
                    'assets/graphics/logo_shu.png',
                    width: 0.25.sw,
                  ),
                )
              ],
            ),
          ),
          if (isLogin && !notDispMystore)
            CustomListTitle(Icons.store, S.of(_context).menu_mystore_title,
                () => {gotoMyStore(_context)}),
          if (isLogin)
            CustomListTitle(Icons.logout, S.of(_context).menu_logout_title,
                    () => {logout(_context, doReturn)}),
          if (!isLogin)
            CustomListTitle(Icons.logout, S.of(_context).menu_login_title,
                () => {login(_context, doReturn)}),
        ],
      ),
    );
  }

  static login(BuildContext _context, Function doReturn) async {
    await Navigator.pop(_context);
    //await Navigator.pushNamed(_context, G.ROUTES_LOGIN);
    await showModalBottomSheet(
        context: _context,
        isScrollControlled: true,
        builder: (context) {
          return LoginPage();
        });
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }
  static gotoMyStore(BuildContext _context) async{
    await Navigator.pop(_context);
    await Navigator.push(_context, MaterialPageRoute(builder: (context) => MyStorePage()));
  }

  static logout(BuildContext _context, Function doReturn) async {
    await TokenUtil.clearToken();
    Navigator.push(
        _context, MaterialPageRoute(builder: (context) => HomePage()));
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }

  static Widget CustomListTitle(IconData icon, String title, Function doTop) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: InkWell(
            splashColor: G.appBaseColor[1],
            onTap: doTop,
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title,
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
