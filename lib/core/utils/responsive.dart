import 'package:flutter/material.dart';
import 'package:devolio_flutter/core/constants/breakpoints.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < Breakpoints.mobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= Breakpoints.mobile && w < Breakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.tablet;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.wide;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }
}
