import 'package:flutter/material.dart';
import '../../core/adaptive/adaptive_util.dart';


class AdaptiveUtilInit extends StatelessWidget {
  const AdaptiveUtilInit({
    required this.builder,
    this.designSize = AdaptiveUtil.defaultSize,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;

  final Size designSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (_, Orientation orientation) {
            if (constraints.maxWidth != 0) {
              AdaptiveUtil.init(
                constraints,
                orientation: orientation,
                designSize: designSize,
              );
              return builder();
            }
            return Container();
          },
        );
      },
    );
  }
}
