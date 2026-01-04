import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/workout_data.dart';

enum TimerState { idle, working, resting, roundRest, completed }

class TimerProvider extends ChangeNotifier {
  Workout? _currentWorkout;
  int _currentRound = 1;
  int _currentExerciseIndex = 0;
  int _secondsRemaining = 0;
  TimerState _timerState = TimerState.idle;
  Timer? _timer;
  bool _isPaused = false;

  // Getters
  Workout? get currentWorkout => _currentWorkout;
  int get currentRound => _currentRound;
  int get currentExerciseIndex => _currentExerciseIndex;
  int get secondsRemaining => _secondsRemaining;
  TimerState get timerState => _timerState;
  bool get isPaused => _isPaused;
  bool get isRunning => _timer != null && _timer!.isActive && !_isPaused;

  Exercise? get currentExercise {
    if (_currentWorkout == null) return null;
    if (_currentExerciseIndex >= _currentWorkout!.exercises.length) return null;
    return _currentWorkout!.exercises[_currentExerciseIndex];
  }

  double get progress {
    if (_currentWorkout == null) return 0;
    int totalSeconds;
    switch (_timerState) {
      case TimerState.working:
        totalSeconds = _currentWorkout!.workSeconds;
        break;
      case TimerState.resting:
        totalSeconds = _currentWorkout!.restSeconds;
        break;
      case TimerState.roundRest:
        totalSeconds = _currentWorkout!.roundRestSeconds;
        break;
      default:
        return 0;
    }
    return 1 - (_secondsRemaining / totalSeconds);
  }

  void startWorkout(Workout workout) {
    _currentWorkout = workout;
    _currentRound = 1;
    _currentExerciseIndex = 0;
    _timerState = TimerState.working;
    _secondsRemaining = workout.workSeconds;
    _isPaused = false;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;
      
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _handleTimerComplete();
      }
    });
  }

  void _handleTimerComplete() {
    if (_currentWorkout == null) return;

    switch (_timerState) {
      case TimerState.working:
        // Move to rest after exercise
        if (_currentExerciseIndex < _currentWorkout!.exercises.length - 1) {
          // Rest between exercises
          _timerState = TimerState.resting;
          _secondsRemaining = _currentWorkout!.restSeconds;
        } else {
          // End of round
          if (_currentRound < _currentWorkout!.totalRounds) {
            // Rest between rounds
            _timerState = TimerState.roundRest;
            _secondsRemaining = _currentWorkout!.roundRestSeconds;
          } else {
            // Workout complete
            _timerState = TimerState.completed;
            _timer?.cancel();
          }
        }
        break;

      case TimerState.resting:
        // Move to next exercise
        _currentExerciseIndex++;
        _timerState = TimerState.working;
        _secondsRemaining = _currentWorkout!.workSeconds;
        break;

      case TimerState.roundRest:
        // Start next round
        _currentRound++;
        _currentExerciseIndex = 0;
        _timerState = TimerState.working;
        _secondsRemaining = _currentWorkout!.workSeconds;
        break;

      default:
        break;
    }
    notifyListeners();
  }

  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  void skipToNext() {
    if (_currentWorkout == null) return;
    _secondsRemaining = 0;
    _handleTimerComplete();
  }

  void reset() {
    _timer?.cancel();
    _currentWorkout = null;
    _currentRound = 1;
    _currentExerciseIndex = 0;
    _secondsRemaining = 0;
    _timerState = TimerState.idle;
    _isPaused = false;
    notifyListeners();
  }

  void restartWorkout() {
    if (_currentWorkout == null) return;
    final workout = _currentWorkout!;
    reset();
    startWorkout(workout);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
