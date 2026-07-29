import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/examples.dart';
import 'models/execution_step.dart';
import 'state/player_controller.dart';
import 'theme/app_theme.dart';
import 'widgets/for_stage.dart';
import 'widgets/player_controls.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LoopLensApp());
}

class LoopLensApp extends StatelessWidget {
  const LoopLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoopLens',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const Workspace(),
    );
  }
}

class Workspace extends StatefulWidget {
  const Workspace({super.key});

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  late final PlayerController _player = PlayerController();
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    _player.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.keyD) {
      _player.stepForward();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.keyA) {
      _player.stepBack();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.space) {
      _player.togglePlay();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.keyR) {
      _player.reset();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _player,
      builder: (context, _) {
        final ex = _player.example;
        final step = _player.step;

        return Focus(
          focusNode: _focus,
          autofocus: true,
          onKeyEvent: _onKey,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _focus.requestFocus(),
            child: Scaffold(
              body: Column(
                children: [
                  _TopBar(
                    example: ex,
                    onSelect: (next) {
                      _player.load(next);
                      _focus.requestFocus();
                    },
                  ),
                  Expanded(child: ForStage(example: ex, step: step)),
                  PlayerControls(
                    controller: _player,
                    onInteract: () => _focus.requestFocus(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.example,
    required this.onSelect,
  });

  final CodeExample example;
  final ValueChanged<CodeExample> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.gutter,
        border: Border(bottom: BorderSide(color: AppColors.panelEdge)),
      ),
      child: Row(
        children: [
          Text(
            'LoopLens',
            style: AppTheme.ui(
              size: 13,
              weight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 20),
          for (final ex in allExamples) ...[
            _LangTab(
              label: ex.language,
              selected: ex.id == example.id,
              onTap: () => onSelect(ex),
            ),
            const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }
}

class _LangTab extends StatelessWidget {
  const _LangTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          label,
          style: AppTheme.ui(
            size: 13,
            weight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? AppColors.text : AppColors.dim,
          ),
        ),
      ),
    );
  }
}
