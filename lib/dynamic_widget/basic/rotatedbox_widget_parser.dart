import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class RotatedBoxWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{};
  }

  @override
  Map<String, List> attrMapping() {
    return <String, List>{};
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as RotatedBox;
    return <String, dynamic>{
      "type": widgetName,
      "quarterTurns": realWidget.quarterTurns,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return RotatedBox(
      quarterTurns: toInt(map['quarterTurns']),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "RotatedBox";

  @override
  Type get widgetType => RotatedBox;
}
