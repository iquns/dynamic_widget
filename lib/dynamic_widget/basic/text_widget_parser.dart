import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class TextWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "data": [String, ""],
      "textAlign": [TextAlign, TextAlign.left],
      "overflow": [TextOverflow, TextOverflow.ellipsis],
      "maxLines": [int, null],
      "semanticsLabel": [String, ""],
      "softWrap": [bool, true],
      "textDirection": [TextDirection, TextDirection.ltr],
      "textScaleFactor": [double, null],
      "textSpan": [TextSpan, null],
      "style": [TextStyle, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    var textSpan = attr.get('textSpan');

    if (textSpan == null) {
      return Text(
        attr.get('data')!,
        textAlign: attr.get('textAlign'),
        overflow: attr.get('overflow'),
        maxLines: attr.get('maxLines'),
        semanticsLabel: attr.get('semanticsLabel'),
        softWrap: attr.get('softWrap'),
        textDirection: attr.get('textDirection'),
        style: attr.get('style'),
        textScaleFactor: attr.get('textScaleFactor'),
      );
    } else {
      return Text.rich(
        textSpan,
        textAlign: attr.get('textAlign'),
        overflow: attr.get('overflow'),
        maxLines: attr.get('maxLines'),
        semanticsLabel: attr.get('semanticsLabel'),
        softWrap: attr.get('softWrap'),
        textDirection: attr.get('textDirection'),
        style: attr.get('style'),
        textScaleFactor: attr.get('textScaleFactor'),
      );
    }
  }

  @override
  String get widgetName => "Text";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Text;
    if (realWidget.textSpan == null) {
      return <String, dynamic>{
        "type": "Text",
        "data": realWidget.data,
        "textAlign": realWidget.textAlign != null
            ? exportTextAlign(realWidget.textAlign)
            : "start",
        "overflow": realWidget.overflow != null
            ? exportTextOverflow(realWidget.overflow)
            : "ellipsis",
        "maxLines": realWidget.maxLines,
        "semanticsLabel": realWidget.semanticsLabel,
        "softWrap": realWidget.softWrap,
        "textDirection": exportTextDirection(realWidget.textDirection),
        "style": exportTextStyle(realWidget.style),
        "textScaleFactor": realWidget.textScaleFactor
      };
    } else {
      var parser = TextSpanParser();
      return <String, dynamic>{
        "type": "Text",
        "textSpan": parser.export(realWidget.textSpan as TextSpan, null),
        "textAlign": realWidget.textAlign != null
            ? exportTextAlign(realWidget.textAlign)
            : "start",
        "overflow": realWidget.overflow != null
            ? exportTextOverflow(realWidget.overflow)
            : "ellipsis",
        "maxLines": realWidget.maxLines,
        "semanticsLabel": realWidget.semanticsLabel,
        "softWrap": realWidget.softWrap,
        "textDirection": exportTextDirection(realWidget.textDirection),
        "style": exportTextStyle(realWidget.style),
        "textScaleFactor": realWidget.textScaleFactor
      };
    }
  }

  @override
  Type get widgetType => Text;

  @override
  bool matchWidgetForExport(Widget? widget) => widget is Text;
}

class TextSpanParser {
  Map<String, List> attrMapping() {
    return <String, List>{
      "recognizer": [String, ""],
      "text": [String, ""],
      "style": [TextStyle, null],
      "children": [TextSpans, null],
    };
  }

  List<InlineSpan> parseTextSpans(
      List<dynamic> children, BuildContext context, ClickListener? listener) {
    return children.map((e) {
      return TextSpanParser().parseTextSpan(e, context, listener);
    }).toList();
  }

  TextSpan parseTextSpan(
      Map<String, dynamic> map, BuildContext context, ClickListener? listener) {
    var attr = AttrSet(attrMapping(), map, context, listener);
    var textSpan = TextSpan(
        text: attr.get('text'),
        style: attr.get('style'),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            listener!.onClicked(attr.get('recognizer'));
          },
        children: attr.get('children'));

    return textSpan;
  }

  Map<String, dynamic> export(TextSpan textSpan, BuildContext? context) {
    return <String, dynamic>{
      "text": textSpan.text,
      "style": exportTextStyle(textSpan.style),
      "children": exportChildren(textSpan)
    };
  }

  List<Map<String, dynamic>> exportChildren(TextSpan textSpan) {
    List<Map<String, dynamic>> rt = [];
    if (textSpan.children != null && textSpan.children!.isNotEmpty) {
      for (var span in textSpan.children!) {
        rt.add(export(span as TextSpan, null));
      }
    }
    return rt;
  }
}
