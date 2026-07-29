import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'panel.dart';

class VariablePanel extends StatelessWidget {
  const VariablePanel({
    super.key,
    required this.variables,
    this.changed,
  });

  final Map<String, Object?> variables;
  final String? changed;

  @override
  Widget build(BuildContext context) {
    final entries = variables.entries.toList();
    return Panel(
      title: 'variables',
      child: entries.isEmpty
          ? Text('—', style: AppTheme.mono(color: AppColors.dim))
          : ListView.separated(
              itemCount: entries.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final e = entries[index];
                final isChanged = e.key == changed;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isChanged ? AppColors.activeSoft : AppColors.gutter,
                    border: Border.all(
                      color:
                          isChanged ? AppColors.active : AppColors.panelEdge,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        e.key,
                        style: AppTheme.mono(
                          size: 14,
                          weight: FontWeight.w600,
                          color: isChanged ? AppColors.active : AppColors.info,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '=',
                          style: AppTheme.mono(size: 14, color: AppColors.dim),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e.value == null ? 'undefined' : '${e.value}',
                          style: AppTheme.mono(
                            size: 14,
                            color: e.value == null
                                ? AppColors.dim
                                : AppColors.text,
                          ),
                        ),
                      ),
                      if (isChanged)
                        Text(
                          'changed',
                          style: AppTheme.ui(
                            size: 10,
                            weight: FontWeight.w600,
                            color: AppColors.active,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
