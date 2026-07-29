import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'panel.dart';

/// Visual slots for range(3) → [0] [1] [2] with a moving cursor.
class SequenceTrack extends StatelessWidget {
  const SequenceTrack({
    super.key,
    required this.label,
    required this.values,
    required this.focusIndex,
    this.exhausted = false,
  });

  final String label;
  final List<Object> values;
  final int? focusIndex;
  final bool exhausted;

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'sequence',
      trailing: Text(
        label,
        style: AppTheme.mono(size: 11, color: AppColors.dim),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exhausted
                ? 'No values left — loop stops.'
                : focusIndex == null
                    ? 'Waiting to pick the next value…'
                    : 'Current value is at index $focusIndex.',
            style: AppTheme.ui(size: 12, color: AppColors.muted),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (var i = 0; i < values.length; i++)
                    _Slot(
                      index: i,
                      value: values[i],
                      active: focusIndex == i,
                      visited: focusIndex != null && i < focusIndex!,
                    ),
                  _EndMarker(active: exhausted),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.index,
    required this.value,
    required this.active,
    required this.visited,
  });

  final int index;
  final Object value;
  final bool active;
  final bool visited;

  @override
  Widget build(BuildContext context) {
    final border = active
        ? AppColors.active
        : visited
            ? AppColors.accent.withValues(alpha: 0.55)
            : AppColors.panelEdge;
    final fill = active
        ? AppColors.activeSoft
        : visited
            ? AppColors.accentSoft
            : AppColors.gutter;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 64,
      height: 72,
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(color: border, width: active ? 2 : 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '[$index]',
            style: AppTheme.mono(
              size: 10,
              color: active ? AppColors.active : AppColors.dim,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$value',
            style: AppTheme.mono(
              size: 22,
              weight: FontWeight.w600,
              color: active ? AppColors.active : AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _EndMarker extends StatelessWidget {
  const _EndMarker({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.dangerSoft : AppColors.gutter,
        border: Border.all(
          color: active ? AppColors.danger : AppColors.panelEdge,
        ),
      ),
      child: Text(
        'END',
        style: AppTheme.mono(
          size: 12,
          weight: FontWeight.w600,
          color: active ? AppColors.danger : AppColors.dim,
        ),
      ),
    );
  }
}
