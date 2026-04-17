import 'package:flutter/material.dart';
import '../constants/breakpoints.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < Breakpoints.mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.mobile &&
      MediaQuery.sizeOf(context).width < Breakpoints.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.tablet;
}