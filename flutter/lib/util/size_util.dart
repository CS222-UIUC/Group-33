import 'package:flutter/material.dart';

Size deviceSize = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;
const double designWidth = 428;
const double designHeight = 926;
const double designStatusBar = 39;

///This method is used to get device viewport width.
double get width {
  return deviceSize.width;
}

///This method is used to get device viewport height.
double get height {
  return deviceSize.height - MediaQueryData.fromWindow(
      WidgetsBinding.instance.window,
  ).viewPadding.top;
}

///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
double getHorizontalSize(double px) {
  return (px * width) / designWidth;
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(double px) {
  return (px * height) / (designHeight - designStatusBar);
}

///This method is used to set smallest px in image height and width
double getSize(double px) {
  final height = getVerticalSize(px);
  final width  = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

///This method is used to set text font size according to Viewport
double getFontSize(double px) {
  return getSize(px);
}

///This method is used to set padding responsively
EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

///This method is used to set margin responsively
EdgeInsetsGeometry getMargin({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

///This method is used to set margin responsively
EdgeInsetsGeometry getMarginOrPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return EdgeInsets.only(
    left: getHorizontalSize(
      all ?? (left ?? 0),
    ),
    top: getVerticalSize(
      all ?? (top ?? 0),
    ),
    right: getHorizontalSize(
      all ?? (right ?? 0),
    ),
    bottom: getVerticalSize(
      all ?? (bottom ?? 0),
    ),
  );
}
