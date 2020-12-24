import 'package:flutter/material.dart';

// 多语言Start
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// 多语言End

import 'home/home.dart';

void main() => runApp(MyApp());

GlobalKey<_FreeLocalizations> freeLocalizationStateKey =
    new GlobalKey<_FreeLocalizations>(); // 1

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      // 多语言Start
      localizationsDelegates: const [
        S.delegate,
        //如果你在使用 material library，需要添加下面两个delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // 多语言End
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Builder(builder: (context) {
        return new FreeLocalizations(
          key: freeLocalizationStateKey,
          child: new MyHomePage(),
        );
      }),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool flag = true;

  void changeLocale() {
    if (flag) {
      freeLocalizationStateKey.currentState
          .changeLocale(S.delegate.supportedLocales[0]);
    } else {
      freeLocalizationStateKey.currentState
          .changeLocale(S.delegate.supportedLocales[1]);
    }
    flag = !flag;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text(S.of(context).app_test), // 此处
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                S.of(context).app_test,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: changeLocale,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )); // Th
  }
}

class FreeLocalizations extends StatefulWidget {
  final Widget child;

  FreeLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<FreeLocalizations> createState() {
    return new _FreeLocalizations();
  }
}

class _FreeLocalizations extends State<FreeLocalizations> {
  Locale _locale = const Locale('en', '');

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}

