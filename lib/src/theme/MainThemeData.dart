import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FBThemeDate {
  static final Color primaryColor = Colors.deepOrange[900]!;
  static final double buttonSizeHeight = 45;
  static final Color backGroundColor = Color(0xFFEFEFF4);

  static ThemeData mainThemeData(Brightness brightness) {
    ThemeData base =
        brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();
    return base.copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backGroundColor,
        backgroundColor: backGroundColor,
        cardTheme: CardTheme(
          color: backGroundColor,
        ),
        textTheme: base.textTheme.copyWith(
          headline1: TextStyle(
              color: primaryColor, fontSize: 40, fontWeight: FontWeight.w300),
          subtitle1: TextStyle(color: Colors.black, fontSize: 16),
          bodyText2: TextStyle(color: Colors.black, fontSize: 12),
        ),
        appBarTheme: AppBarTheme(
          brightness: brightness,
          color: withBright(Colors.grey[50], Colors.black, brightness),
          foregroundColor: withBright(primaryColor, Colors.black, brightness),
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 20,
                color: withBright(primaryColor, Colors.white, brightness)),
          ),
          iconTheme: IconThemeData(
            color: withBright(primaryColor, Colors.white, brightness),
          ),
        ),
        floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
          backgroundColor: withBright(Colors.white, Colors.black, brightness),
          foregroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            side: new BorderSide(color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(22.5)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0.5.sw, buttonSizeHeight),
            side: BorderSide(color: primaryColor, width: 2),
            primary: withBright(Colors.white, Colors.black, brightness),
            textStyle: TextStyle(
                foreground: Paint()..color = primaryColor, fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22.5)),
            ),
          ),
        ),
        iconTheme: IconThemeData.fallback().copyWith(
          color: primaryColor,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryColor.withOpacity(0.7),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        tabBarTheme: TabBarTheme().copyWith(
          unselectedLabelColor: Colors.black54,
          labelColor: Colors.black,
          //unselectedLabelStyle:TextStyle(backgroundColor: Color(0xFFEFEFF4)),
          indicator: BoxDecoration(
            //color: Color(0xFFEFEFF4),
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
            // color: Colors.red,
            ));
  }

  static T withBright<T>(T light, T dark, Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}
