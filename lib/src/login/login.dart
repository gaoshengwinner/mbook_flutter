import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mbook_flutter/src/comm/model/LoginResult.dart';
import 'package:mbook_flutter/src/home/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/widgets/raised_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.8.sh,
        color: Colors.greenAccent,
        child: Center(
            child: Scaffold(
                //resizeToAvoidBottomInset: true,
                //appBar: AppBarView.appbar(S.of(context).login_title, true),
                body: GestureDetector(
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
                          borderSide: BorderSide(color: G.appBaseColor[0])),
                      prefixIcon: Icon(Icons.email, color: G.appBaseColor[0]),
                        hintText:"Mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      _mail = value;
                    },

                    validator: (email) {
                      setState(() {
                        _errmsg = "";
                      });

                      if (email.isEmpty) {
                        return 'Please enter some text';
                      } else if (!EmailValidator.validate(email)) {
                        return 'Email is not valid';
                      }
                      return null;
                    }),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: G.appBaseColor[0])),
                      prefixIcon: Icon(Icons.lock, color: G.appBaseColor[0]),
                        hintText:"Password"
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      _pws = value;
                    },
                    validator: (password) {
                      if (password.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                Container(
                  margin: EdgeInsets.only(top:5),
                child: Text(_errmsg, style: TextStyle(fontSize: 13, color: Colors.red),)
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: FBButton.build(
                        context,
                        0.6.sw,
                        S.of(context).login_login_title,
                        Icons.login,
                        () => {
                              if (_formKey.currentState.validate())
                                {
                                   Api.login(_mail, _pws).then((value) => {
                                        if (value[0] == 200)
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
                                              this._errmsg = (value[1] as LoginResult).errs[0].msg;
                                            })
                                          }
                                      })
                                }
                            })
                    // RaisedButton.icon(
                    //     onPressed: () async {
                    //           // Validate returns true if the form is valid, or false
                    //           // otherwise.
                    //           if (_formKey.currentState.validate()) {
                    //             Api.login(_mail, _pws).then((value) => {
                    //                   if (value[0] == 200)
                    //                     {
                    //                       Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                               builder: (context) => HomePage()))
                    //                     }
                    //                 });
                    //           }
                    //     },
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //         BorderRadius.all(Radius.circular(10.0))),
                    //     label: Text(
                    //       S.of(context).home_login_button_title,
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     icon: Icon(
                    //       Icons.login,
                    //       color: Colors.black,
                    //     ),
                    //     textColor: Colors.blue,
                    //     splashColor: G.appBaseColor[0],
                    //     color: G.appBaseColor[0],
                    //   )

                    ),
              ]),
            ),
          ),
        ))));
  }
}
