import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/ResetPasswordResult.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/widgets/raised_button.dart';

class FindPasswordPage extends StatefulWidget {
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  int step = 0;
  String _mail;
  String _uuid;
  String _signUpTitle = "";

  Timer countDownTimer;

  bool _canSendMail = true;

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
                              'Reseat password',
                              style: TextStyle(
                                  color: G.appBaseColor[0],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        Theme(
                          data: ThemeData(primarySwatch: G.appBaseColor[0]),
                          //color: Colors.red,
                          child: Expanded(
                              child: Stepper(
                                  type: StepperType.horizontal,
                                  physics: ScrollPhysics(),
                                  currentStep: step,
                                  onStepContinue: null,
                                  onStepCancel: null,
                                  onStepTapped: (sp) =>
                                      setState(() => step = sp),
                                  // delete continue and cancle
                                  controlsBuilder: (BuildContext context,
                                          {VoidCallback onStepContinue,
                                          VoidCallback onStepCancel}) =>
                                      Container(),
                                  steps: <Step>[
                                Step(
                                    isActive: step == 0,
                                    state: step >= 0
                                        ? StepState.complete
                                        : StepState.disabled,
                                    title: new Text(
                                      'Mail',
                                      style: TextStyle(
                                          color: G.appBaseColor[0],
                                          fontSize: 10),
                                    ),
                                    content: new FindPasswordMailCnfPage(
                                        _scaffoldKey,
                                        _formKey,
                                        _canSendMail,
                                        _signUpTitle, (mail, uuid) {
                                      setState(() {
                                        _uuid = uuid;
                                        _mail = mail;
                                        step = 1;
                                      });
                                    })),
                                Step(
                                    isActive: step == 1,
                                    state: step >= 1
                                        ? StepState.complete
                                        : StepState.disabled,
                                    title: new Text(
                                      'Code',
                                      style: TextStyle(
                                          color: G.appBaseColor[0],
                                          fontSize: 10),
                                    ),
                                    content: new FindPasswordCodeCnfPage(_uuid, (uuid) {
                                      setState(() {
                                        _uuid = uuid;
                                        step = 2;
                                      });
                                    })),
                                Step(
                                    isActive: step == 2,
                                    state: step >= 2
                                        ? StepState.complete
                                        : StepState.disabled,
                                    title: new Text(
                                      'Password',
                                      style: TextStyle(
                                          color: G.appBaseColor[0],
                                          fontSize: 10),
                                    ),
                                    content: new FindPasswordPasswordPage(
                                        _scaffoldKey, _formKey, _mail, _uuid,
                                        () {
                                      setState(() {
                                        step = 3;
                                      });
                                    })),
                              ])),
                        )
                      ]),
                    ),
                  ),
                ))));
  }
}

class FindPasswordMailCnfPage extends StatefulWidget {
  final Function onOK;

  FindPasswordMailCnfPage(this._scaffoldKey, this._formKey, this._canClick,
      this._signUpTitle, this.onOK);

  final String _signUpTitle;
  final bool _canClick;

  _FindPasswordMailCnfPageState createState() => _FindPasswordMailCnfPageState();
  final _formKey;
  final GlobalKey<ScaffoldState> _scaffoldKey;
}

class _FindPasswordMailCnfPageState extends State<FindPasswordMailCnfPage> {
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
              child: FBButton.build(
                  context,
                  0.6.sw,
                  widget._signUpTitle.isEmpty
                      ? S.of(context).signup_button_sending
                      : widget._signUpTitle,
                  Icons.mail,
                  !widget._canClick
                      ? null
                      : () {
                          if (widget._formKey.currentState.validate()) {
                            GlobalFun.showSnackBar(
                                widget._scaffoldKey, "  Sending Mail...");
                            Api.resetPassordMailCnf(_mail)
                                .then((value) => {
                                      if (value[0] == Api.OK &&
                                          (value[1] as ResetPasswordResult)
                                                  .statu ==
                                              "0")
                                        {
                                          widget.onOK(
                                              _mail,
                                              (value[1] as ResetPasswordResult)
                                                  .uuid)
                                        }
                                      else
                                        {
                                          setState(() {
                                            this._errmsg = (value[1]
                                                    as ResetPasswordResult)
                                                .errs[0]
                                                .msg;
                                          })
                                        }
                                    })
                                .catchError((e) {
                              GlobalFun.showSnackBar(
                                  widget._scaffoldKey, e.toString());
                            });
                          }
                        })),
        ],
      ),
    );
  }
}

class FindPasswordCodeCnfPage extends StatefulWidget {
  final Function onOK;

  FindPasswordCodeCnfPage(this._uuid, this.onOK);

  _FindPasswordCodeCnfPageState createState() => _FindPasswordCodeCnfPageState();
  final String _uuid;
}

class _FindPasswordCodeCnfPageState extends State<FindPasswordCodeCnfPage> {
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
                Api.resetPasswordMailCodeCnf(widget._uuid, _cnfcode).then((value) => {
                      if (value[0] == Api.OK &&
                          (value[1] as ResetPasswordResult).statu == "0")
                        {widget.onOK((value[1] as ResetPasswordResult).uuid)}
                      else
                        {
                          setState(() {
                            this._errmsg =
                                (value[1] as ResetPasswordResult).errs[0].msg;
                          })
                        }
                    });
              })),
        ],
      ),
    );
  }
}

class FindPasswordPasswordPage extends StatefulWidget {
  final Function onOK;

  FindPasswordPasswordPage(
      this._scaffoldKey, this._formKey, this._mail, this._uuid, this.onOK);

  _FindPasswordPasswordPagetate createState() => _FindPasswordPasswordPagetate();
  final _formKey;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final String _uuid;
  final String _mail;
}

class _FindPasswordPasswordPagetate extends State<FindPasswordPasswordPage> {
  String _errmsg = "";
  String _password = "";

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

                RegExp exp = RegExp(
                    r'^.*(?=.{6,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*? ]).*$');
                bool matched = exp.hasMatch(password);
                if (!matched) {
                  return "Please enter 8 single-byte alphanumeric characters including uppercase and lowercase letters.";
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
                //_passwordCnf = value;
              },
              validator: (password) {
                if (password.isEmpty) {
                  return S.of(context).login_password_validator_empty_msg;
                }
                if (password != this._password) {
                  return "Password mismatch";
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
                  S.of(context).signup_sigup_button, Icons.login, () {
                setState(() {
                  _errmsg = "";
                });
                if (widget._formKey.currentState.validate()) {
                  GlobalFun.showSnackBar(
                      widget._scaffoldKey, "  Sending Mail...");
                  Api.resetPassword(widget._mail, widget._uuid, _password)
                      .then((value) => {
                            if (value[0] == Api.OK &&
                                (value[1] as ResetPasswordResult).statu == "0")
                              {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Reset password'),
                                    content:
                                        const Text('Succeed in reset password'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                )
                              }
                            else
                              {
                                setState(() {
                                  this._errmsg =
                                      (value[1] as ResetPasswordResult)
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
