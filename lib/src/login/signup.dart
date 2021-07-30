import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/SignupMailCnfResult.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbook_flutter/src/widgets/FBButton.dart';

class SignupPage extends StatefulWidget {

  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  int step = 0;
  String? _mail;
  String? _uuid;
  String _signUpTitle = "";


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
                              'Sign up',
                              style: TextStyle(
                                  color: G.appBaseColor[0],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                         Expanded(
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
                                          {VoidCallback? onStepContinue,
                                          VoidCallback? onStepCancel}) =>
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
                                    content: new SignupMailCnfPage(
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
                                    content: new SignupCodeCnfPage(_uuid?.toString() ?? "", (uuid) {
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
                                    title:  Text(
                                      'Password',
                                      style: TextStyle(
                                          color: G.appBaseColor[0],
                                          fontSize: 10),
                                    ),
                                    content:  SignupPasswordPage( _formKey, _mail?.toString() ?? "", _uuid?.toString() ?? "",
                                        () {
                                      setState(() {
                                        step = 3;
                                      });
                                    })),
                              ])),

                      ]),
                    ),
                  ),
                ))));
  }
}

class SignupMailCnfPage extends StatefulWidget {
  final Function onOK;

  SignupMailCnfPage(this._formKey, this._canClick,
      this._signUpTitle, this.onOK);

  final String _signUpTitle;
  final bool _canClick;

  _SignupMailCnfPageState createState() => _SignupMailCnfPageState();
  final _formKey;
}

class _SignupMailCnfPageState extends State<SignupMailCnfPage> {
  String _errmsg = "";
  late String _mail;

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

                if (email?.isEmpty ?? true) {
                  return S.of(context).sigup_email_validator_empty_msg;
                } else if (!EmailValidator.validate(email!)) {
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
              child: FBButton(
                 width: 0.6.sw,
                 title: widget._signUpTitle.isEmpty
                      ? S.of(context).signup_button_sending
                      : widget._signUpTitle,
                  icon:Icons.mail,
                  onTap: !widget._canClick
                      ? null
                      : () {
                          if (widget._formKey.currentState.validate()) {
                            GlobalFun.showSnackBar(context, null, "  Sending Mail...");
                            Api.sigupMailCnf(_mail)
                                .then((value) => {
                                      if (value[0] == Api.OK &&
                                          (value[1] as SignupMailCnfResult)
                                                  .statu ==
                                              "0")
                                        {
                                          widget.onOK(
                                              _mail,
                                              (value[1] as SignupMailCnfResult)
                                                  .uuid)
                                        }
                                      else
                                        {
                                          setState(() {
                                            this._errmsg = (value[1]
                                                    as SignupMailCnfResult)
                                                .errs![0]
                                                .msg!;
                                          })
                                        }
                                    })
                                .catchError((e) {
                              GlobalFun.showSnackBar(context,
                                   e, e.toString());
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

  SignupCodeCnfPage(this._uuid, this.onOK);

  _SignupCodeCnfPageState createState() => _SignupCodeCnfPageState();
  final String _uuid;
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

                if (code?.isEmpty ?? true) {
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
              child: FBButton(
                  width:0.6.sw,
                  title:S.of(context).signup_code_button_sending,
                  icon:Icons.check_circle, onTap:() {
                Api.sigupMailCodeCnf(widget._uuid, _cnfcode).then((value) => {
                      if (value[0] == Api.OK &&
                          (value[1] as SignupMailCnfResult).statu == "0")
                        {widget.onOK((value[1] as SignupMailCnfResult).uuid)}
                      else
                        {
                          setState(() {
                            this._errmsg =
                                (value[1] as SignupMailCnfResult).errs![0].msg!;
                          })
                        }
                    });
              })),
        ],
      ),
    );
  }
}

class SignupPasswordPage extends StatefulWidget {
  final Function onOK;

  SignupPasswordPage( this._formKey, this._mail, this._uuid, this.onOK);

  _SignupPasswordPagetate createState() => _SignupPasswordPagetate();
  final _formKey;
  final String _uuid;
  final String _mail;
}

class _SignupPasswordPagetate extends State<SignupPasswordPage> {
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
                if (password?.isEmpty ?? true) {
                  return S.of(context).login_password_validator_empty_msg;
                }

                RegExp exp = RegExp(
                    r'^.*(?=.{6,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*? ]).*$');
                bool matched = exp.hasMatch(password!);
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
                if (password?.isEmpty ?? true) {
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
              child: FBButton(width: 0.6.sw,
                  title:S.of(context).signup_sigup_button, icon:Icons.login, onTap: () {
                setState(() {
                  _errmsg = "";
                });
                if (widget._formKey.currentState.validate()) {
                  GlobalFun.showSnackBar(context,
                      null, "  Sending Mail...");
                  Api.sigup(widget._mail, widget._uuid, _password)
                      .then((value) => {
                            if (value[0] == Api.OK &&
                                (value[1] as SignupMailCnfResult).statu == "0")
                              {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Sign up', style: TextStyle(color: G.appBaseColor[0]),),
                                    content:
                                        const Text('Succeed in registration'),
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
                                      (value[1] as SignupMailCnfResult)
                                          .errs![0]
                                          .msg!;
                                })
                              }
                          })
                      .catchError((e) {
                    GlobalFun.showSnackBar(context, e, e.toString());
                  });
                }
              })),
        ],
      ),
    );
  }
}
