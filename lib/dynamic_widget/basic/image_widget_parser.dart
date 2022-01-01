import 'dart:ui';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/attr_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class AssetImageWidgetParser extends WidgetParser {
  @override
  String get widgetName => "AssetImage";

  @override
  Type get widgetType => AssetImage;

  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "name": [String, null],
      "semanticLabel": [String, null],
      "excludeFromSemantics": [bool, false],
      "scale": [double, null],
      "width": [double, null],
      "height": [double, null],
      "color": [Color, null],
      "colorBlendMode": [BlendMode, null],
      "fit": [BoxFit, null],
      "alignment": [Alignment, Alignment.center],
      "repeat": [ImageRepeat, ImageRepeat.noRepeat],
      "centerSlice": [Rect, null],
      "matchTextDirection": [bool, false],
      "gaplessPlayback": [bool, false],
      "filterQuality": [FilterQuality, FilterQuality.low],
      "click_event": [String, ""],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    String name = attr.get('name');
    String? semanticLabel = attr.get('semanticLabel');
    bool excludeFromSemantics = attr.get('excludeFromSemantics');
    double? scale = attr.get('scale');
    double? width = attr.get('width');
    double? height = attr.get('height');
    Color? color = attr.get('color');
    BlendMode? colorBlendMode = attr.get('colorBlendMode');
    BoxFit? fit = attr.get('fit');
    Alignment alignment = attr.get('alignment');
    ImageRepeat repeat = attr.get('repeat');
    Rect? centerSlice = attr.get('centerSlice');
    bool matchTextDirection = attr.get('matchTextDirection');
    bool gaplessPlayback = attr.get('gaplessPlayback');
    FilterQuality filterQuality = attr.get('filterQuality');
    String? clickEvent = attr.get('click_event');

    var widget = Image.asset(
      name,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    if (_isMatchAssetImageType(widget)) {
      var realWidget = widget as Image;
      late AssetImage assetImage;
      if (realWidget.image is AssetImage) {
        assetImage = realWidget.image as AssetImage;
      } else if (realWidget.image is ResizeImage) {
        var t = realWidget.image as ResizeImage;
        assetImage = t.imageProvider as AssetImage;
      }
      return <String, dynamic>{
        "type": widgetName,
        "name": assetImage.assetName,
        "semanticLabel": realWidget.semanticLabel,
        "excludeFromSemantics": realWidget.excludeFromSemantics,
        "width": realWidget.width,
        "height": realWidget.height,
        "color": realWidget.color != null
            ? realWidget.color!.value.toRadixString(16)
            : null,
        "colorBlendMode": realWidget.colorBlendMode != null
            ? exportBlendMode(realWidget.colorBlendMode)
            : null,
        "fit": realWidget.fit != null ? exportBoxFit(realWidget.fit) : null,
        "alignment": realWidget.alignment != null
            ? exportAlignment(realWidget.alignment as Alignment?)
            : null,
        "repeat": realWidget.repeat != null
            ? exportImageRepeat(realWidget.repeat)
            : null,
        "centerSlice": realWidget.centerSlice != null
            ? exportRect(realWidget.centerSlice!)
            : null,
        "matchTextDirection": realWidget.matchTextDirection,
        "gaplessPlayback": realWidget.gaplessPlayback,
        "filterQuality": realWidget.filterQuality != null
            ? exportFilterQuality(realWidget.filterQuality)
            : null
      };
    }

    if (_isMatchExactAssetImageType(widget)) {
      var realWidget = widget as Image;
      late ExactAssetImage exactAssetImage;
      if (realWidget.image is ExactAssetImage) {
        exactAssetImage = realWidget.image as ExactAssetImage;
      } else if (realWidget.image is ResizeImage) {
        var t = realWidget.image as ResizeImage;
        exactAssetImage = t.imageProvider as ExactAssetImage;
      }
      return <String, dynamic>{
        "type": widgetName,
        "name": exactAssetImage.assetName,
        "semanticLabel": realWidget.semanticLabel,
        "excludeFromSemantics": realWidget.excludeFromSemantics,
        "scale": exactAssetImage.scale,
        "width": realWidget.width,
        "height": realWidget.height,
        "color": realWidget.color != null
            ? realWidget.color!.value.toRadixString(16)
            : null,
        "colorBlendMode": realWidget.colorBlendMode != null
            ? exportBlendMode(realWidget.colorBlendMode)
            : null,
        "fit": realWidget.fit != null ? exportBoxFit(realWidget.fit) : null,
        "alignment": realWidget.alignment != null
            ? exportAlignment(realWidget.alignment as Alignment?)
            : null,
        "repeat": realWidget.repeat != null
            ? exportImageRepeat(realWidget.repeat)
            : null,
        "centerSlice": realWidget.centerSlice != null
            ? exportRect(realWidget.centerSlice!)
            : null,
        "matchTextDirection": realWidget.matchTextDirection,
        "gaplessPlayback": realWidget.gaplessPlayback,
        "filterQuality": realWidget.filterQuality != null
            ? exportFilterQuality(realWidget.filterQuality)
            : null
      };
    }

    return null;
  }

  bool _isMatchAssetImageType(Widget? widget) {
    if (widget is Image) {
      if (widget.image is AssetImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var resizeImage = widget.image as ResizeImage;
        return resizeImage.imageProvider is AssetImage;
      }
    }
    return false;
  }

  bool _isMatchExactAssetImageType(Widget? widget) {
    if (widget is Image) {
      if (widget.image is ExactAssetImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var resizeImage = widget.image as ResizeImage;
        return resizeImage.imageProvider is ExactAssetImage;
      }
    }
    return false;
  }

  @override
  bool matchWidgetForExport(Widget? widget) =>
      _isMatchAssetImageType(widget) || _isMatchExactAssetImageType(widget);
}

class NetworkImageWidgetParser extends WidgetParser {
  @override
  Map<String, List> attrMapping() {
    return <String, List>{
      "src": [String, null],
      "semanticLabel": [String, null],
      "excludeFromSemantics": [bool, false],
      "scale": [double, 1.0],
      "width": [double, null],
      "height": [double, null],
      "color": [Color, null],
      "colorBlendMode": [BlendMode, null],
      "fit": [BoxFit, null],
      "alignment": [Alignment, Alignment.center],
      "repeat": [ImageRepeat, ImageRepeat.noRepeat],
      "centerSlice": [Rect, null],
      "matchTextDirection": [bool, false],
      "gaplessPlayback": [bool, false],
      "filterQuality": [FilterQuality, FilterQuality.low],
      "click_event": [String, ""],
    };
  }

  @override
  Widget parse(
      AttrSet attr, BuildContext buildContext, ClickListener? listener) {
    String src = attr.get('src');
    String? semanticLabel = attr.get('semanticLabel');
    bool excludeFromSemantics = attr.get('excludeFromSemantics');
    double scale = attr.get('scale');
    double? width = attr.get('width');
    double? height = attr.get('height');
    Color? color = attr.get('color');
    BlendMode? colorBlendMode = attr.get('colorBlendMode');
    BoxFit? fit = attr.get('fit');
    Alignment alignment = attr.get('alignment');
    ImageRepeat repeat = attr.get('repeat');
    Rect? centerSlice = attr.get('centerSlice');
    bool matchTextDirection = attr.get('matchTextDirection');
    bool gaplessPlayback = attr.get('gaplessPlayback');
    FilterQuality filterQuality = attr.get('filterQuality');

    String? clickEvent = attr.get('click_event');

    var widget = Image.network(
      src,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  String get widgetName => "NetworkImage";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Image;
    late NetworkImage networkImage;
    if (realWidget.image is NetworkImage) {
      networkImage = realWidget.image as NetworkImage;
    } else if (realWidget.image is ResizeImage) {
      var t = realWidget.image as ResizeImage;
      networkImage = t.imageProvider as NetworkImage;
    }
    return <String, dynamic>{
      "type": widgetName,
      "src": networkImage.url,
      "semanticLabel": realWidget.semanticLabel,
      "excludeFromSemantics": realWidget.excludeFromSemantics,
      "width": realWidget.width,
      "height": realWidget.height,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      "colorBlendMode": realWidget.colorBlendMode != null
          ? exportBlendMode(realWidget.colorBlendMode)
          : null,
      "fit": realWidget.fit != null ? exportBoxFit(realWidget.fit) : null,
      "alignment": realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : null,
      "repeat": realWidget.repeat != null
          ? exportImageRepeat(realWidget.repeat)
          : null,
      "centerSlice": realWidget.centerSlice != null
          ? exportRect(realWidget.centerSlice!)
          : null,
      "matchTextDirection": realWidget.matchTextDirection,
      "gaplessPlayback": realWidget.gaplessPlayback,
      "filterQuality": realWidget.filterQuality != null
          ? exportFilterQuality(realWidget.filterQuality)
          : null
    };
  }

  @override
  Type get widgetType => NetworkImage;

  @override
  bool matchWidgetForExport(Widget? widget) {
    if (widget is Image) {
      if (widget.image is NetworkImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var t = widget.image as ResizeImage;
        return t.imageProvider is NetworkImage;
      }
    }
    return false;
  }
}
