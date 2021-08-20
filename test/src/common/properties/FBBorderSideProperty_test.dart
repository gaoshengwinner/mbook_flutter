//
// import 'package:flutter/material.dart';
// import 'package:mbook_flutter/src/comm/extension/extension_color.dart';
// import 'package:mbook_flutter/src/comm/properties/FBBorderSideProperty.dart';
// import 'package:mbook_flutter/src/comm/properties/FBColorProperty.dart';
// import 'package:test/test.dart';
//
// void main() {
//   test('FBBorderSideProperty to Json String', () {
//     FBBorderSideProperty p = FBBorderSideProperty(
//         colorProperty: FBColorProperty.fromColor(color: Colors.red),
//       width: 20,
//       style: BorderStyle.solid
//     );
//     var string = p.getJsonString();
//     expect(string, equals('{"colorProperty":{"R":244,"B":54,"G":67,"O":1.0},"width":20.0,"style":"solid"}'));
//   });
//
//   test('FBBorderSideProperty from Json String', () {
//     FBBorderSideProperty p = FBBorderSideProperty.fromJsonString('{"colorProperty":{"R":244,"B":54,"G":67,"O":1.0},"width":20.0,"style":"solid"}');
//     expect(FBColor.fromProperty(property: p.colorProperty!).red , equals(Colors.red.red));
//     expect(FBColor.fromProperty(property: p.colorProperty!).blue , equals(Colors.red.blue));
//     expect(FBColor.fromProperty(property: p.colorProperty!).green , equals(Colors.red.green));
//     expect(FBColor.fromProperty(property: p.colorProperty!).opacity , equals(Colors.red.opacity));
//     expect(p.width, equals(20.0));
//     expect(p.style, equals(BorderStyle.solid));
//   });
// }
