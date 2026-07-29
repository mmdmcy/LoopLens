import 'package:flutter/material.dart';

import '../models/execution_step.dart';
import '../theme/app_theme.dart';
import 'panel.dart';

class CodePanel extends StatelessWidget {
  const CodePanel({
    super.key,
    required this.lines,
    required this.activeLine,
    required this.language,
  });

  final List<String> lines;
  final int? activeLine;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'source',
      padding: EdgeInsets.zero,
      trailing: Text(
        language,
        style: AppTheme.mono(size: 11, color: AppColors.dim),
      ),
      child: ListView.builder(
        itemCount: lines.length,
        itemBuilder: (context, index) {
          final lineNo = index + 1;
          final active = activeLine == lineNo;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            color: active ? AppColors.activeSoft : Colors.transparent,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 44,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: active ? AppColors.active : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      '$lineNo',
                      style: AppTheme.mono(
                        size: 12,
                        color: active ? AppColors.active : AppColors.dim,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      child: _HighlightedLine(
                        text: lines[index],
                        active: active,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HighlightedLine extends StatelessWidget {
  const _HighlightedLine({required this.text, required this.active});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text(' ', style: AppTheme.mono(size: 15));
    }
    return Text.rich(
      TextSpan(children: _tokenize(text)),
      style: AppTheme.mono(
        size: 15,
        weight: active ? FontWeight.w500 : FontWeight.w400,
      ),
    );
  }

  List<InlineSpan> _tokenize(String source) {
    final spans = <InlineSpan>[];
    final pattern = RegExp(
      r'(\b(?:for|in|print|range|True|False|None|def|return|if|else|while|import|from|as|class|with)\b)'
      r'|(\b\d+\b)'
      r"|('(?:\\.|[^'\\])*')"
      r'|(\w+)'
      r'|(\s+)'
      r'|(.)',
    );

    for (final match in pattern.allMatches(source)) {
      final kw = match.group(1);
      final num = match.group(2);
      final str = match.group(3);
      final word = match.group(4);
      final space = match.group(5);
      final other = match.group(6);

      if (kw != null) {
        spans.add(TextSpan(
          text: kw,
          style: const TextStyle(color: AppColors.codeKw),
        ));
      } else if (num != null) {
        spans.add(TextSpan(
          text: num,
          style: const TextStyle(color: AppColors.codeNum),
        ));
      } else if (str != null) {
        spans.add(TextSpan(
          text: str,
          style: const TextStyle(color: AppColors.codeStr),
        ));
      } else if (word != null) {
        final nextIsParen =
            source.length > match.end && source[match.end] == '(';
        spans.add(TextSpan(
          text: word,
          style: TextStyle(
            color: nextIsParen ? AppColors.codeFn : AppColors.codePlain,
          ),
        ));
      } else if (space != null) {
        spans.add(TextSpan(text: space));
      } else if (other != null) {
        spans.add(TextSpan(
          text: other,
          style: const TextStyle(color: AppColors.muted),
        ));
      }
    }
    return spans;
  }
}

extension StepPhaseLabel on StepPhase {
  String get label {
    switch (this) {
      case StepPhase.setup:
        return 'setup';
      case StepPhase.enter:
        return 'enter';
      case StepPhase.assign:
        return 'assign';
      case StepPhase.check:
        return 'check';
      case StepPhase.body:
        return 'body';
      case StepPhase.advance:
        return 'advance';
      case StepPhase.complete:
        return 'done';
    }
  }
}
