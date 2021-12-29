import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/material.dart';

class AppBarWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as AppBar;

    return <String, dynamic>{
      "type": widgetName,
      "title": realWidget.title == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.title, buildContext),
      "leading": realWidget.leading == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.leading, buildContext),
      "actions": realWidget.actions == null
          ? null
          : DynamicWidgetBuilder.exportWidgets(
              realWidget.actions!, buildContext),
      "centerTitle": realWidget.centerTitle,
      "backgroundColor": realWidget.backgroundColor == null
          ? null
          : realWidget.backgroundColor!.value.toRadixString(16),
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    var appBarWidget = AppBar(
      title: attr.get('title'),
      leading: attr.get('leading'),
      actions: attr.get('actions'),
      centerTitle: attr.get('centerTitle'),
      backgroundColor: attr.get('backgroundColor'),
    );
    return appBarWidget;
  }

  @override
  String get widgetName => "AppBar";

  @override
  Type get widgetType => AppBar;

  @override
  Map<String, List> attrMapping() {
    return {
      "title": [Widget, null],
      "leading": [Widget, null],
      "actions": [Widgets, <dynamic>[]],
      "centerTitle": [bool, false],
      "backgroundColor": [Color, null],
    };
  }
}
