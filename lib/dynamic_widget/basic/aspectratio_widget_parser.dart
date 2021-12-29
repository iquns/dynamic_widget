import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/widgets.dart';

class AspectRatioWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "aspectRatio": [double, 0.0],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return AspectRatio(
      aspectRatio: attr.get("aspectRatio"),
      child: attr.get("child"),
    );
  }

  @override
  String get widgetName => "AspectRatio";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as AspectRatio;
    return <String, dynamic>{
      "type": widgetName,
      "aspectRatio": realWidget.aspectRatio,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => AspectRatio;
}
