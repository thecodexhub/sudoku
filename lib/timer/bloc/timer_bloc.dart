import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/models/models.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({Ticker? ticker})
      : _ticker = ticker ?? const Ticker(),
        super(const TimerState()) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerStopped>(_onTimerStopped);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
  }

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(
      state.copyWith(
        initialValue: event.initialValue,
        secondsElapsed: event.initialValue,
        isRunning: true,
      ),
    );
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick().listen(
          (secondsElapsed) => add(
            TimerTicked(state.initialValue + secondsElapsed),
          ),
        );
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(state.copyWith(secondsElapsed: event.secondsElapsed));
  }

  void _onTimerStopped(TimerStopped event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(state.copyWith(isRunning: false));
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    _tickerSubscription?.resume();
    emit(state.copyWith(isRunning: true));
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(state.copyWith(secondsElapsed: 0));
  }
}
