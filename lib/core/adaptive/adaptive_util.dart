import 'dart:math';

import 'package:flutter/material.dart';

class AdaptiveUtil {
  factory AdaptiveUtil() {
    return _instance;
  }
  AdaptiveUtil._();

  static const Size defaultSize = Size(360, 640);
  static late AdaptiveUtil _instance;

  late Size uiSize;

  late Orientation _orientation;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  static void init(
    BoxConstraints constraints, {
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
  }) {
    _instance = AdaptiveUtil._()
      ..uiSize = designSize
      .._orientation = orientation
      .._screenWidth = constraints.maxWidth
      .._screenHeight = constraints.maxHeight;

    final window = WidgetsBinding.instance.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  Orientation get orientation => _orientation;

  double get textScaleFactor => _textScaleFactor;

  double get pixelRatio => _pixelRatio;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  double setWidth(num width) => width * scaleWidth;

  double setHeight(num height) => height * scaleHeight;

  double radius(num r) => r * scaleText;

  double setSp(num fontSize) => fontSize * scaleText;
}
