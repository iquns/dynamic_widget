import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DividerWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "height": [double, 0.0],
      "thickness": [double, 0.0],
      "indent": [double, 0.0],
      "endIndent": [double, 0.0],
      "color": [Color, null],
    };
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    Divider realWidget = widget as Divider;
    return <String, dynamic>{
      "type": widgetName,
      "height": realWidget.height,
      "thickness": realWidget.thickness,
      "indent": realWidget.indent,
      "endIndent": realWidget.endIndent,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Divider(
      height: attr.get("height"),
      thickness: attr.get("thickness"),
      indent: attr.get("indent"),
      endIndent: attr.get("endIndent"),
      color: parseHexColor(attr.get('color')),
    );
  }

  @override
  String get widgetName => "Divider";

  @override
  Type get widgetType => Divider;
}
