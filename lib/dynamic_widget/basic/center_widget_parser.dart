import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/widgets.dart';

class CenterWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "widthFactor": [double, null],
      "heightFactor": [double, null],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Center(
      widthFactor: attr.get("widthFactor"),
      heightFactor: attr.get("heightFactor"),
      child: attr.get("child"),
    );
  }

  @override
  String get widgetName => "Center";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Center;
    return <String, dynamic>{
      "type": widgetName,
      "widthFactor": realWidget.widthFactor,
      "heightFactor": realWidget.heightFactor,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Center;
}
