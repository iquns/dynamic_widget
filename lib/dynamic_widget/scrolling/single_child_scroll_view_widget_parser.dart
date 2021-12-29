import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "scrollDirection": [Axis, Axis.vertical],
      // parseClip & parseClipBehavior has different default value
      "clipBehavior": [Clip, Clip.antiAlias],
      "reverse": [bool, false],
      "padding": [EdgeInsetsGeometry, EdgeInsets.zero],
      "child": [Widget, null],
    };
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as SingleChildScrollView;
    String scrollDirection = "vertical";
    if (realWidget.scrollDirection == Axis.horizontal) {
      scrollDirection = "horizontal";
    }

    var padding = realWidget.padding as EdgeInsets?;

    return <String, dynamic>{
      "type": widgetName,
      "scrollDirection": scrollDirection,
      "reverse": realWidget.reverse,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return SingleChildScrollView(
        reverse: attr.get('reverse'),
        clipBehavior: attr.get('clipBehavior'),
        padding: attr.get("padding"),
        scrollDirection: attr.get("scrollDirection"),
        child: attr.get("child"));
  }

  @override
  String get widgetName => "SingleChildScrollView";

  @override
  Type get widgetType => SingleChildScrollView;
}
