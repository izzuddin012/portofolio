import 'package:flutter/material.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class AppContainer extends StatelessWidget {
  final Widget child;

  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double maxWidth = double.infinity;

    if (Responsive.isDesktop(context)) {
      maxWidth = 1100;
    } else if (Responsive.isTablet(context)) {
      maxWidth = 800;
    }

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: child,
      ),
    );
  }
}