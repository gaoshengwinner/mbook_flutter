import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';
import 'package:mbook_flutter/src/comm/widgets/menu_title.dart';
import 'package:mbook_flutter/src/home/home.dart';
import 'package:mbook_flutter/src/login/login.dart';
import 'package:mbook_flutter/src/my_store/MyGlobal.dart';
import 'package:mbook_flutter/src/my_store/my_store.dart';

class MenuBar {
  static Drawer menu(BuildContext context, bool isLogin, bool notDispMystore, BuildContext _context, GlobalKey<ScaffoldState> _scaffoldKey, Function doReturn) {
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
            MenuTitle(icon:Icons.store, title:S.of(_context).menu_mystore_title,
              doTop:   () => {gotoMyStore(_context)},isFirst:true),
          if (isLogin)
            MenuTitle(icon:Icons.logout, title:S.of(_context).menu_logout_title,
                   doTop:  () => {logout(context:_context)}, isBottom:true),
          if (!isLogin)
            MenuTitle(icon:Icons.login, title:S.of(_context).menu_login_title,
                doTop: () => {login(_context, doReturn)}),
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



  static gotoMyStore(BuildContext _context) async{
     Navigator.pop(_context);
    await MyGlobal.init(_context, (){
      Navigator.push(_context, MaterialPageRoute(builder: (context) => MyStorePage()));
    }).whenComplete(() {

    });
  }

  static logout({required BuildContext context, bool? showLogin = false}) async {
    await TokenUtil.clearToken();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    if (showLogin ?? false) {
      login(context, (){});
    }
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }


}
