import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'panel.dart';

/// The mental model of a Python for-loop as a small state machine.
class LoopMachine extends StatelessWidget {
  const LoopMachine({super.key, required this.focus});

  final String? focus;

  static const _nodes = [
    ('range', 'range()', 'Build values'),
    ('next', 'next?', 'Any left?'),
    ('assign', 'i = …', 'Store value'),
    ('body', 'body', 'Run indented'),
    ('done', 'exit', 'Leave loop'),
  ];

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'loop machine',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 420;
          return wide ? _row() : _wrap();
        },
      ),
    );
  }

  Widget _row() {
    return Row(
      children: [
        for (var i = 0; i < _nodes.length; i++) ...[
          Expanded(child: _node(_nodes[i])),
          if (i < _nodes.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.arrow_forward,
                size: 14,
                color: _arrowColor(i),
              ),
            ),
        ],
      ],
    );
  }

  Widget _wrap() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < _nodes.length; i++) ...[
          _node(_nodes[i]),
          if (i < _nodes.length - 1)
            Icon(Icons.arrow_forward, size: 14, color: _arrowColor(i)),
        ],
      ],
    );
  }

  Color _arrowColor(int fromIndex) {
    final id = _nodes[fromIndex].$1;
    if (focus == id || (fromIndex > 0 && focus == _nodes[fromIndex + 1].$1)) {
      return AppColors.active;
    }
    return AppColors.dim;
  }

  Widget _node((String, String, String) node) {
    final (id, title, subtitle) = node;
    final on = focus == id;
    final color = id == 'done'
        ? (on ? AppColors.danger : AppColors.dim)
        : (on ? AppColors.active : AppColors.muted);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: on
            ? (id == 'done' ? AppColors.dangerSoft : AppColors.activeSoft)
            : AppColors.gutter,
        border: Border.all(
          color: on
              ? (id == 'done' ? AppColors.danger : AppColors.active)
              : AppColors.panelEdge,
          width: on ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.mono(
              size: 13,
              weight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTheme.ui(size: 11, color: AppColors.dim),
          ),
        ],
      ),
    );
  }
}
