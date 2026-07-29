enum StepPhase {
  init,
  condition,
  body,
  increment,
  done,
}

/// Which piece of the classic for-header is lit.
enum ForSlot {
  init,
  condition,
  increment,
  body,
  none,
}

class ExecutionStep {
  const ExecutionStep({
    required this.phase,
    required this.slot,
    required this.explanation,
    required this.i,
    this.output = const [],
    this.focusIndex,
    this.conditionText,
    this.conditionPass,
  });

  final StepPhase phase;
  final ForSlot slot;
  final String explanation;

  /// Current value of i. Null before init / after conceptual clear.
  final int? i;
  final List<String> output;

  /// Which square is the "now" square (0, 1, 2…).
  final int? focusIndex;

  /// e.g. "0 < 3" shown during condition checks.
  final String? conditionText;
  final bool? conditionPass;
}

class CodeExample {
  const CodeExample({
    required this.id,
    required this.language,
    required this.title,
    required this.initLabel,
    required this.conditionLabel,
    required this.incrementLabel,
    required this.bodyLabel,
    required this.limit,
    required this.steps,
  });

  final String id;
  final String language;
  final String title;

  /// The three classic for parts, shown as placeholders.
  final String initLabel; // e.g. int i = 0
  final String conditionLabel; // e.g. i < 3
  final String incrementLabel; // e.g. i++
  final String bodyLabel; // e.g. print(i) / cout << i

  /// Exclusive upper bound — squares are 0 .. limit-1
  final int limit;
  final List<ExecutionStep> steps;

  List<int> get squares => List.generate(limit, (n) => n);
}
