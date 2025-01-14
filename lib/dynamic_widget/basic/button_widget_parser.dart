import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class RaisedButtonParser extends WidgetParser {
  @override
  String get widgetName => "RaisedButton";

  @override
  Type get widgetType => RaisedButton;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "click_event": [String, ""],
      "color": [Color, null],
      "disabledColor": [Color, null],
      "disabledElevation": [double, 0.0],
      "disabledTextColor": [Color, null],
      "elevation": [double, 0.0],
      "padding": [EdgeInsetsGeometry, null],
      "splashColor": [Color, null],
      "textColor": [Color, null],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    String? clickEvent = attr.get("click_event");

    var raisedButton = RaisedButton(
      color: attr.get("color"),
      disabledColor: attr.get('disabledColor'),
      disabledElevation: attr.get('disabledElevation'),
      disabledTextColor: attr.get('disabledTextColor'),
      elevation: attr.get('elevation'),
      padding: attr.get('padding'),
      splashColor: attr.get('splashColor'),
      textColor: attr.get('textColor'),
      child: attr.get('child'),
      onPressed: () {
        listener!.onClicked(clickEvent);
      },
    );

    return raisedButton;
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as RaisedButton;
    var padding = realWidget.padding as EdgeInsets?;

    return <String, dynamic>{
      "type": widgetName,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      "disabledColor": realWidget.disabledColor != null
          ? realWidget.disabledColor!.value.toRadixString(16)
          : null,
      "disabledElevation": realWidget.disabledElevation,
      "disabledTextColor": realWidget.disabledTextColor != null
          ? realWidget.disabledTextColor!.value.toRadixString(16)
          : null,
      "elevation": realWidget.elevation,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "splashColor": realWidget.splashColor != null
          ? realWidget.splashColor!.value.toRadixString(16)
          : null,
      "textColor": realWidget.textColor != null
          ? realWidget.textColor!.value.toRadixString(16)
          : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }
}

class ElevatedButtonParser extends WidgetParser {
  @override
  String get widgetName => "ElevatedButton";

  @override
  Type get widgetType => ElevatedButton;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "click_event": [String, ""],
      "foregroundColor": [Color, null, AttrFormatter.color],
      "backgroundColor": [Color, null, AttrFormatter.color],
      "overlayColor": [Color, null, AttrFormatter.color],
      "shadowColor": [Color, null, AttrFormatter.color],
      "elevation": [double, null, AttrFormatter.double_],
      "padding": [EdgeInsetsGeometry, null, AttrFormatter.padding],
      "textStyle": [TextStyle, null, AttrFormatter.textStyle],
      "alignment": [Alignment, null],
      "child": [Widget, null],
    };
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as ElevatedButton;
    var color = realWidget.style?.foregroundColor != null
        ? realWidget.style?.foregroundColor
            ?.resolve(MaterialState.values.toSet())
        : null;
    var backgroundColor = realWidget.style?.backgroundColor != null
        ? realWidget.style?.backgroundColor
            ?.resolve(MaterialState.values.toSet())
        : null;
    var overlayColor = realWidget.style?.overlayColor != null
        ? realWidget.style?.overlayColor?.resolve(MaterialState.values.toSet())
        : null;
    var shadowColor = realWidget.style?.shadowColor != null
        ? realWidget.style?.shadowColor?.resolve(MaterialState.values.toSet())
        : null;
    var elevation = realWidget.style?.elevation != null
        ? realWidget.style?.elevation?.resolve(MaterialState.values.toSet())
        : null;
    var edgeInsetsGeometry = realWidget.style?.padding != null
        ? realWidget.style?.padding?.resolve(MaterialState.values.toSet())
            as EdgeInsets?
        : null;
    var textStyle2 = realWidget.style?.textStyle != null
        ? realWidget.style?.textStyle?.resolve(MaterialState.values.toSet())
        : null;
    return <String, dynamic>{
      "type": widgetName,
      "foregroundColor": color != null ? color.value.toRadixString(16) : null,
      "backgroundColor": backgroundColor != null
          ? backgroundColor.value.toRadixString(16)
          : null,
      "overlayColor":
          overlayColor != null ? overlayColor.value.toRadixString(16) : null,
      "shadowColor":
          shadowColor != null ? shadowColor.value.toRadixString(16) : null,
      "elevation": elevation,
      "padding": edgeInsetsGeometry != null
          ? "${edgeInsetsGeometry.left},${edgeInsetsGeometry.top},${edgeInsetsGeometry.right},${edgeInsetsGeometry.bottom}"
          : null,
      "textStyle": exportTextStyle(textStyle2),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    String? clickEvent = attr.get('click_event');

    return ElevatedButton(
        onPressed: () {
          listener!.onClicked(clickEvent);
        },
        style: ButtonStyle(
          foregroundColor: attr.get("foregroundColor"),
          backgroundColor: attr.get("backgroundColor"),
          overlayColor: attr.get("overlayColor"),
          shadowColor: attr.get("shadowColor"),
          elevation: attr.get("elevation"),
          padding: attr.get("padding"),
          textStyle: attr.get("textStyle"),
          alignment: attr.get("alignment"),
        ),
        child: attr.get("child"));
  }
}

class TextButtonParser extends WidgetParser {
  @override
  String get widgetName => "TextButton";

  @override
  Type get widgetType => TextButton;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "click_event": [String, ""],
      "foregroundColor": [Color, null, AttrFormatter.color],
      "backgroundColor": [Color, null, AttrFormatter.color],
      "overlayColor": [Color, null, AttrFormatter.color],
      "shadowColor": [Color, null, AttrFormatter.color],
      "elevation": [double, null, AttrFormatter.double_],
      "padding": [EdgeInsetsGeometry, null, AttrFormatter.padding],
      "textStyle": [TextStyle, null, AttrFormatter.textStyle],
      "alignment": [Alignment, null],
      "child": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    String? clickEvent = attr.get("click_event");

    return TextButton(
        onPressed: () {
          listener!.onClicked(clickEvent);
        },
        style: ButtonStyle(
          foregroundColor: attr.get("foregroundColor"),
          backgroundColor: attr.get("backgroundColor"),
          overlayColor: attr.get("overlayColor"),
          shadowColor: attr.get("shadowColor"),
          elevation: attr.get("elevation"),
          padding: attr.get("padding"),
          textStyle: attr.get("textStyle"),
          alignment: attr.get("alignment"),
        ),
        child: attr.get("child"));
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as TextButton;
    var color = realWidget.style?.foregroundColor != null
        ? realWidget.style?.foregroundColor
            ?.resolve(MaterialState.values.toSet())
        : null;
    var backgroundColor = realWidget.style?.backgroundColor != null
        ? realWidget.style?.backgroundColor
            ?.resolve(MaterialState.values.toSet())
        : null;
    var overlayColor = realWidget.style?.overlayColor != null
        ? realWidget.style?.overlayColor?.resolve(MaterialState.values.toSet())
        : null;
    var shadowColor = realWidget.style?.shadowColor != null
        ? realWidget.style?.shadowColor?.resolve(MaterialState.values.toSet())
        : null;
    var elevation = realWidget.style?.elevation != null
        ? realWidget.style?.elevation?.resolve(MaterialState.values.toSet())
        : null;
    var edgeInsetsGeometry = realWidget.style?.padding != null
        ? realWidget.style?.padding?.resolve(MaterialState.values.toSet())
            as EdgeInsets?
        : null;
    var textStyle2 = realWidget.style?.textStyle != null
        ? realWidget.style?.textStyle?.resolve(MaterialState.values.toSet())
        : null;
    var map = <String, dynamic>{
      "type": widgetName,
      "foregroundColor": color != null ? color.value.toRadixString(16) : null,
      "backgroundColor": backgroundColor != null
          ? backgroundColor.value.toRadixString(16)
          : null,
      "overlayColor":
          overlayColor != null ? overlayColor.value.toRadixString(16) : null,
      "shadowColor":
          shadowColor != null ? shadowColor.value.toRadixString(16) : null,
      "elevation": elevation,
      "padding": edgeInsetsGeometry != null
          ? "${edgeInsetsGeometry.left},${edgeInsetsGeometry.top},${edgeInsetsGeometry.right},${edgeInsetsGeometry.bottom}"
          : null,
      "textStyle": exportTextStyle(textStyle2),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
    return map;
  }
}
