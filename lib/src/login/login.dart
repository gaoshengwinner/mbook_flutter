import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/LoginResult.dart';
import 'package:mbook_flutter/src/home/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/login/signup.dart';
import 'package:mbook_flutter/src/widgets/raised_button.dart';

import 'findpassword.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _errmsg = "";
  String _mail;
  String _pws;

  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.8.sh,
        color: Colors.greenAccent,
        child: Center(
            child: Scaffold(
                key: _scaffoldKey,
                //resizeToAvoidBottomInset: true,
                //appBar: AppBarView.appbar(S.of(context).login_title, true),
                body:
                    Scrollbar(child:SingleChildScrollView(child:
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // 点击空白页面关闭键盘
                    FocusScope.of(context).requestFocus(_blankNode);
                  },
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  color: G.appBaseColor[0],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        TextFormField(
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: G.appBaseColor[0])),
                                prefixIcon:
                                    Icon(Icons.email, color: G.appBaseColor[0]),
                                hintText: S.of(context).login_mail_hintText),
                            initialValue: "",
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _mail = value;
                            },
                            validator: (email) {
                              setState(() {
                                _errmsg = "";
                              });

                              if (email?.isEmpty ?? true) {
                                return S
                                    .of(context)
                                    .login_email_validator_empty_msg;
                              } else if (!EmailValidator.validate(email)) {
                                return S
                                    .of(context)
                                    .login_email_validator_not_valid_msg;
                              }
                              return null;
                            }),
                        TextFormField(
                            obscureText: true,
                            initialValue: "",
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: G.appBaseColor[0])),
                                prefixIcon:
                                    Icon(Icons.lock, color: G.appBaseColor[0]),
                                hintText:
                                    S.of(context).login_password_hintText),
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              _pws = value;
                            },
                            validator: (password) {
                              if (password?.isEmpty ?? true) {
                                return S
                                    .of(context)
                                    .login_password_validator_empty_msg;
                              }
                              return null;
                            }),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              _errmsg,
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            )),
                        Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              splashColor: G.appBaseColor[1],
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: G.appBaseColor[0]),
                              ),
                              onTap: () {
                                restPassword(context);
                              },
                            ),
                            margin: EdgeInsets.only(right: 10)),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: FBButton.build(
                                context,
                                0.6.sw,
                                S.of(context).login_login_title,
                                Icons.login, () {
                              if (_formKey.currentState.validate()) {
                                GlobalFun.showSnackBar(context,
                                    _scaffoldKey, "  Signing-In...");
                                Api.login(_mail, _pws)
                                    .then((value) => {
                                          if (value[0] == Api.OK)
                                            {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()))
                                            }
                                          else
                                            {
                                              setState(() {
                                                this._errmsg =
                                                    (value[1] as LoginResult)
                                                        .errs[0]
                                                        .msg;
                                              })
                                            }
                                        })
                                    .catchError((e) {
                                  GlobalFun.showSnackBar(context,
                                      _scaffoldKey, e.toString());
                                });
                              }
                            })),
                        Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              splashColor: G.appBaseColor[1],
                              child: Text("Don't have an account?Create",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: G.appBaseColor[0])),
                              onTap: () {
                                signup(context);
                              },
                            ),
                            margin: EdgeInsets.only(right: 10)),
                      ]),
                    ),
                  ),
                ))))));
  }

  static signup(BuildContext _context) async {
     Navigator.pop(_context);
    //await Navigator.pushNamed(_context, G.ROUTES_LOGIN);
    await showModalBottomSheet(
        context: _context,
        isScrollControlled: true,
        builder: (context) {
          return SignupPage();
        });
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }

  static restPassword(BuildContext _context) async {
    Navigator.pop(_context);
    //await Navigator.pushNamed(_context, G.ROUTES_LOGIN);
    await showModalBottomSheet(
        context: _context,
        isScrollControlled: true,
        builder: (context) {
          return FindPasswordPage();
        });
    //Navigator.pushNamed(_context, G.ROUTES_HOME);
  }


}
