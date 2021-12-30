import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class OverflowBoxWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "alignment": [Alignment, Alignment.topLeft],
      "maxHeight": [double, 0],
      "maxWidth": [double, 0],
      "minHeight": [double, 0],
      "minWidth": [double, 0],
      "child": [Widget, null],
    };
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    OverflowBox realWidget = widget as OverflowBox;
    return <String, dynamic>{
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "minWidth": realWidget.minWidth,
      "maxWidth": realWidget.maxWidth,
      "minHeight": realWidget.minHeight,
      "maxHeight": realWidget.maxHeight,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return OverflowBox(
      alignment: attr.get('alignment'),
      minWidth: attr.get('minWidth'),
      maxWidth: attr.get('maxWidth'),
      minHeight: attr.get('minHeight'),
      maxHeight: attr.get('maxHeight'),
      child: attr.get('child'),
    );
  }

  @override
  String get widgetName => "OverflowBox";

  @override
  Type get widgetType => OverflowBox;
}
