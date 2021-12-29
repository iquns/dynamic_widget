import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:flutter/widgets.dart';

class PageViewWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "scrollDirection": [Axis, Axis.vertical],
      "reverse": [bool, false],
      "pageSnapping": [bool, true],
      "children": [Widgets, null],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    var scrollDirection = attr.get("scrollDirection");
    return PageView(
      scrollDirection: scrollDirection,
      reverse: attr.get("reverse"),
      pageSnapping: attr.get("pageSnapping"),
      children: attr.get('children'),
    );
  }

  @override
  String get widgetName => "PageView";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as PageView;
    String scrollDirection = "vertical";
    if (realWidget.scrollDirection == Axis.horizontal) {
      scrollDirection = "horizontal";
    }
    var children = realWidget.childrenDelegate as SliverChildListDelegate;
    return <String, dynamic>{
      "type": "PageView",
      "scrollDirection": scrollDirection,
      "reverse": realWidget.reverse,
      "pageSnapping": realWidget.pageSnapping,
      "children":
          DynamicWidgetBuilder.exportWidgets(children.children, buildContext)
    };
  }

  @override
  Type get widgetType => PageView;
}
