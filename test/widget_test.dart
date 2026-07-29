import 'package:flutter_test/flutter_test.dart';
import 'package:looplens/data/examples.dart';
import 'package:looplens/models/execution_step.dart';
import 'package:looplens/state/player_controller.dart';

void main() {
  test('C++ for-loop walks init → check → body → i++ until fail', () {
    final ex = cppForLoop;
    expect(ex.limit, 3);
    expect(ex.steps.first.phase, StepPhase.init);
    expect(ex.steps.first.i, 0);

    final checks = ex.steps.where((s) => s.phase == StepPhase.condition);
    expect(checks.last.conditionPass, isFalse);
    expect(ex.steps.last.phase, StepPhase.done);
    expect(ex.steps.last.output, ['0', '1', '2']);
  });

  test('Python example ends with same printed squares', () {
    expect(pythonForLoop.steps.last.output, ['0', '1', '2']);
  });

  test('player can switch examples', () {
    final player = PlayerController();
    expect(player.example.id, 'cpp-for');
    player.load(pythonForLoop);
    expect(player.example.id, 'python-for');
    expect(player.stepIndex, 0);
    player.dispose();
  });
}
