import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/widgets/widgets.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleBloc>(
          create: (context) => PuzzleBloc(
            puzzleRepository: context.read<PuzzleRepository>(),
          )..add(const PuzzleInitialized()),
        ),
        BlocProvider<TimerBloc>(
          create: (context) => TimerBloc(
            ticker: const Ticker(),
          )..add(const TimerStarted()),
        ),
      ],
      child: const PuzzleView(),
    );
  }
}

@visibleForTesting
class PuzzleView extends StatelessWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: theme.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
      ),
      body: const SudokuBackground(
        child: PuzzleViewLayout(),
      ),
    );
  }
}

@visibleForTesting
class PuzzleViewLayout extends StatelessWidget {
  const PuzzleViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dimension = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzle.sudoku.getDimesion(),
    );

    if (dimension <= 0) {
      return Center(
        child: Text(
          l10n.sudokuLoadingText,
          style: SudokuTextStyle.caption,
        ),
      );
    }

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Align(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            maxWidth: SudokuBreakpoint.large,
          ),
          child: const Align(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PageHeader(),
                  ResponsiveGap(large: 96),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SudokuBoardView(),
                      SizedBox(width: 56),
                      Column(
                        children: [
                          SizedBox(
                            width: SudokuInputSize.large * 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MistakesCountView(),
                                SudokuTimer(),
                              ],
                            ),
                          ),
                          ResponsiveGap(large: 32),
                          SudokuInputView(),
                          SizedBox(height: 32),
                          InputEraseViewForLargeLayout(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      child: (layoutSize) {
        final maxWidth = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuBoardSize.small,
          ResponsiveLayoutSize.medium => SudokuBoardSize.medium,
          ResponsiveLayoutSize.large => SudokuInputSize.large * dimension,
        };

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ResponsiveGap(
                  small: 72,
                  medium: 24,
                  large: 32,
                ),
                const PageHeader(),
                const ResponsiveGap(
                  small: 24,
                  medium: 32,
                  large: 48,
                ),
                SizedBox(
                  width: maxWidth,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MistakesCountView(),
                      SudokuTimer(),
                    ],
                  ),
                ),
                const ResponsiveGap(
                  small: 16,
                  medium: 24,
                  large: 32,
                ),
                const SudokuBoardView(),
                const ResponsiveGap(
                  small: 16,
                  medium: 24,
                  large: 32,
                ),
                const SudokuInputView(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class InputEraseViewForLargeLayout extends StatelessWidget {
  const InputEraseViewForLargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () => context.read<PuzzleBloc>().add(const SudokuInputErased()),
      child: SizedBox(
        width: SudokuInputSize.large * 3,
        height: 56,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [
                SudokuColors.darkPurple,
                SudokuColors.darkPink,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Center(
            child: Text(
              l10n.eraseInputButtonText,
              textAlign: TextAlign.center,
              style: SudokuTextStyle.button.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
class SudokuInputView extends StatelessWidget {
  const SudokuInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final sudoku = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzle.sudoku,
    );

    return SudokuInput(
      sudokuDimension: sudoku.getDimesion(),
    );
  }
}

@visibleForTesting
class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    const gradient = LinearGradient(
      colors: [
        SudokuColors.darkPurple,
        SudokuColors.darkPink,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    final difficulty = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzle.difficulty,
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final titleTextStyle = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuTextStyle.headline6,
          ResponsiveLayoutSize.medium => SudokuTextStyle.headline5,
          ResponsiveLayoutSize.large => SudokuTextStyle.headline1,
        };

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                l10n.puzzleAppBarDifficulty(difficulty.name),
                style: titleTextStyle,
              ),
            ),
            Text(
              ' ${l10n.puzzleAppBarSudoku}',
              style: titleTextStyle,
            ),
          ],
        );
      },
    );
  }
}

@visibleForTesting
class SudokuBoardView extends StatelessWidget {
  const SudokuBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzle.sudoku.getDimesion(),
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final blockSize = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuBoardSize.small / dimension,
          ResponsiveLayoutSize.medium => SudokuBoardSize.medium / dimension,
          ResponsiveLayoutSize.large => SudokuBoardSize.large / dimension,
        };

        const key = 'sudoku_board_view';

        return BlocBuilder<PuzzleBloc, PuzzleState>(
          buildWhen: (p, c) => p.puzzle.sudoku != c.puzzle.sudoku,
          builder: (context, state) {
            return SudokuBoard(
              blocks: [
                for (final block in state.puzzle.sudoku.blocks)
                  Positioned(
                    key: Key('${key}_${block.position.x}_${block.position.y}'),
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
      },
    );
  }
}