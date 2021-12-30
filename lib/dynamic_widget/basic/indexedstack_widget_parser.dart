import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class IndexedStackWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "index": [int, 0],
      "alignment": [Alignment, Alignment.center],
      "textDirection": [TextDirection, null],
      "children": [Widgets, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return IndexedStack(
        index: attr.get("index"),
        alignment: attr.get("alignment"),
        textDirection: attr.get("textDirection"),
        children: attr.get('children'));
  }

  @override
  String get widgetName => "IndexedStack";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as IndexedStack;
    return <String, dynamic>{
      "type": widgetName,
      "index": realWidget.index,
      "alignment": realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : AlignmentDirectional.topStart,
      "textDirection": realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
      "children":
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext)
    };
  }

  @override
  Type get widgetType => IndexedStack;
}
