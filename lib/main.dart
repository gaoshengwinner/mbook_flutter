import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:mbook_flutter/src/comm/device/device.dart';
import 'package:mbook_flutter/src/login/login.dart';

// 多语言Start
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// 多语言End

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/home/home.dart';
import 'src/comm/consts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// 手动切换语言Start
// GlobalKey<_FreeLocalizations> freeLocalizationStateKey =
//     new GlobalKey<_FreeLocalizations>(); // 1

// 手动切换语End
class MyApp extends StatelessWidget {
  MyApp() {
    DeviceHelper.getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: false,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // 多语言Start
            localizationsDelegates: const [
              S.delegate,
              //如果你在使用 material library，需要添加下面两个delegate
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            // 多语言End
            theme: new ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: HomePage(),

            routes:{
              G.ROUTES_LOGIN: (context) => LoginPage(),
              G.ROUTES_HOME: (context) => HomePage(),

            }
            // 手动切换语言Start
            // new Builder(builder: (context) {
            //   return new FreeLocalizations(
            //     key: freeLocalizationStateKey,
            //     child: new MyHomePage(),
            //   );
            // }),
            // 手动切换语言End
            ));
  }
}

// 手动切换语言Start
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool flag = true;
//
//   void changeLocale() {
//     if (flag) {
//       freeLocalizationStateKey.currentState
//           .changeLocale(S.delegate.supportedLocales[0]);
//     } else {
//       freeLocalizationStateKey.currentState
//           .changeLocale(S.delegate.supportedLocales[1]);
//     }
//     flag = !flag;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: AppBar(
//           title: new Text(S.of(context).app_test), // 此处
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 S.of(context).app_test + "asdsa",
//               ),
//               Text(
//                 '$_counter',
//                 style: Theme.of(context).textTheme.display1,
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: changeLocale,
//           tooltip: 'Increment',
//           child: Icon(Icons.add),
//         )); // Th
//   }
// }
//
// class FreeLocalizations extends StatefulWidget {
//   final Widget child;
//
//   FreeLocalizations({Key key, this.child}) : super(key: key);
//
//   @override
//   State<FreeLocalizations> createState() {
//     return new _FreeLocalizations();
//   }
// }
//
// class _FreeLocalizations extends State<FreeLocalizations> {
//   Locale _locale = const Locale('en', '');
//
//   changeLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Localizations.override(
//       context: context,
//       locale: _locale,
//       child: widget.child,
//     );
//   }
//}
// 手动切换语言End
