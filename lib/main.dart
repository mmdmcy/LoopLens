import 'package:flutter/material.dart';

import 'models/execution_step.dart';
import 'state/player_controller.dart';
import 'theme/app_theme.dart';
import 'widgets/code_panel.dart';
import 'widgets/console_panel.dart';
import 'widgets/loop_machine.dart';
import 'widgets/narration_panel.dart';
import 'widgets/player_controls.dart';
import 'widgets/sequence_track.dart';
import 'widgets/variable_panel.dart';

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

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _player,
      builder: (context, _) {
        final ex = _player.example;
        final step = _player.step;
        final exhausted = step.machineFocus == 'done';

        return Scaffold(
          body: Column(
            children: [
              _TitleBar(
                title: ex.title,
                subtitle: ex.subtitle,
                stepLabel: step.phase.label,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final stacked = constraints.maxWidth < 980;
                      if (stacked) {
                        return Column(
                          children: [
                            Expanded(flex: 3, child: _leftColumn(ex, step)),
                            const SizedBox(height: 8),
                            Expanded(flex: 4, child: _rightColumn(ex, step, exhausted)),
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 5, child: _leftColumn(ex, step)),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: _rightColumn(ex, step, exhausted),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              PlayerControls(controller: _player),
            ],
          ),
        );
      },
    );
  }

  Widget _leftColumn(CodeExample ex, ExecutionStep step) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: CodePanel(
            lines: ex.code,
            activeLine: step.line,
            language: ex.language,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 4,
          child: NarrationPanel(step: step),
        ),
      ],
    );
  }

  Widget _rightColumn(CodeExample ex, ExecutionStep step, bool exhausted) {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: LoopMachine(focus: step.machineFocus),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: SequenceTrack(
            label: ex.sequenceLabel,
            values: ex.sequence,
            focusIndex: step.focusIndex,
            exhausted: exhausted,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: VariablePanel(
                  variables: step.variables,
                  changed: step.changed,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ConsolePanel(lines: step.output),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({
    required this.title,
    required this.subtitle,
    required this.stepLabel,
  });

  final String title;
  final String subtitle;
  final String stepLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
              weight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          Container(
            width: 1,
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.panelEdge,
          ),
          Text(title, style: AppTheme.mono(size: 13, color: AppColors.active)),
          const SizedBox(width: 10),
          Text(subtitle, style: AppTheme.ui(size: 12, color: AppColors.dim)),
          const Spacer(),
          Text(
            'phase',
            style: AppTheme.ui(size: 11, color: AppColors.dim),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.panelEdge),
              color: AppColors.panel,
            ),
            child: Text(
              stepLabel,
              style: AppTheme.mono(size: 11, color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}
