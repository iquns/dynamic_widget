import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/icons_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class IconWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{};
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return Icon(
      map.containsKey('data')
          ? getIconUsingPrefix(name: map['data'])
          : Icons.android,
      size: toDouble(map['size'], null),
      color: map.containsKey('color') ? parseHexColor(map['color']) : null,
      semanticLabel: toStr(map['semanticLabel'], null),
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
    );
  }

  @override
  String get widgetName => "Icon";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Icon;
    return <String, dynamic>{
      "type": widgetName,
      "data": exportIconGuessFavorMaterial(realWidget.icon),
      "size": realWidget.size,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      "semanticLabel": realWidget.semanticLabel,
      "textDirection": realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
    };
  }

  @override
  Type get widgetType => Icon;
}
