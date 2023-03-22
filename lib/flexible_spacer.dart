library flexible_spacer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlexibleSpacer extends LeafRenderObjectWidget {
  const FlexibleSpacer({
    Key? key,
    required this.space,
  })  : assert(
          space >= 0 && space < double.infinity,
        ),
        super(key: key);

  final double space;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderFlexibleSpacer(space: space);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderFlexibleSpacer renderObject) {
    renderObject.space = space;
  }
}

class RenderFlexibleSpacer extends RenderBox {
  RenderFlexibleSpacer({
    required double space,
  }) : _space = space;

  double get space => _space;
  double _space;
  set space(double value) {
    if (space != value) {
      _space = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final AbstractNode? flex = parent;
    if (flex == null || flex is! RenderFlex) {
      throw FlutterError(
        'FlexibleSpacer widget must be placed directly inside a Flex widget',
      );
    } else {
      if (flex.direction == Axis.horizontal) {
        size = constraints.constrain(Size(space, 0));
      } else {
        size = constraints.constrain(Size(0, space));
      }
    }
  }
}
