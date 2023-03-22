library flexible_spacer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverFlexibleSpacer extends SingleChildRenderObjectWidget {
  SliverFlexibleSpacer({
    super.key,
    required double space,
  }) : super(
          child: SizedBox(
            height: space,
            width: space,
          ),
        );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverFlexibleSpacer();
  }
}

class RenderSliverFlexibleSpacer extends RenderSliverSingleBoxAdapter {
  RenderSliverFlexibleSpacer({
    super.child,
  });

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}
