import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class OpacityWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{};
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Opacity(
      opacity: toDouble(map["opacity"]),
      alwaysIncludeSemantics: toBool(map["alwaysIncludeSemantics"], false),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "Opacity";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Opacity;
    return <String, dynamic>{
      "type": widgetName,
      "opacity": realWidget.opacity,
      "alwaysIncludeSemantics": realWidget.alwaysIncludeSemantics,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Opacity;
}
