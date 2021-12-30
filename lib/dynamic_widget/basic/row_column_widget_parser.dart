import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class RowWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "crossAxisAlignment": [CrossAxisAlignment, CrossAxisAlignment.center],
      "mainAxisAlignment": [MainAxisAlignment, MainAxisAlignment.start],
      "mainAxisSize": [MainAxisSize, MainAxisSize.max],
      "textBaseline": [TextBaseline, TextBaseline.ideographic],
      "textDirection": [TextDirection, TextDirection.ltr],
      "verticalDirection": [VerticalDirection, VerticalDirection.down],
      "children": [Widgets, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Row(
      crossAxisAlignment: attr.get('crossAxisAlignment'),
      mainAxisAlignment: attr.get('mainAxisAlignment'),
      mainAxisSize: attr.get('mainAxisSize'),
      textBaseline: attr.get('textBaseline'),
      textDirection: attr.get('textDirection'),
      verticalDirection: attr.get('verticalDirection'),
      children: attr.get('children'),
    );
  }

  @override
  String get widgetName => "Row";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Row;
    return <String, dynamic>{
      "type": "Row",
      "crossAxisAlignment":
          exportCrossAxisAlignment(realWidget.crossAxisAlignment),
      "mainAxisAlignment":
          exportMainAxisAlignment(realWidget.mainAxisAlignment),
      "mainAxisSize":
          realWidget.mainAxisSize == MainAxisSize.max ? "max" : "min",
      "textBaseline": realWidget.textBaseline == TextBaseline.alphabetic
          ? "alphabetic"
          : "ideographic",
      "textDirection": realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
      "verticalDirection":
          realWidget.verticalDirection == VerticalDirection.down
              ? "down"
              : "up",
      "children":
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext),
    };
  }

  @override
  Type get widgetType => Row;
}

class ColumnWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "crossAxisAlignment": [CrossAxisAlignment, CrossAxisAlignment.center],
      "mainAxisAlignment": [MainAxisAlignment, MainAxisAlignment.start],
      "mainAxisSize": [MainAxisSize, MainAxisSize.max],
      "textBaseline": [TextBaseline, TextBaseline.ideographic],
      "textDirection": [TextDirection, TextDirection.ltr],
      "verticalDirection": [VerticalDirection, VerticalDirection.down],
      "children": [Widgets, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Column(
      crossAxisAlignment: attr.get('crossAxisAlignment'),
      mainAxisAlignment: attr.get('mainAxisAlignment'),
      mainAxisSize: attr.get('mainAxisSize'),
      textBaseline: attr.get('textBaseline'),
      textDirection: attr.get('textDirection'),
      verticalDirection: attr.get('verticalDirection'),
      children: attr.get('children'),
    );
  }

  @override
  String get widgetName => "Column";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Column;
    return <String, dynamic>{
      "type": "Column",
      "crossAxisAlignment":
          exportCrossAxisAlignment(realWidget.crossAxisAlignment),
      "mainAxisAlignment":
          exportMainAxisAlignment(realWidget.mainAxisAlignment),
      "mainAxisSize":
          realWidget.mainAxisSize == MainAxisSize.max ? "max" : "min",
      "textBaseline": realWidget.textBaseline == TextBaseline.alphabetic
          ? "alphabetic"
          : "ideographic",
      "textDirection": realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
      "verticalDirection":
          realWidget.verticalDirection == VerticalDirection.down
              ? "down"
              : "up",
      "children":
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext),
    };
  }

  @override
  Type get widgetType => Column;
}
