import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/drop_cap_text.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class DropCapTextParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "data": [String, ""],
      "selectable": [bool, true],
      "mode": [DropCapMode, DropCapMode.inside],
      "style": [TextStyle, null],
      "dropCapStyle": [TextStyle, null],
      "textAlign": [TextAlign, TextAlign.left],
      "dropCap": [DropCap, null],
      "dropCapPadding": [EdgeInsetsGeometry, ""],
      "dropCapChars": [int, 0],
      "forceNoDescent": [bool, true],
      "parseInlineMarkdown": [bool, true],
      "textDirection": [TextDirection, TextDirection.ltr],
      "overflow": [TextOverflow, TextOverflow.ellipsis],
      "maxLines": [int, null],
      "dropCapPosition": [DropCapPosition, DropCapPosition.start],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    return DropCapText(
      data: attr.get('data'),
      selectable: attr.get('selectable'),
      mode: attr.get('mode'),
      style: attr.get('style'),
      dropCapStyle: attr.get('dropCapStyle'),
      textAlign: attr.get('textAlign'),
      dropCap: attr.get('dropCap'),
      dropCapPadding: attr.get('dropCapPadding'),
      indentation: Offset.zero,
      //todo: actually add this
      dropCapChars: attr.get('dropCapChars'),
      forceNoDescent: attr.get('forceNoDescent'),
      parseInlineMarkdown: attr.get('parseInlineMarkdown'),
      textDirection: attr.get('textDirection'),
      overflow: attr.get('overflow'),
      maxLines: attr.get('maxLines'),
      dropCapPosition: attr.get('dropCapPosition'),
    );
  }

  @override
  String get widgetName => "DropCapText";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as DropCapText;
    var dropCapPadding = realWidget.dropCapPadding;
    return <String, dynamic>{
      "type": widgetName,
      "data": realWidget.data,
      "selectable": realWidget.selectable,
      "mode": exportDropCapMod(realWidget.mode),
      "style": exportTextStyle(realWidget.style),
      "dropCapStyle": exportTextStyle(realWidget.dropCapStyle),
      "textAlign": exportTextAlign(realWidget.textAlign),
      "dropCap": exportDropCap(realWidget.dropCap, buildContext),
      "dropCapPadding": dropCapPadding != null
          ? "${dropCapPadding.left},${dropCapPadding.top},${dropCapPadding.right},${dropCapPadding.bottom}"
          : null,
      "dropCapChars": realWidget.dropCapChars,
      "forceNoDescent": realWidget.forceNoDescent,
      "parseInlineMarkdown": realWidget.parseInlineMarkdown != null
          ? realWidget.parseInlineMarkdown
          : false,
      "textDirection": exportTextDirection(realWidget.textDirection),
      "overflow": exportTextOverflow(realWidget.overflow),
      "maxLines": realWidget.maxLines,
      "dropCapPosition": realWidget.dropCapPosition != null
          ? exportDropCapPosition(realWidget.dropCapPosition)
          : null
    };
  }

  @override
  Type get widgetType => DropCapText;
}
