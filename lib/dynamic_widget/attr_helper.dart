import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/cupertino.dart';

import '../dynamic_widget.dart';

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
    var attrDefault = set[1] ?? null;
    // formatter
    var attrFormatter = set[2] ?? null;

    // contains
    if (values.containsKey(key)) {
      return attrDefault;
    }

    var value;
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
    }
    if (attrFormatter != null) {
      value = attrFormatter(value);
    }
    return value;
  }
}
