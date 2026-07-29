import '../models/execution_step.dart';

ExecutionStep _s({
  int? line,
  required StepPhase phase,
  required String title,
  required String explanation,
  required Map<String, Object?> variables,
  List<String> output = const [],
  int? focusIndex,
  String? changed,
  Comparison? comparison,
  String? machineFocus,
}) {
  return ExecutionStep(
    line: line,
    phase: phase,
    title: title,
    explanation: explanation,
    variables: variables,
    output: output,
    focusIndex: focusIndex,
    changed: changed,
    comparison: comparison,
    machineFocus: machineFocus,
  );
}

/// Classic Python counted loop — the mental model for `for i in range(n)`.
final CodeExample pythonForRange = CodeExample(
  id: 'python-for-range',
  title: 'for i in range(3)',
  subtitle: 'Python counted loop',
  description:
      'Watch how Python walks range(3). Each turn: take the next number, '
      'put it in i, run the body, then ask for the next number.',
  language: 'Python',
  code: const [
    'for i in range(3):',
    '    print(i)',
  ],
  sequenceLabel: 'range(3)',
  sequence: const [0, 1, 2],
  steps: [
    _s(
      line: 1,
      phase: StepPhase.setup,
      title: 'Build the sequence',
      explanation:
          'range(3) means the numbers 0, 1, 2 — not including 3. '
          'Python builds this sequence before the loop starts walking it.',
      variables: const {'i': null},
      machineFocus: 'range',
    ),
    _s(
      line: 1,
      phase: StepPhase.enter,
      title: 'Start the loop',
      explanation:
          'The for loop is ready. Next it will ask: is there another '
          'number left in range(3)?',
      variables: const {'i': null},
      machineFocus: 'next',
    ),
    _s(
      line: 1,
      phase: StepPhase.assign,
      title: 'i ← 0',
      explanation:
          'Yes — first value is 0. Python stores it in the variable i. '
          'This is the assignment that happens every time the loop starts a turn.',
      variables: const {'i': 0},
      focusIndex: 0,
      changed: 'i',
      machineFocus: 'assign',
    ),
    _s(
      line: 2,
      phase: StepPhase.body,
      title: 'Run the body',
      explanation:
          'Now the indented line runs. print(i) prints the current value of i, '
          'which is 0. The body only runs after i has been set.',
      variables: const {'i': 0},
      output: const ['0'],
      focusIndex: 0,
      machineFocus: 'body',
    ),
    _s(
      line: 1,
      phase: StepPhase.advance,
      title: 'Ask for the next value',
      explanation:
          'Body finished. Control jumps back to the for line and asks range '
          'for the next number.',
      variables: const {'i': 0},
      output: const ['0'],
      focusIndex: 0,
      machineFocus: 'next',
    ),
    _s(
      line: 1,
      phase: StepPhase.assign,
      title: 'i ← 1',
      explanation:
          'Next value is 1. i is overwritten — the old 0 is gone. '
          'i always holds the value for the current turn only.',
      variables: const {'i': 1},
      output: const ['0'],
      focusIndex: 1,
      changed: 'i',
      machineFocus: 'assign',
    ),
    _s(
      line: 2,
      phase: StepPhase.body,
      title: 'Run the body again',
      explanation:
          'Same body line, new value. print(i) now prints 1. '
          'That is why loops feel repetitive: the code is the same; the data changes.',
      variables: const {'i': 1},
      output: const ['0', '1'],
      focusIndex: 1,
      machineFocus: 'body',
    ),
    _s(
      line: 1,
      phase: StepPhase.advance,
      title: 'Ask again',
      explanation: 'Back to the for line. Is there still a number left?',
      variables: const {'i': 1},
      output: const ['0', '1'],
      focusIndex: 1,
      machineFocus: 'next',
    ),
    _s(
      line: 1,
      phase: StepPhase.assign,
      title: 'i ← 2',
      explanation:
          'Last value: 2. i becomes 2. One more body run remains.',
      variables: const {'i': 2},
      output: const ['0', '1'],
      focusIndex: 2,
      changed: 'i',
      machineFocus: 'assign',
    ),
    _s(
      line: 2,
      phase: StepPhase.body,
      title: 'Final body run',
      explanation:
          'print(i) prints 2. Every number in range(3) has now been printed once.',
      variables: const {'i': 2},
      output: const ['0', '1', '2'],
      focusIndex: 2,
      machineFocus: 'body',
    ),
    _s(
      line: 1,
      phase: StepPhase.advance,
      title: 'Ask one more time',
      explanation:
          'Python asks range for another value. range(3) is exhausted — '
          'there is nothing after 2.',
      variables: const {'i': 2},
      output: const ['0', '1', '2'],
      focusIndex: 2,
      machineFocus: 'next',
    ),
    _s(
      line: null,
      phase: StepPhase.complete,
      title: 'Loop exits',
      explanation:
          'No more values → the loop stops. Execution continues after the for block '
          '(there is nothing else here, so the program ends). i still holds 2.',
      variables: const {'i': 2},
      output: const ['0', '1', '2'],
      machineFocus: 'done',
    ),
  ],
);

final List<CodeExample> allExamples = [pythonForRange];
