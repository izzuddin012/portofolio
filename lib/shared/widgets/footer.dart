import 'package:flutter/material.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class AppFooter extends StatelessWidget {
  final void Function(String) onNav;
  const AppFooter({super.key, required this.onNav});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      color: isDark ? AppColors.surface : AppColors.lightCard,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 40,
      ),
      child: Column(
        children: [
          Container(
            height: 1,
            color: isDark ? AppColors.border : AppColors.lightBorder,
            margin: const EdgeInsets.only(bottom: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} ${AppConstants.name}',
                style: AppTypography.footerText,
              ),
              Text(
                AppConstants.footerBuilt,
                style: AppTypography.footerText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
