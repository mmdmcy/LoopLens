import 'package:flutter/material.dart';

import '../models/execution_step.dart';
import '../theme/app_theme.dart';
import 'code_panel.dart';
import 'panel.dart';

class NarrationPanel extends StatelessWidget {
  const NarrationPanel({super.key, required this.step});

  final ExecutionStep step;

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'what just happened',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.gutter,
          border: Border.all(color: AppColors.panelEdge),
        ),
        child: Text(
          step.phase.label,
          style: AppTheme.mono(size: 10, color: AppColors.active),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.title,
            style: AppTheme.ui(
              size: 16,
              weight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                step.explanation,
                style: AppTheme.ui(
                  size: 13,
                  color: AppColors.muted,
                  height: 1.45,
                ),
              ),
            ),
          ),
          if (step.comparison != null) ...[
            const SizedBox(height: 8),
            _ComparisonChip(comparison: step.comparison!),
          ],
        ],
      ),
    );
  }
}

class _ComparisonChip extends StatelessWidget {
  const _ComparisonChip({required this.comparison});

  final Comparison comparison;

  @override
  Widget build(BuildContext context) {
    final ok = comparison.result;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ok ? AppColors.accentSoft : AppColors.dangerSoft,
        border: Border.all(color: ok ? AppColors.accent : AppColors.danger),
      ),
      child: Text(
        '${comparison.left} ${comparison.operator} ${comparison.right}  →  ${ok ? 'true' : 'false'}',
        style: AppTheme.mono(
          size: 13,
          color: ok ? AppColors.accent : AppColors.danger,
        ),
      ),
    );
  }
}
