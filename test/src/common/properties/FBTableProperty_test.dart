import 'dart:ui';

import 'package:mbook_flutter/src/comm/properties/FBTableProperty.dart';
import 'package:test/test.dart';

void main() {
  test('TextDirection ltr to Json String', () {
    FBTableProperty p = FBTableProperty(textDirection: TextDirection.ltr);
    var string = p.getJsonString();
    expect(string, equals('{"textDirection":"ltr"}'));
  });

  test('TextDirection rtl to Json String', () {
    FBTableProperty p = FBTableProperty(textDirection: TextDirection.rtl);
    var string = p.getJsonString();
    expect(string, equals('{"textDirection":"rtl"}'));
  });

  test("ltr json to TextDirection", () {
    expect(
        FBTableProperty.fromJsonString('{"textDirection":"ltr"}').textDirection,
        equals(TextDirection.ltr));
  });

  test("rtl json to TextDirection", () {
    expect(
        FBTableProperty.fromJsonString('{"textDirection":"rtl"}').textDirection,
        equals(TextDirection.rtl));
  });
}
