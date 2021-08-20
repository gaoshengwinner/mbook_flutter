// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:mbook_flutter/src/comm/properties/FBColorProperty.dart';
//
// class FBColor extends Color {
//   FBColor.fromProperty({required FBColorProperty property})
//       : super.fromRGBO(
//             property.R ?? Colors.white.red,
//             property.G ?? Colors.white.green,
//             property.B ?? Colors.white.blue,
//             property.O ?? Colors.white.opacity);
//
//   FBColor.fromARGB(int a, int r, int g, int b) : super.fromARGB(a, r, g, b);
//
//   FBColor.fromRGBO(int r, int g, int b, double opacity)
//       : super.fromRGBO(r, g, b, opacity);
//
//   FBColor.fromValue(int value) : super(value);
//
//   FBColor(Color? color)
//       : super(color?.value ?? Colors.white.withOpacity(0).value);
//
//   FBColorProperty getProperty() {
//     return FBColorProperty(
//         R: red, G: green, B: blue, O: opacity);
//   }
//
//   Color toColor() {
//     return Color.fromRGBO(red, green, blue, opacity);
//   }
// }
