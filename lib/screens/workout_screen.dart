import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../models/workout_data.dart';
import '../providers/timer_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

/// Clean Workout Timer Screen - Minimal, functional design
class WorkoutScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutScreen({super.key, required this.workout});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimerProvider>().startWorkout(widget.workout);
    });
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  // FIXED: Exit function that properly works
  void _exitWorkout() {
    context.read<TimerProvider>().reset();
    Navigator.of(context).pop();
  }

  Future<bool> _showExitDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.bgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        title: Text(
          'Exit Workout?',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: Text(
          'Your progress will be lost.',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Exit',
              style: TextStyle(color: AppTheme.stateWork),
            ),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _showExitDialog();
        if (shouldPop && context.mounted) {
          _exitWorkout();
        }
      },
      child: Scaffold(
        body: PremiumBackground(
          child: SafeArea(
            child: Consumer<TimerProvider>(
              builder: (context, timer, child) {
                if (timer.timerState == TimerState.completed) {
                  return _buildCompletedScreen();
                }
                return _buildWorkoutUI(timer);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutUI(TimerProvider timer) {
    return Column(
      children: [
        _buildTopBar(timer),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildStateLabel(timer),
                const SizedBox(height: 32),
                _buildTimer(timer),
                const SizedBox(height: 32),
                _buildExerciseInfo(timer),
                const SizedBox(height: 24),
                _buildProgress(timer),
                const SizedBox(height: 32),
                _buildControls(timer),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // FIXED: X button now works properly
  Widget _buildTopBar(TimerProvider timer) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          // Close button - FIXED
          GestureDetector(
            onTap: () async {
              final shouldPop = await _showExitDialog();
              if (shouldPop && mounted) {
                _exitWorkout();
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.bgSecondary,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                border: Border.all(color: AppTheme.border),
              ),
              child: Icon(
                Icons.close,
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.workout.day.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accent,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  widget.workout.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 40), // Balance
        ],
      ),
    );
  }

  Widget _buildStateLabel(TimerProvider timer) {
    String label;
    Color color;

    switch (timer.timerState) {
      case TimerState.working:
        label = 'WORK';
        color = AppTheme.stateWork;
        break;
      case TimerState.resting:
        label = 'REST';
        color = AppTheme.stateRest;
        break;
      case TimerState.roundRest:
        label = 'ROUND BREAK';
        color = AppTheme.stateBreak;
        break;
      default:
        label = '';
        color = AppTheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTimer(TimerProvider timer) {
    Color color;
    switch (timer.timerState) {
      case TimerState.working:
        color = AppTheme.stateWork;
        break;
      case TimerState.resting:
        color = AppTheme.stateRest;
        break;
      case TimerState.roundRest:
        color = AppTheme.stateBreak;
        break;
      default:
        color = AppTheme.primary;
    }

    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Progress ring - clean, no glow
          SizedBox(
            width: 240,
            height: 240,
            child: CustomPaint(
              painter: CleanTimerPainter(
                progress: timer.progress,
                color: color,
              ),
            ),
          ),
          // Time display
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${timer.secondsRemaining}',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                  color: AppTheme.textPrimary,
                ),
              ),
              if (timer.isPaused)
                Text(
                  'PAUSED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                    letterSpacing: 2,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseInfo(TimerProvider timer) {
    final exercise = timer.currentExercise;
    if (exercise == null) return const SizedBox();

    if (timer.timerState == TimerState.roundRest) {
      return GlassCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Round ${timer.currentRound} Complete',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rest before round ${timer.currentRound + 1}',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      );
    }

    final displayExercise = timer.timerState == TimerState.resting
        ? _getNextExercise(timer) ?? exercise
        : exercise;
    final isNextUp = timer.timerState == TimerState.resting;

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            isNextUp ? 'NEXT UP' : 'NOW',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isNextUp ? AppTheme.stateRest : AppTheme.accent,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            displayExercise.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            displayExercise.instruction,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Exercise? _getNextExercise(TimerProvider timer) {
    final workout = timer.currentWorkout;
    if (workout == null) return null;
    final nextIndex = timer.currentExerciseIndex + 1;
    if (nextIndex < workout.exercises.length) {
      return workout.exercises[nextIndex];
    }
    return workout.exercises[0];
  }

  Widget _buildProgress(TimerProvider timer) {
    return Row(
      children: [
        Expanded(
          child: _buildProgressItem(
            'Round',
            '${timer.currentRound}/${widget.workout.totalRounds}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildProgressItem(
            'Exercise',
            '${timer.currentExerciseIndex + 1}/${widget.workout.exercises.length}',
          ),
        ),
      ],
    );
  }

  Widget _buildProgressItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.bgSecondary,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(TimerProvider timer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Restart
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            timer.restartWorkout();
          },
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.bgSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.border),
            ),
            child: Icon(Icons.replay, color: AppTheme.textSecondary, size: 22),
          ),
        ),
        const SizedBox(width: 24),
        // Play/Pause
        GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            timer.togglePause();
          },
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              timer.isPaused ? Icons.play_arrow : Icons.pause,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Skip
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            timer.skipToNext();
          },
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.bgSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.border),
            ),
            child: Icon(Icons.skip_next, color: AppTheme.textSecondary, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.stateComplete,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Workout Complete',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.workout.name,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: PremiumButton(
                text: 'Done',
                backgroundColor: AppTheme.stateComplete,
                onPressed: _exitWorkout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Clean timer painter - no glows, simple progress arc
class CleanTimerPainter extends CustomPainter {
  final double progress;
  final Color color;

  CleanTimerPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 6.0;

    // Background track
    final bgPaint = Paint()
      ..color = AppTheme.bgTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CleanTimerPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
