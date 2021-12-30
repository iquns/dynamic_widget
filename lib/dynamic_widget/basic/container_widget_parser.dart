import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ContainerWidgetParser extends WidgetParser {
  @override
  String get widgetName => "Container";

  @override
  Type get widgetType => Container;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "alignment": [Alignment, Alignment.topLeft],
      "margin": [EdgeInsetsGeometry, null],
      "padding": [EdgeInsetsGeometry, null],
      "color": [Color, null],
      "width": [double, 0.0],
      "height": [double, 0.0],
      "constraints": [BoxConstraints, null],
      "child": [Widget, null],
      "click_event": [String, ""],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    String? clickEvent = attr.get('click_event');

    var containerWidget = Container(
      alignment: attr.get('alignment'),
      padding: attr.get('padding'),
      color: attr.get('color'),
      margin: attr.get('margin'),
      width: attr.get('width'),
      height: attr.get('height'),
      constraints: attr.get('constraints'),
      child: attr.get('child'),
    );

    var hasClickEvent = clickEvent?.isNotEmpty ?? false;
    if (listener != null && hasClickEvent) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Container;
    var padding = realWidget.padding as EdgeInsets?;
    var margin = realWidget.margin as EdgeInsets?;
    var constraints = realWidget.constraints;
    return <String, dynamic>{
      "type": widgetName,
      "alignment": realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : null,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      "margin": margin != null
          ? "${margin.left},${margin.top},${margin.right},${margin.bottom}"
          : null,
      "constraints":
          constraints != null ? exportConstraints(constraints) : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }
}
