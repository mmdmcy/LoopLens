enum StepPhase {
  setup,
  enter,
  assign,
  check,
  body,
  advance,
  complete,
}

class Comparison {
  const Comparison({
    required this.left,
    required this.operator,
    required this.right,
    required this.result,
  });

  final Object left;
  final String operator;
  final Object right;
  final bool result;
}

class ExecutionStep {
  const ExecutionStep({
    required this.line,
    required this.phase,
    required this.title,
    required this.explanation,
    required this.variables,
    this.output = const [],
    this.focusIndex,
    this.changed,
    this.comparison,
    this.machineFocus,
  });

  /// 1-based source line. Null = no highlight.
  final int? line;
  final StepPhase phase;
  final String title;
  final String explanation;
  final Map<String, Object?> variables;
  final List<String> output;

  /// Active slot in the visualized sequence (range values).
  final int? focusIndex;

  /// Variable that just changed (pulse highlight).
  final String? changed;

  final Comparison? comparison;

  /// Loop machine focus: range | next | assign | body | done
  final String? machineFocus;
}

class CodeExample {
  const CodeExample({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.language,
    required this.code,
    required this.steps,
    required this.sequenceLabel,
    required this.sequence,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String language;
  final List<String> code;
  final List<ExecutionStep> steps;
  final String sequenceLabel;
  final List<Object> sequence;
}
