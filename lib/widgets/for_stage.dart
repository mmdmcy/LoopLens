import 'package:flutter/material.dart';

import '../models/execution_step.dart';
import '../theme/app_theme.dart';

class ForStage extends StatelessWidget {
  const ForStage({
    super.key,
    required this.example,
    required this.step,
  });

  final CodeExample example;
  final ExecutionStep step;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CodeBlock(
                  example: example,
                  active: step.slot,
                  conditionPass: step.conditionPass,
                ),
                const SizedBox(height: 32),
                _Squares(
                  values: example.squares,
                  focusIndex: step.focusIndex,
                  failed: step.conditionPass == false,
                ),
                const SizedBox(height: 12),
                Text(
                  'i = ${step.i ?? '?'}',
                  style: AppTheme.mono(
                    size: 18,
                    weight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: Text(
                      step.explanation,
                      key: ValueKey(step.explanation),
                      textAlign: TextAlign.center,
                      style: AppTheme.ui(
                        size: 14,
                        color: AppColors.muted,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  step.output.isEmpty
                      ? 'printed  —'
                      : 'printed  ${step.output.join('   ')}',
                  textAlign: TextAlign.center,
                  style: AppTheme.mono(size: 12, color: AppColors.dim),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({
    required this.example,
    required this.active,
    this.conditionPass,
  });

  final CodeExample example;
  final ForSlot active;
  final bool? conditionPass;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line 1: for ( a ; b ; c )
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  'for (',
                  style: AppTheme.mono(size: 15, color: AppColors.muted),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Seg(
                  code: example.initLabel,
                  caption: 'start',
                  lit: active == ForSlot.init,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18, left: 4, right: 4),
                child: Text(';', style: AppTheme.mono(size: 15, color: AppColors.dim)),
              ),
              Expanded(
                child: _Seg(
                  code: example.conditionLabel,
                  caption: conditionPass == null
                      ? 'check'
                      : (conditionPass! ? 'check · true' : 'check · false'),
                  lit: active == ForSlot.condition,
                  captionColor: conditionPass == null
                      ? null
                      : (conditionPass!
                          ? AppColors.accent
                          : AppColors.danger),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18, left: 4, right: 4),
                child: Text(';', style: AppTheme.mono(size: 15, color: AppColors.dim)),
              ),
              Expanded(
                child: _Seg(
                  code: example.incrementLabel,
                  caption: 'step',
                  lit: active == ForSlot.increment,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18, left: 8),
                child: Text(')', style: AppTheme.mono(size: 15, color: AppColors.muted)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('{', style: AppTheme.mono(size: 15, color: AppColors.dim)),
          const SizedBox(height: 6),
          // Body line
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: active == ForSlot.body
                    ? AppColors.activeSoft
                    : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    width: 2,
                    color: active == ForSlot.body
                        ? AppColors.active
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Text(
                example.bodyLabel,
                style: AppTheme.mono(
                  size: 15,
                  weight: FontWeight.w500,
                  color: active == ForSlot.body
                      ? AppColors.text
                      : AppColors.muted,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text('}', style: AppTheme.mono(size: 15, color: AppColors.dim)),
        ],
      ),
    );
  }
}

class _Seg extends StatelessWidget {
  const _Seg({
    required this.code,
    required this.caption,
    required this.lit,
    this.captionColor,
  });

  final String code;
  final String caption;
  final bool lit;
  final Color? captionColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
      decoration: BoxDecoration(
        color: lit ? AppColors.activeSoft : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: lit ? AppColors.active : AppColors.panelEdge,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            code,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.mono(
              size: 14,
              weight: FontWeight.w500,
              color: lit ? AppColors.text : AppColors.muted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.ui(
              size: 10,
              color: lit
                  ? (captionColor ?? AppColors.active)
                  : (captionColor ?? AppColors.dim),
            ),
          ),
        ],
      ),
    );
  }
}

class _Squares extends StatelessWidget {
  const _Squares({
    required this.values,
    required this.focusIndex,
    required this.failed,
  });

  final List<int> values;
  final int? focusIndex;
  final bool failed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var n = 0; n < values.length; n++) ...[
          if (n > 0) const SizedBox(width: 8),
          _Square(value: values[n], state: _state(n)),
        ],
      ],
    );
  }

  _Sq _state(int n) {
    if (focusIndex == n) return _Sq.now;
    if (failed || (focusIndex != null && n < focusIndex!)) return _Sq.done;
    return _Sq.wait;
  }
}

enum _Sq { wait, now, done }

class _Square extends StatelessWidget {
  const _Square({required this.value, required this.state});

  final int value;
  final _Sq state;

  @override
  Widget build(BuildContext context) {
    final border = switch (state) {
      _Sq.now => AppColors.active,
      _ => AppColors.panelEdge,
    };
    final fill = switch (state) {
      _Sq.now => AppColors.activeSoft,
      _Sq.done => AppColors.gutter,
      _Sq.wait => AppColors.panel,
    };
    final ink = switch (state) {
      _Sq.now => AppColors.active,
      _Sq.done => AppColors.dim,
      _Sq.wait => AppColors.muted,
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(color: border, width: state == _Sq.now ? 2 : 1),
      ),
      child: Text(
        '$value',
        style: AppTheme.mono(size: 20, weight: FontWeight.w600, color: ink),
      ),
    );
  }
}
