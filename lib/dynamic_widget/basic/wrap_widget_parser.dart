import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class WrapWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "alignment": [WrapAlignment, WrapAlignment.start],
      "crossAxisAlignment": [WrapCrossAlignment, WrapCrossAlignment.start],
      "direction": [Axis, Axis.horizontal],
      "runAlignment": [WrapAlignment, WrapAlignment.start],
      "runSpacing": [double, 0.0],
      "spacing": [double, 0.0],
      "textDirection": [TextDirection, TextDirection.ltr],
      "verticalDirection": [VerticalDirection, VerticalDirection.down],
      "children": [Widgets, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Wrap(
      direction: attr.get("direction"),
      alignment: attr.get("alignment"),
      spacing: attr.get("spacing"),
      runAlignment: attr.get("runAlignment"),
      runSpacing: attr.get("runSpacing"),
      crossAxisAlignment: attr.get("crossAxisAlignment"),
      textDirection: attr.get("textDirection"),
      verticalDirection: attr.get("verticalDirection"),
      children: attr.get('children'),
    );
  }

  @override
  String get widgetName => "Wrap";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Wrap;
    return <String, dynamic>{
      "type": "Wrap",
      "direction":
          realWidget.direction == Axis.horizontal ? "horizontal" : "vertical",
      "alignment": exportWrapAlignment(realWidget.alignment),
      "spacing": realWidget.spacing,
      "runAlignment": exportWrapAlignment(realWidget.runAlignment),
      "runSpacing": realWidget.runSpacing,
      "crossAxisAlignment":
          exportWrapCrossAlignment(realWidget.crossAxisAlignment),
      "textDirection": realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
      "verticalDirection":
          realWidget.verticalDirection == VerticalDirection.up ? "up" : "down",
      "children":
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext)
    };
  }

  @override
  Type get widgetType => Wrap;
}
