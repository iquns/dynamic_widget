import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/common/rounded_rectangle_border_parser.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class CardParser extends WidgetParser {
  @override
  String get widgetName => 'Card';

  @override
  Type get widgetType => Card;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "color": [Color, null],
      "shadowColor": [Color, null],
      "elevation": [double, null],
      "borderOnForeground": [bool, false],
      "margin": [EdgeInsetsGeometry, null],
      "semanticContainer": [bool, false],
      "clipBehavior": [Clip, Clip.antiAlias],
      "child": [Widget, null],
      "shape": [RoundedRectangleBorder, null],
    };
  }


  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    if (widget != null && widget is Card) {
      final EdgeInsets? margin = widget.margin as EdgeInsets?;
      final String? color =
          widget.color != null ? widget.color!.value.toRadixString(16) : null;
      final String? shadowColor = widget.shadowColor != null
          ? widget.shadowColor!.value.toRadixString(16)
          : null;
      final double? elevation = widget.elevation;
      final bool borderOnForeground = widget.borderOnForeground;
      final String? clipBehavior = widget.clipBehavior != null
          ? exportClipBehavior(widget.clipBehavior!)
          : null;
      final String? strMargin = margin != null
          ? "${margin.left},${margin.top},${margin.right},${margin.bottom},"
          : null;
      final bool semanticContainer = widget.semanticContainer;
      final Map<String, dynamic>? childMap =
          DynamicWidgetBuilder.export(widget.child, buildContext);
      final Map<String, dynamic>? shape;
      if (widget.shape != null && widget.shape is RoundedRectangleBorder) {
        shape = RoundedRectangleBorderParser.export(
            widget.shape as RoundedRectangleBorder);
      } else
        shape = null;

      final Map<String, dynamic> map = {
        "type": widgetName,
      };
      if (color != null) map['color'] = color;
      if (shadowColor != null) map['shadowColor'] = shadowColor;
      if (elevation != null) map['elevation'] = toDouble(elevation);
      map['borderOnForeground'] = borderOnForeground;
      if (clipBehavior != null) map['clipBehavior'] = clipBehavior;
      if (strMargin != null) map['margin'] = strMargin;
      map['semanticContainer'] = semanticContainer;
      if (childMap != null) map['child'] = childMap;
      if (shape != null) map['shape'] = shape;

      return map;
    }
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    final Color? color = attr.get('color');
    final Color? shadowColor = attr.get('shadowColor');
    final double? elevation = attr.get('elevation');
    final bool borderOnForeground = attr.get('borderOnForeground');
    final EdgeInsetsGeometry? margin = attr.get('margin');
    final bool semanticContainer = attr.get('semanticContainer');
    final Clip clipBehavior = attr.get('clipBehavior');
    final Widget? child = attr.get('child');
    final RoundedRectangleBorder? shape = attr.get('shape');

    var card = Card(
      color: color,
      shadowColor: shadowColor,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      margin: margin,
      semanticContainer: semanticContainer,
      clipBehavior: clipBehavior,
      child: child,
    );
    return card;
  }
}
