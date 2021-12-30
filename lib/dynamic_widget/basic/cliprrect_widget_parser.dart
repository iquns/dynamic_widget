import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ClipRRectWidgetParser extends WidgetParser {
  @override
  String get widgetName => "ClipRRect";

  @override
  Type get widgetType => ClipRRect;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "borderRadius": [String, "", AttrFormatter.borderRadius],
      "clipBehavior": [Clip, Clip.antiAlias],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return ClipRRect(
      borderRadius: attr.get('borderRadius'),
      clipBehavior: attr.get('clipBehavior'),
      child: attr.get('child'),
    );
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as ClipRRect;
    var borderRadius = realWidget.borderRadius!;
    return <String, dynamic>{
      "type": widgetName,
      "borderRadius":
          "${borderRadius.topLeft.x},${borderRadius.topRight.x},${borderRadius.bottomLeft.x},${borderRadius.bottomRight.x}",
      "clipBehavior": exportClipBehavior(realWidget.clipBehavior),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }
}
