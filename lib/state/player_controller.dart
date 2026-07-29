import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/python_for_loop.dart';
import '../models/execution_step.dart';

class PlayerController extends ChangeNotifier {
  PlayerController({CodeExample? example})
      : _example = example ?? pythonForRange;

  CodeExample _example;
  int _stepIndex = 0;
  bool _playing = false;
  int _speedIndex = 1;
  Timer? _timer;

  static const List<Duration> speeds = [
    Duration(milliseconds: 1600),
    Duration(milliseconds: 900),
    Duration(milliseconds: 450),
  ];

  static const List<String> speedLabels = ['Slow', 'Normal', 'Fast'];

  CodeExample get example => _example;
  int get stepIndex => _stepIndex;
  bool get playing => _playing;
  int get speedIndex => _speedIndex;
  int get stepCount => _example.steps.length;
  ExecutionStep get step => _example.steps[_stepIndex];
  bool get atStart => _stepIndex == 0;
  bool get atEnd => _stepIndex >= stepCount - 1;
  String get speedLabel => speedLabels[_speedIndex];

  void load(CodeExample example) {
    pause();
    _example = example;
    _stepIndex = 0;
    notifyListeners();
  }

  void reset() {
    pause();
    _stepIndex = 0;
    notifyListeners();
  }

  void stepForward() {
    if (atEnd) {
      pause();
      return;
    }
    _stepIndex++;
    notifyListeners();
    if (atEnd) pause();
  }

  void stepBack() {
    if (atStart) return;
    pause();
    _stepIndex--;
    notifyListeners();
  }

  void goTo(int index) {
    if (index < 0 || index >= stepCount) return;
    pause();
    _stepIndex = index;
    notifyListeners();
  }

  void togglePlay() {
    if (_playing) {
      pause();
    } else {
      play();
    }
  }

  void play() {
    if (atEnd) {
      _stepIndex = 0;
      notifyListeners();
    }
    _playing = true;
    notifyListeners();
    _schedule();
  }

  void pause() {
    _playing = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  void cycleSpeed() {
    _speedIndex = (_speedIndex + 1) % speeds.length;
    notifyListeners();
    if (_playing) _schedule();
  }

  void _schedule() {
    _timer?.cancel();
    if (!_playing) return;
    _timer = Timer(speeds[_speedIndex], () {
      if (!_playing) return;
      if (atEnd) {
        pause();
        return;
      }
      stepForward();
      if (_playing && !atEnd) _schedule();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
