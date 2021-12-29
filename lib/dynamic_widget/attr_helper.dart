import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/common/rounded_rectangle_border_parser.dart';
import 'package:dynamic_widget/dynamic_widget/drop_cap_text.dart';
import 'package:dynamic_widget/dynamic_widget/icons_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/cupertino.dart';

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

  get(String key) {
    List? set = this.mapping[key];
    if (set == null) {
      return null;
    }
    // type
    var attrType = set[0];
    // default value
    var attrDefault = set.length > 1 ? (set[1] ?? null) : null;
    // formatter
    var attrFormatter = set.length > 2 ? (set[2] ?? (v) => v) : (v) => v;

    // contains
    if (values.containsKey(key)) {
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
      TextBaseline: (v) => toStr(v, "") == "alphabetic"
          ? TextBaseline.alphabetic
          : TextBaseline.ideographic,
      EdgeInsetsGeometry: (v) => parseEdgeInsetsGeometry(v),
      Axis: (v) =>
          "horizontal" == toStr(v, "") ? Axis.horizontal : Axis.vertical,
      Clip: (v) => parseClip(v),
      TextStyle: (v) => parseTextStyle(v),
      TextOverflow: (v) => parseTextOverflow(v),
      TextDirection: (v) => parseTextDirection(v),
      TextAlign: (v) => parseTextAlign(v),
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
    };

    var method = methodMap[attrType];

    if (method == null) {
      return attrFormatter(attrDefault);
    }
    var value = method(values[key]);

/*
    if (attrType == String) {
      value = toStr(values[key], attrDefault);
    } else if (attrType == Widget) {
      // print(key + ": widget");
      // build widget
      value = DynamicWidgetBuilder.buildFromMap(
          values[key], buildContext, listener);
    } else if (attrType == Widgets) {
      // print(key + ": widgets");
      value =
          DynamicWidgetBuilder.buildWidgets(values[key], buildContext, listener)
              as List<Widget>;
    } else if (attrType == bool) {
      // print(key + ": bool");
      value = toBool(values[key], attrDefault);
    } else if (attrType == int) {
      // print(key + ": int");
      value = toInt(values[key], attrDefault);
    } else if (attrType == Color) {
      // print(key + ": color");
      value = parseHexColor(values[key]);
    } else if (attrType == Alignment) {
      value = parseAlignment(values[key]);
    } else if (attrType == TextBaseline) {
      value = values[key] == "alphabetic"
          ? TextBaseline.alphabetic
          : TextBaseline.ideographic;
    } else if (attrType == EdgeInsetsGeometry) {
      value = parseEdgeInsetsGeometry(values[key]);
    } else if (attrType == Axis) {
      value = "horizontal" == values[key] ? Axis.horizontal : Axis.vertical;
    } else if (attrType == Clip) {
      value = parseClip(values[key]);
    }*/
    return attrFormatter(value);
  }
}
