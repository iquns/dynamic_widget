import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class OffstageWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "offstage": [bool, true],
      "child": [Widget, null],
    };
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    Offstage realWidget = widget as Offstage;
    return <String, dynamic>{
      "type": widgetName,
      "offstage": realWidget.offstage,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Offstage(
      offstage: attr.get('offstage'),
      child: attr.get('child'),
    );
  }

  @override
  String get widgetName => "Offstage";

  @override
  Type get widgetType => Offstage;
}
