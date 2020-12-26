import 'package:flutter/material.dart';
import 'package:mbook_flutter/generated/l10n.dart';
import 'package:mbook_flutter/src/comm/api/api.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _mail;
  String _pws;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: G.appBaseColor,
        shadowColor: Colors.black,
        title: Text(S.of(context).login_title),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(children: [
            TextFormField(

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  _mail = value;
                }
                ,
                validator:(email){
                  if (email.isEmpty) {
                    return 'Please enter some text';
                  } else if (!EmailValidator.validate(email)){
                    return 'Email is not valid';
                  }
                  return null;
                }
            ),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value){
                  _pws = value;
                },
                validator:(password){
                  if (password.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    Api.login(_mail, _pws);
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ]

          ),
        ),
      ),
    );
  }
}
