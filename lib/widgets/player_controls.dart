import 'package:flutter/material.dart';

import '../state/player_controller.dart';
import '../theme/app_theme.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    super.key,
    required this.controller,
    this.onInteract,
  });

  final PlayerController controller;
  final VoidCallback? onInteract;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: AppColors.gutter,
        border: Border(top: BorderSide(color: AppColors.panelEdge)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _Btn(
            icon: Icons.replay,
            tip: 'Reset (R)',
            onTap: () {
              controller.reset();
              onInteract?.call();
            },
          ),
          _Btn(
            icon: Icons.chevron_left,
            tip: 'Back (← / A)',
            onTap: controller.atStart
                ? null
                : () {
                    controller.stepBack();
                    onInteract?.call();
                  },
          ),
          _Play(
            controller: controller,
            onInteract: onInteract,
          ),
          _Btn(
            icon: Icons.chevron_right,
            tip: 'Forward (→ / D)',
            onTap: controller.atEnd
                ? null
                : () {
                    controller.stepForward();
                    onInteract?.call();
                  },
          ),
          const SizedBox(width: 16),
          Text(
            '${controller.stepIndex + 1} / ${controller.stepCount}',
            style: AppTheme.mono(size: 12, color: AppColors.dim),
          ),
          const SizedBox(width: 16),
          Text(
            '← →  or  A D',
            style: AppTheme.ui(size: 11, color: AppColors.dim),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              controller.cycleSpeed();
              onInteract?.call();
            },
            child: Text(
              controller.speedLabel.toLowerCase(),
              style: AppTheme.ui(size: 12, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class _Play extends StatelessWidget {
  const _Play({required this.controller, this.onInteract});

  final PlayerController controller;
  final VoidCallback? onInteract;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: controller.playing ? 'Pause (Space)' : 'Play (Space)',
      child: InkWell(
        onTap: () {
          controller.togglePlay();
          onInteract?.call();
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            controller.playing ? Icons.pause : Icons.play_arrow,
            color: AppColors.active,
            size: 26,
          ),
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  const _Btn({
    required this.icon,
    required this.tip,
    required this.onTap,
  });

  final IconData icon;
  final String tip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tip,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 40,
          child: Icon(
            icon,
            size: 22,
            color: onTap == null ? AppColors.dim : AppColors.muted,
          ),
        ),
      ),
    );
  }
}
