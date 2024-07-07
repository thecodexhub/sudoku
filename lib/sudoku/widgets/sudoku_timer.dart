import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/timer/timer.dart';
import 'package:sudoku/typography/typography.dart';

class SudokuTimer extends StatelessWidget {
  const SudokuTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final hour = state.secondsElapsed ~/ 3600;
        final minute = (state.secondsElapsed - (hour * 3600)) ~/ 60;
        final seconds = state.secondsElapsed - (hour * 3600) - (minute * 60);

        final hourString = hour.toString().padLeft(2, '0');
        final minuteString = minute.toString().padLeft(2, '0');
        final secondsString = seconds.toString().padLeft(2, '0');

        return ResponsiveLayoutBuilder(
          small: (_, child) => child!,
          medium: (_, child) => child!,
          large: (_, child) => child!,
          child: (layoutSize) {
            final timerTextStyle = switch (layoutSize) {
              ResponsiveLayoutSize.large => SudokuTextStyle.bodyText1,
              _ => SudokuTextStyle.bodyText1,
            };

            return GestureDetector(
              onTap: () => state.isRunning
                  ? context.read<TimerBloc>().add(const TimerStopped())
                  : context.read<TimerBloc>().add(const TimerResumed()),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.dividerColor,
                    width: 1.4,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$hourString:$minuteString:$secondsString',
                        style: timerTextStyle,
                      ),
                      Icon(
                        state.isRunning ? Icons.pause : Icons.play_arrow,
                        size: timerTextStyle.fontSize,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
