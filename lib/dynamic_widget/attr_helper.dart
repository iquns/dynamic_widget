import 'dart:core';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/basic/text_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/common/rounded_rectangle_border_parser.dart';
import 'package:dynamic_widget/dynamic_widget/drop_cap_text.dart';
import 'package:dynamic_widget/dynamic_widget/icons_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

typedef FunctionConvertAttr = dynamic Function(dynamic v);

class AttrSet {
  final mapping;

  // map values
  final values;

  // build context
  final BuildContext buildContext;

  // listener
  final ClickListener? listener;

  AttrSet(this.mapping, this.values, this.buildContext, this.listener);

  dynamic get(String key) {
    List? set = this.mapping[key];
    if (set == null) {
      print("UnKnownField:" + key);
      return null;
    }
    // type
    var attrType = set[0];
    // default value
    var attrDefault = set.length > 1 ? (set[1] ?? null) : null;
    // formatter
    var attrFormatter = set.length > 2 ? (set[2] ?? (v) => v) : (v) => v;

    // not contains
    if (!values.containsKey(key) || values[key] == null) {
      // print("UnSetField:" + key);
      return attrFormatter(attrDefault);
    }

    // todo cache map
    var methodMap = <Type, FunctionConvertAttr>{
      bool: (v) => toBool(v, attrDefault),
      int: (v) => toInt(v, attrDefault),
      double: (v) => toDouble(v, attrDefault),
      String: (v) => toStr(v, attrDefault),
      Widget: (v) =>
          DynamicWidgetBuilder.buildFromMap(v, buildContext, listener),
      Widgets: (v) =>
          DynamicWidgetBuilder.buildWidgets(v, buildContext, listener),
      Color: (v) => parseHexColor(v),
      Alignment: (v) => parseAlignment(v),
      AlignmentGeometry: (v) => parseAlignment(v),
      CrossAxisAlignment: (v) => parseCrossAxisAlignment(v),
      MainAxisAlignment: (v) => parseMainAxisAlignment(v),
      MainAxisSize: (v) => parseMainAxisSize(v),
      EdgeInsetsGeometry: (v) => parseEdgeInsetsGeometry(v),
      Axis: (v) =>
          "horizontal" == toStr(v, "") ? Axis.horizontal : Axis.vertical,
      Clip: (v) => parseClip(v),
      TextStyle: (v) => parseTextStyle(v),
      TextOverflow: (v) => parseTextOverflow(v),
      TextDirection: (v) => parseTextDirection(v),
      TextAlign: (v) => parseTextAlign(v),
      TextBaseline: (v) => parseTextBaseline(toStr(v, "")),
      TextSpan: (v) =>
          TextSpanParser().parseTextSpan(v, buildContext, listener),
      TextSpans: (v) =>
          TextSpanParser().parseTextSpans(v, buildContext, listener),
      RoundedRectangleBorder: (v) => RoundedRectangleBorderParser.parse(v),
      IconData: (v) => getIconUsingPrefix(name: v),
      BoxConstraints: (v) => parseBoxConstraints(v),
      DropCap: (v) => parseDropCap(v, buildContext, listener),
      DropCapPosition: (v) => parseDropCapPosition(v),
      BoxFit: (v) => parseBoxFit(v),
      BlendMode: (v) => parseBlendMode(v),
      ImageRepeat: (v) => parseImageRepeat(v),
      Rect: (v) => parseRect(v),
      FilterQuality: (v) => parseFilterQuality(v),
      VerticalDirection: (v) => parseVerticalDirection(v),
      StackFit: (v) => parseStackFit(v),
      WrapAlignment: (v) => parseWrapAlignment(v),
      WrapCrossAlignment: (v) => parseWrapCrossAlignment(v),
    };

    var method = methodMap[attrType];

    if (method == null) {
      print("UnSupportMethod:" + attrType.toString());
      return attrFormatter(attrDefault);
    }
    var value = method(values[key] ?? attrDefault);

    return attrFormatter(value);
  }
}

class AttrFormatter {
  static color(v) => v == null ? null : MaterialStateProperty.all(v as Color);

  static padding(v) =>
      v == null ? null : MaterialStateProperty.all(v as EdgeInsetsGeometry);

  static textStyle(v) =>
      v == null ? null : MaterialStateProperty.all(v as TextStyle);

  static double_(double? v) => v == null ? null : MaterialStateProperty.all(v);

  static BorderRadius borderRadius(v) {
    // support space or ,
    List radius =
        v.toString().replaceAll(",", " ").replaceAll(r'\s+', " ").split(" ");
    var len = radius.length;
    double topLeft = toDouble(radius[0], 0.0);
    double topRight = len > 1 ? toDouble(radius[1]) : 0.0;
    double bottomLeft = len > 2 ? toDouble(radius[2]) : 0.0;
    double bottomRight = len > 3 ? toDouble(radius[3]) : 0.0;
    return BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight));
  }
}
