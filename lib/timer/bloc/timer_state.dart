// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'timer_bloc.dart';

class TimerState extends Equatable {
  const TimerState({
    this.isRunning = false,
    this.initialValue = 0,
    this.secondsElapsed = 0,
  });

  final bool isRunning;
  final int initialValue;
  final int secondsElapsed;

  @override
  List<Object> get props => [isRunning, initialValue, secondsElapsed];

  TimerState copyWith({
    bool? isRunning,
    int? initialValue,
    int? secondsElapsed,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      initialValue: initialValue ?? this.initialValue,
      secondsElapsed: secondsElapsed ?? this.secondsElapsed,
    );
  }
}
