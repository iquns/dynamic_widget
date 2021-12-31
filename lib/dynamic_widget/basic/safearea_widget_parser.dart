import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class SafeAreaWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "bottom": [bool, true],
      "right": [bool, true],
      "top": [bool, true],
      "left": [bool, true],
      "minimum": [EdgeInsetsGeometry, EdgeInsets.zero],
      "maintainBottomViewPadding": [bool, false],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return SafeArea(
      left: attr.get('left'),
      right: attr.get('right'),
      top: attr.get('top'),
      bottom: attr.get('bottom'),
      minimum: attr.get('minimum'),
      maintainBottomViewPadding: attr.get('maintainBottomViewPadding'),
      child: attr.get("child"),
    );
  }

  @override
  String get widgetName => "SafeArea";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as SafeArea;
    var minimum = realWidget.minimum;
    return <String, dynamic>{
      "type": "SafeArea",
      "left": realWidget.left,
      "right": realWidget.right,
      "top": realWidget.top,
      "bottom": realWidget.bottom,
      "minimum": minimum != null
          ? "${minimum.left},${minimum.top},${minimum.right},${minimum.bottom}"
          : null,
      "maintainBottomViewPadding": realWidget.maintainBottomViewPadding,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => SafeArea;
}
