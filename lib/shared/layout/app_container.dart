import 'package:flutter/material.dart';
import 'package:devolio_flutter/core/constants/breakpoints.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AppContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: 96,
            ),
        child: child,
      ),
    );
  }
}
