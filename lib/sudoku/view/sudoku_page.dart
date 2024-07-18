import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_page}
/// The root page of the Sudoku UI.
/// {@endtemplate}
class SudokuPage extends StatelessWidget {
  /// {@macro sudoku_page}
  const SudokuPage({required this.sudoku, super.key});
  final Sudoku sudoku;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SudokuBloc>(
          create: (context) => SudokuBloc(
            sudoku: sudoku,
          ),
        ),
        BlocProvider<TimerBloc>(
          create: (context) => TimerBloc(
            ticker: const Ticker(),
          )..add(const TimerStarted()),
        ),
      ],
      child: const SudokuView(),
    );
  }
}

/// {@template sudoku_view}
/// Displays the content for the [SudokuPage].
/// {@endtemplate}
class SudokuView extends StatelessWidget {
  /// {@macro sudoku_view}
  const SudokuView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sudoku = context.select(
      (SudokuBloc bloc) => bloc.state.sudoku,
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, __) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ResponsiveGap(large: 246),
              const Center(
                child: SudokuTimer(),
              ),
              const ResponsiveGap(large: 96),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      l10n.sudokuAppBarTitle,
                      style: SudokuTextStyle.headline1.copyWith(
                        fontWeight: SudokuFontWeight.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 60),
                  const SudokuBoardView(
                    layoutSize: ResponsiveLayoutSize.large,
                  ),
                  const SizedBox(width: 96),
                  SudokuInput(
                    sudokuDimension: sudoku.getDimesion(),
                  ),
                ],
              ),
              const ResponsiveGap(large: 246),
            ],
          ),
        ),
      ),
      child: (layoutSize) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.sudokuAppBarTitle),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  const ResponsiveGap(small: 16, medium: 24),
                  const SudokuTimer(),
                  const ResponsiveGap(small: 16, medium: 24),
                  SudokuBoardView(layoutSize: layoutSize),
                  const ResponsiveGap(small: 32, medium: 56),
                  SudokuInput(
                    sudokuDimension: sudoku.getDimesion(),
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

@visibleForTesting
class SudokuBoardView extends StatelessWidget {
  const SudokuBoardView({
    required this.layoutSize,
    super.key,
  });
  final ResponsiveLayoutSize layoutSize;

  @override
  Widget build(BuildContext context) {
    final dimension = context.select(
      (SudokuBloc bloc) => bloc.state.sudoku.getDimesion(),
    );

    final blockSize = switch (layoutSize) {
      ResponsiveLayoutSize.small => SudokuBoardSize.small / dimension,
      ResponsiveLayoutSize.medium => SudokuBoardSize.medium / dimension,
      ResponsiveLayoutSize.large => SudokuBoardSize.large / dimension,
    };

    return BlocBuilder<SudokuBloc, SudokuState>(
      buildWhen: (previous, current) => previous.sudoku != current.sudoku,
      builder: (context, state) {
        return SudokuBoard(
          blocks: [
            for (final block in state.sudoku.blocks)
              Positioned(
                key: Key(
                  'sudoku_board_view_${block.position.x}_${block.position.y}',
                ),
                top: block.position.x * blockSize,
                left: block.position.y * blockSize,
                child: SudokuBlock(
                  block: block,
                  state: state,
                ),
              ),
          ],
        );
      },
    );
  }
}
