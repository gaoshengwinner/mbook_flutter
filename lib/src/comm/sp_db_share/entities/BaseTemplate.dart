import 'package:floor/floor.dart';
import 'package:mbook_flutter/src/comm/model/FBTableTempProperty.dart';
import 'package:mbook_flutter/src/comm/model/OptionGroupInfo.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/wh_picker.dart';

@entity
class BaseTemplate {
  static const String table_name = "BaseTemplate";
  static const String table_id = "baseTemplateId";

  @primaryKey
  String? baseTemplateId;

  String? json;

  BaseTemplate({this.baseTemplateId, this.json}) {
    try {
      if (json != null) _property = FBTableTempProperty.fromJsonString(json!);
    } on Exception catch (e) {
      throw e;
    }
  }

  factory BaseTemplate.newItem() {
    return BaseTemplate()
      .._property = FBTableTempProperty(
          outSide: TextWidgetProperty(
              minHeight: 50, width: 100, widthUnit: WHOption.sw));
  }

  @ignore
  FBTableTempProperty? _property;

  FBTableTempProperty get property {
    if (_property == null)
      _property = FBTableTempProperty(outSide: TextWidgetProperty());
    return _property!;
  }

  set property(FBTableTempProperty property) {
    _property = property;
  }

  void refresh() {
    json = _property?.getJsonString();
  }
}
