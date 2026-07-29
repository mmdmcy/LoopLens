import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../state/player_controller.dart';
import '../theme/app_theme.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key, required this.controller});

  final PlayerController controller;

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.space): controller.togglePlay,
        const SingleActivator(LogicalKeyboardKey.arrowRight):
            controller.stepForward,
        const SingleActivator(LogicalKeyboardKey.arrowLeft):
            controller.stepBack,
        const SingleActivator(LogicalKeyboardKey.keyR): controller.reset,
      },
      child: Focus(
        autofocus: true,
        child: Container(
          height: 52,
          decoration: const BoxDecoration(
            color: AppColors.gutter,
            border: Border(top: BorderSide(color: AppColors.panelEdge)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              _IconBtn(
                tip: 'Reset (R)',
                icon: Icons.replay,
                onTap: controller.reset,
              ),
              _IconBtn(
                tip: 'Step back (←)',
                icon: Icons.skip_previous,
                onTap: controller.atStart ? null : controller.stepBack,
              ),
              _PlayBtn(controller: controller),
              _IconBtn(
                tip: 'Step forward (→)',
                icon: Icons.skip_next,
                onTap: controller.atEnd ? null : controller.stepForward,
              ),
              const SizedBox(width: 12),
              _SpeedBtn(controller: controller),
              const SizedBox(width: 16),
              Expanded(child: _StepScrubber(controller: controller)),
              const SizedBox(width: 12),
              Text(
                '${controller.stepIndex + 1} / ${controller.stepCount}',
                style: AppTheme.mono(size: 12, color: AppColors.muted),
              ),
              const SizedBox(width: 12),
              Text(
                'Space play · ← → step · R reset',
                style: AppTheme.ui(size: 11, color: AppColors.dim),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayBtn extends StatelessWidget {
  const _PlayBtn({required this.controller});

  final PlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: controller.playing ? 'Pause (Space)' : 'Play (Space)',
      child: InkWell(
        onTap: controller.togglePlay,
        child: Container(
          width: 40,
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.active.withValues(alpha: 0.15),
            border: Border.all(color: AppColors.active),
          ),
          child: Icon(
            controller.playing ? Icons.pause : Icons.play_arrow,
            color: AppColors.active,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({
    required this.tip,
    required this.icon,
    required this.onTap,
  });

  final String tip;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Tooltip(
      message: tip,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 32,
          child: Icon(
            icon,
            size: 20,
            color: enabled ? AppColors.text : AppColors.dim,
          ),
        ),
      ),
    );
  }
}

class _SpeedBtn extends StatelessWidget {
  const _SpeedBtn({required this.controller});

  final PlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Cycle playback speed',
      child: InkWell(
        onTap: controller.cycleSpeed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.panelEdge),
          ),
          child: Text(
            controller.speedLabel,
            style: AppTheme.mono(size: 11, color: AppColors.muted),
          ),
        ),
      ),
    );
  }
}

class _StepScrubber extends StatelessWidget {
  const _StepScrubber({required this.controller});

  final PlayerController controller;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 3,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
        activeTrackColor: AppColors.active,
        inactiveTrackColor: AppColors.panelEdge,
        thumbColor: AppColors.active,
        overlayColor: AppColors.activeSoft,
      ),
      child: Slider(
        min: 0,
        max: (controller.stepCount - 1).toDouble(),
        value: controller.stepIndex.toDouble(),
        divisions: controller.stepCount > 1 ? controller.stepCount - 1 : null,
        onChanged: (v) => controller.goTo(v.round()),
      ),
    );
  }
}
