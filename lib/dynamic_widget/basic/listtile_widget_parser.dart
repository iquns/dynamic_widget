import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListTileWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "isThreeLine": [bool, false],
      "contentPadding": [EdgeInsetsGeometry, null],
      "dense": [bool, false],
      "enable": [bool, true],
      "leading": [Widget, null],
      "selected": [bool, false],
      "subtitle": [Widget, null],
      "title": [Widget, null],
      "trailing": [Widget, null],
      "tapEvent": [String, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    bool isThreeLine = attr.get("isThreeLine");
    EdgeInsetsGeometry? contentPadding = attr.get("contentPadding");
    bool? dense = attr.get("dense");
    bool enabled = attr.get("enabled");
    Widget? leading = attr.get("leading");
    bool selected = attr.get("selected");
    Widget? subtitle = attr.get("subtitle");
    Widget? title = attr.get("title");
    Widget? trailing = attr.get("trailing");
    String? tapEvent = attr.get("tapEvent");

    return ListTile(
      isThreeLine: isThreeLine,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: () {
        if (listener != null && tapEvent != null) {
          listener.onClicked(tapEvent);
        }
      },
      selected: selected,
    );
  }

  @override
  String get widgetName => "ListTile";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as ListTile;
    var contentPadding = realWidget.contentPadding as EdgeInsets?;
    return <String, dynamic>{
      "type": widgetName,
      "isThreeLine": realWidget.isThreeLine,
      "leading": realWidget.leading != null
          ? DynamicWidgetBuilder.export(realWidget.leading, buildContext)
          : null,
      "title": realWidget.title != null
          ? DynamicWidgetBuilder.export(realWidget.title, buildContext)
          : null,
      "subtitle": realWidget.subtitle != null
          ? DynamicWidgetBuilder.export(realWidget.subtitle, buildContext)
          : null,
      "trailing": realWidget.trailing != null
          ? DynamicWidgetBuilder.export(realWidget.trailing, buildContext)
          : null,
      "dense": realWidget.dense,
      "contentPadding": contentPadding != null
          ? "${contentPadding.left},${contentPadding.top},${contentPadding.right},${contentPadding.bottom}"
          : null,
      "enabled": realWidget.enabled,
      "selected": realWidget.selected
    };
  }

  @override
  Type get widgetType => ListTile;
}
