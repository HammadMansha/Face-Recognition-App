import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(); // Use the desired ScrollPhysics
  }

  Widget wrapScrollView(BuildContext context, Widget child) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down, // Set the desired scroll direction
      color: Colors.transparent, // Set the desired scroll color
      child: child,
    );
  }
}