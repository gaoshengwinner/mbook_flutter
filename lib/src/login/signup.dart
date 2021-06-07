import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/LoginResult.dart';
import 'package:mbook_flutter/src/comm/model/SignupMailCnfResult.dart';
import 'package:mbook_flutter/src/home/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/widgets/raised_button.dart';

class SignupPage extends StatefulWidget {
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  int step = 0;
  String _mail;
  String _code;

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
                              'Sign up',
                              style: TextStyle(
                                  color: G.appBaseColor[0],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        step == 0
                            ? new SignupMailCnfPage(_scaffoldKey, _formKey,
                                (mail, code) {
                                setState(() {
                                  _code = code;
                                  _mail = mail;
                                  step = 1;
                                });
                              })
                            : step == 1
                                ? new SignupCodeCnfPage(
                                    _scaffoldKey, _formKey, _code, () {
                                    setState(() {
                                      step = 2;
                                    });
                                  })
                                : new SignupPasswordPage(
                                    _scaffoldKey, _formKey, _mail, _code, () {
                                    setState(() {
                                      step = 3;
                                    });
                                  })
                      ]),
                    ),
                  ),
                ))));
  }
}

class SignupMailCnfPage extends StatefulWidget {
  final Function onOK;

  SignupMailCnfPage(this._scaffoldKey, this._formKey, this.onOK);

  _SignupMailCnfPageState createState() => _SignupMailCnfPageState();
  final _formKey;
  final GlobalKey<ScaffoldState> _scaffoldKey;
}

class _SignupMailCnfPageState extends State<SignupMailCnfPage> {
  String _errmsg = "";
  String _mail;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          new TextFormField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: G.appBaseColor[0])),
                  prefixIcon: Icon(Icons.email, color: G.appBaseColor[0]),
                  hintText: S.of(context).sigup_mail_hintText),
              initialValue: "",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _mail = value;
              },
              validator: (email) {
                setState(() {
                  _errmsg = "";
                });

                if (email.isEmpty) {
                  return S.of(context).sigup_email_validator_empty_msg;
                } else if (!EmailValidator.validate(email)) {
                  return S.of(context).login_email_validator_not_valid_msg;
                }
                return null;
              }),
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                _errmsg,
                style: TextStyle(fontSize: 13, color: Colors.red),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FBButton.build(context, 0.6.sw,
                  S.of(context).signup_button_sending, Icons.mail, () {
                if (widget._formKey.currentState.validate()) {
                  GlobalFun.showSnackBar(
                      widget._scaffoldKey, "  Sending Mail...");
                  Api.sigupMailCnf(_mail)
                      .then((value) => {
                            if (value[0] == Api.OK &&
                                (value[1] as SignupMailCnfResult).statu == "0")
                              {
                                widget.onOK(_mail,
                                    (value[1] as SignupMailCnfResult).code)
                              }
                            else
                              {
                                setState(() {
                                  this._errmsg =
                                      (value[1] as SignupMailCnfResult)
                                          .errs[0]
                                          .msg;
                                })
                              }
                          })
                      .catchError((e) {
                    GlobalFun.showSnackBar(widget._scaffoldKey, e.toString());
                  });
                }
              })),
        ],
      ),
    );
  }
}

class SignupCodeCnfPage extends StatefulWidget {
  final Function onOK;

  SignupCodeCnfPage(this._scaffoldKey, this._formKey, this._code, this.onOK);

  _SignupCodeCnfPageState createState() => _SignupCodeCnfPageState();
  final _formKey;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final String _code;
}

class _SignupCodeCnfPageState extends State<SignupCodeCnfPage> {
  String _errmsg = "";
  String _cnfcode = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          new TextFormField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: G.appBaseColor[0])),
                  prefixIcon: Icon(Icons.lock_clock, color: G.appBaseColor[0]),
                  hintText: S.of(context).sigup_mail_cfn_hintText),
              initialValue: "",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _cnfcode = value;
              },
              validator: (code) {
                setState(() {
                  _errmsg = "";
                });

                if (code.isEmpty) {
                  return S.of(context).sigup_email_validator_empty_msg;
                }
                return null;
              }),
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                _errmsg,
                style: TextStyle(fontSize: 13, color: Colors.red),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FBButton.build(
                  context,
                  0.6.sw,
                  S.of(context).signup_code_button_sending,
                  Icons.check_circle, () {
                if (widget._code == _cnfcode) {
                  setState(() {
                    _errmsg = "";
                    widget.onOK();
                  });
                } else {
                  setState(() {
                    _errmsg = "Inconsistent check codes。";
                  });
                }
              })),
        ],
      ),
    );
  }
}

class SignupPasswordPage extends StatefulWidget {
  final Function onOK;

  SignupPasswordPage(
      this._scaffoldKey, this._formKey, this._mail, this._code, this.onOK);

  _SignupPasswordPagetate createState() => _SignupPasswordPagetate();
  final _formKey;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final String _code;
  final String _mail;
}

class _SignupPasswordPagetate extends State<SignupPasswordPage> {
  String _errmsg = "";
  String _cnfcode = "";
  String _password = "";
  String _passwordCnf = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
              obscureText: true,
              initialValue: "",
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: G.appBaseColor[0])),
                  prefixIcon: Icon(Icons.lock, color: G.appBaseColor[0]),
                  hintText: S.of(context).login_password_hintText),
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                _password = value;
              },
              validator: (password) {
                if (password.isEmpty) {
                  return S.of(context).login_password_validator_empty_msg;
                }
                return null;
              }),
          TextFormField(
              obscureText: true,
              initialValue: "",
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: G.appBaseColor[0])),
                  prefixIcon: Icon(Icons.lock, color: G.appBaseColor[0]),
                  hintText: S.of(context).login_password_hintText),
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                _passwordCnf = value;
              },
              validator: (password) {
                if (password.isEmpty) {
                  return S.of(context).login_password_validator_empty_msg;
                }
                if (password != this._password) {
                  return S.of(context).signup_password_validator_cofict_msg;
                }
                return null;
              }),
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                _errmsg,
                style: TextStyle(fontSize: 13, color: Colors.red),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FBButton.build(
                  context,
                  0.6.sw,
                  S.of(context).signup_sigup_button,
                  Icons.login, () {
                    setState(() {
                      _errmsg = "";
                    });
                if (widget._formKey.currentState.validate()){

                }
              })),
        ],
      ),
    );
  }
}
