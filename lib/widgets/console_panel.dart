import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'panel.dart';

class ConsolePanel extends StatelessWidget {
  const ConsolePanel({super.key, required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'console',
      padding: const EdgeInsets.all(10),
      child: lines.isEmpty
          ? Text(
              'No output yet.',
              style: AppTheme.mono(size: 12, color: AppColors.dim),
            )
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                final latest = index == lines.length - 1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '› ',
                        style: AppTheme.mono(
                          size: 13,
                          color: latest ? AppColors.accent : AppColors.dim,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          lines[index],
                          style: AppTheme.mono(
                            size: 13,
                            color: latest ? AppColors.accent : AppColors.text,
                          ),
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
