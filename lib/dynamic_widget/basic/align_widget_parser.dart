import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../attr_helper.dart';

class AlignWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return {
      "alignment": [Alignment, Alignment.center],
      "widthFactor": [double, null],
      "heightFactor": [double, null],
      "child": [Widget, false],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Align(
      alignment: attr.get("alignment"),
      widthFactor: attr.get("widthFactor"),
      heightFactor: attr.get("heightFactor"),
      child: attr.get("child"),
    );
  }

  @override
  String get widgetName => "Align";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Align;
    Map<String, dynamic> json = {
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "widthFactor": realWidget.widthFactor,
      "heightFactor": realWidget.heightFactor,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
    return json;
  }

  @override
  Type get widgetType => Align;
}
