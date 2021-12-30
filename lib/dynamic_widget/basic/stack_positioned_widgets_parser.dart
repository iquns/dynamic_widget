import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class PositionedWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "bottom": [double, null],
      "height": [double, null],
      "left": [double, null],
      "right": [double, null],
      "top": [double, null],
      "width": [double, null],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Positioned(
      child: attr.get("child"),
      top: attr.get("top"),
      right: attr.get("right"),
      bottom: attr.get("bottom"),
      left: attr.get("left"),
      width: attr.get("width"),
      height: attr.get("height"),
    );
  }

  @override
  String get widgetName => "Positioned";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Positioned;
    return <String, dynamic>{
      "type": "Positioned",
      "top": realWidget.top ?? null,
      "right": realWidget.right ?? null,
      "bottom": realWidget.bottom ?? null,
      "left": realWidget.left ?? null,
      "width": realWidget.width ?? null,
      "height": realWidget.height ?? null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Positioned;
}

class StackWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "alignment": [Alignment, AlignmentDirectional.topStart],
      "textDirection": [TextDirection, null],
      "fit": [StackFit, StackFit.loose],
      "clipBehavior": [Clip, Clip.hardEdge],
      "children": [Widgets, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Stack(
      alignment: attr.get("alignment"),
      textDirection: attr.get("textDirection"),
      fit: attr.get("fit"),
      clipBehavior: attr.get("clipBehavior"),
      children: attr.get('children'),
    );
  }

  @override
  String get widgetName => "Stack";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Stack;
    return <String, dynamic>{
      "type": "Stack",
      "alignment": realWidget.alignment is AlignmentDirectional
          ? exportAlignmentDirectional(
              realWidget.alignment as AlignmentDirectional)
          : exportAlignment(realWidget.alignment as Alignment),
      "textDirection": exportTextDirection(realWidget.textDirection),
      "fit": exportStackFit(realWidget.fit),
      "clipBehavior": exportClipBehavior(realWidget.clipBehavior),
      "children":
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext)
    };
  }

  @override
  Type get widgetType => Stack;
}
