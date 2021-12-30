import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ScaffoldWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "appBar": [Widget, null],
      "body": [Widget, null],
      "floatingActionButton": [Widget, null],
      "backgroundColor": [Color, null],
    };
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Scaffold;

    return <String, dynamic>{
      "type": widgetName,
      "body": DynamicWidgetBuilder.export(realWidget.body, buildContext),
      "appBar": DynamicWidgetBuilder.export(realWidget.appBar, buildContext),
      "floatingActionButton": DynamicWidgetBuilder.export(
          realWidget.floatingActionButton, buildContext),
      "backgroundColor": realWidget.backgroundColor != null
          ? realWidget.backgroundColor!.value.toRadixString(16)
          : null,
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    var scaffoldWidget = Scaffold(
      appBar: attr.get("appBar") as PreferredSizeWidget,
      body: attr.get("body"),
      floatingActionButton: attr.get("floatingActionButton"),
      backgroundColor: attr.get("backgroundColor"),
    );

    return scaffoldWidget;
  }

  @override
  String get widgetName => "Scaffold";

  @override
  Type get widgetType => Scaffold;
}
