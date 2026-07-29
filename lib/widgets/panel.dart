import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding = const EdgeInsets.all(12),
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.gutter,
              border: Border(
                bottom: BorderSide(color: AppColors.panelEdge),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title.toUpperCase(),
                  style: AppTheme.ui(
                    size: 11,
                    weight: FontWeight.w600,
                    color: AppColors.muted,
                  ).copyWith(letterSpacing: 0.8),
                ),
                const Spacer(),
                ?trailing,
              ],
            ),
          ),
          Expanded(
            child: Padding(padding: padding, child: child),
          ),
        ],
      ),
    );
  }
}
