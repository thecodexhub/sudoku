part of 'timer_bloc.dart';

sealed class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

final class TimerStarted extends TimerEvent {
  const TimerStarted(this.initialValue);

  final int initialValue;

  @override
  List<Object> get props => [initialValue];
}

final class TimerTicked extends TimerEvent {
  const TimerTicked(this.secondsElapsed);

  final int secondsElapsed;

  @override
  List<Object> get props => [secondsElapsed];
}

final class TimerStopped extends TimerEvent {
  const TimerStopped();
}

final class TimerResumed extends TimerEvent {
  const TimerResumed();
}

final class TimerReset extends TimerEvent {
  const TimerReset();
}
