import 'package:flutter_test/flutter_test.dart';
import 'package:looplens/data/python_for_loop.dart';
import 'package:looplens/state/player_controller.dart';

void main() {
  test('python for-loop trace has coherent steps', () {
    final ex = pythonForRange;
    expect(ex.code, isNotEmpty);
    expect(ex.steps, isNotEmpty);
    expect(ex.sequence, [0, 1, 2]);

    final assigns = ex.steps.where((s) => s.changed == 'i').toList();
    expect(assigns.map((s) => s.variables['i']), [0, 1, 2]);

    expect(ex.steps.last.phase.name, 'complete');
    expect(ex.steps.last.output, ['0', '1', '2']);
  });

  test('player steps forward and back', () {
    final player = PlayerController();
    expect(player.stepIndex, 0);
    player.stepForward();
    expect(player.stepIndex, 1);
    player.stepBack();
    expect(player.stepIndex, 0);
    player.goTo(player.stepCount - 1);
    expect(player.atEnd, isTrue);
    player.dispose();
  });
}
