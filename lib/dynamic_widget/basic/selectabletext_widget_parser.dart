import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:dynamic_widget/dynamic_widget/basic/text_widget_parser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SelectableTextWidgetParser implements WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "data": [String, ""],
      "textAlign": [TextAlign, TextAlign.left],
      "maxLines": [int, null],
      "textDirection": [TextDirection, TextDirection.ltr],
      "textSpan": [Widget, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
//    double textScaleFactor = map['textScaleFactor'];
    var textSpan = attr.get('textSpan');
    if (textSpan == null) {
      return SelectableText(attr.get('data')!,
          textAlign: attr.get('textAlign'),
          maxLines: attr.get('maxLines'),
          textDirection: attr.get('textDirection'),
          style: attr.get('style')
//        textScaleFactor: textScaleFactor,
          );
    } else {
      return SelectableText.rich(textSpan,
          textAlign: attr.get('textAlign'),
          maxLines: attr.get('maxLines'),
          textDirection: attr.get('textDirection'),
          style: attr.get('style')
//        textScaleFactor: textScaleFactor,
          );
    }
  }

  @override
  String get widgetName => "SelectableText";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as SelectableText;
    if (realWidget.textSpan == null) {
      return <String, dynamic>{
        "type": "SelectableText",
        "data": realWidget.data,
        "textAlign": realWidget.textAlign != null
            ? exportTextAlign(realWidget.textAlign)
            : "start",
        "maxLines": realWidget.maxLines,
        "textDirection": exportTextDirection(realWidget.textDirection),
        "style": exportTextStyle(realWidget.style),
      };
    } else {
      var parser = TextSpanParser();
      return <String, dynamic>{
        "type": "SelectableText",
        "textSpan": parser.export(realWidget.textSpan! as Widget, null),
        "textAlign": realWidget.textAlign != null
            ? exportTextAlign(realWidget.textAlign)
            : "start",
        "maxLines": realWidget.maxLines,
        "textDirection": exportTextDirection(realWidget.textDirection),
        "style": exportTextStyle(realWidget.style),
      };
    }
  }

  @override
  bool matchWidgetForExport(Widget? widget) => widget is SelectableText;

  @override
  Type get widgetType => SelectableText;
}
