

import '../../core/adaptive/adaptive_util.dart';

extension AdaptiveExtensions on num {
  double get w => AdaptiveUtil().setWidth(this);

  double get h => AdaptiveUtil().setHeight(this);

  double get r => AdaptiveUtil().radius(this);

  double get sp => AdaptiveUtil().setSp(this);

  ///Multiple of screen width
  double get sw => AdaptiveUtil().screenWidth * this;

  ///Multiple of screen height
  double get sh => AdaptiveUtil().screenHeight * this;
}
