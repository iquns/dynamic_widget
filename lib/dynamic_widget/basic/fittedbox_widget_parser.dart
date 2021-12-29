import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class FittedBoxWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{};
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return FittedBox(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : Alignment.center,
      fit: map.containsKey("fit") ? parseBoxFit(map["fit"])! : BoxFit.contain,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "FittedBox";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as FittedBox;
    return <String, dynamic>{
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "fit": exportBoxFit(realWidget.fit),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => FittedBox;
}
