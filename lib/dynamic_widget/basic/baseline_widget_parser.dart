import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/widgets.dart';

class BaselineWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "baseline": [double, 0.0],
      "baselineType": [TextBaseline, TextBaseline.ideographic],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Baseline(
      baseline: attr.get("baseline"),
      baselineType: attr.get("baselineType"),
      child: attr.get("child"),
    );
  }

  @override
  String get widgetName => "Baseline";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Baseline;
    return <String, dynamic>{
      "type": widgetName,
      "baseline": realWidget.baseline,
      "baselineType": realWidget.baselineType == TextBaseline.alphabetic
          ? "alphabetic"
          : "ideographic",
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Baseline;
}
