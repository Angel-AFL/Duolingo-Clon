import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/lesson_exercise.dart';
import '../../models/lesson_outcome.dart';
import '../../providers/challenges_provider.dart';
import '../../providers/league_provider.dart';
import '../../providers/learning_path_provider.dart';
import '../../providers/lesson_provider.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/primary_button.dart';
import 'widgets/fill_blank_exercise.dart';
import 'widgets/lesson_feedback_bar.dart';
import 'widgets/lesson_progress_bar.dart';
import 'widgets/lesson_result_view.dart';
import 'widgets/match_pairs_exercise.dart';
import 'widgets/multiple_choice_exercise.dart';
import 'widgets/word_bank_exercise.dart';

/// Pantalla de una leccion del camino (se abre sin el bottom nav).
///
/// Recibe la posicion de la leccion via `ModalRoute.settings.arguments`.
class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  static const int _lessonExp = 10;

  /// Posicion de la leccion que se esta jugando.
  int _position = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final Object? args = ModalRoute.of(context)?.settings.arguments;
      _position = args is int ? args : 0;
      context.read<LessonProvider>().start(_position);
    });
  }

  /// Suma EXP siempre; avanza el camino solo si se jugo el nodo activo.
  ///
  /// Cerrar la leccion no depende del guardado en el repositorio.
  Future<void> _finish() async {
    final LearningPathProvider path = context.read<LearningPathProvider>();
    final ChallengesProvider challenges = context.read<ChallengesProvider>();
    final ProfileProvider profile = context.read<ProfileProvider>();
    final LeagueProvider league = context.read<LeagueProvider>();
    final LessonProvider lesson = context.read<LessonProvider>();
    final int activeIndex = path.activeIndex;
    final bool wasActive =
        activeIndex >= 0 && path.nodes[activeIndex].position == _position;

    final LessonOutcome outcome = LessonOutcome(
      exp: _lessonExp,
      accuracy: lesson.total == 0 ? 0 : lesson.correctCount / lesson.total,
      bestStreak: lesson.bestStreak,
    );

    // Las escrituras actualizan la UI al instante y capturan sus propios
    // errores (`writeError`), asi que no bloquean el cierre.
    final List<Future<void>> writes = <Future<void>>[
      challenges.recordLesson(outcome),
      profile.addExp(_lessonExp),
      league.addExp(_lessonExp),
    ];
    Navigator.of(context).maybePop();
    await Future.wait(writes);

    if (wasActive) {
      try {
        await path.completeCurrent();
      } catch (_) {
        // El guardado no debe impedir cerrar la leccion.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final LessonProvider provider = context.watch<LessonProvider>();

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            _TopBar(provider: provider),
            Expanded(child: _body(provider)),
            _footer(provider),
          ],
        ),
      ),
    );
  }

  Widget _body(LessonProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.eagerGreen),
      );
    }
    if (provider.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s24),
          child: Text(
            provider.error!,
            textAlign: TextAlign.center,
            style: AppTypography.body(color: AppColors.pencilGray),
          ),
        ),
      );
    }
    if (provider.isFinished) {
      return LessonResultView(
        correctCount: provider.correctCount,
        total: provider.total,
        exp: _lessonExp,
        onContinue: _finish,
      );
    }

    final LessonExercise? exercise = provider.current;
    if (exercise == null) return const SizedBox.shrink();

    switch (exercise.type) {
      case LessonExerciseType.multipleChoice:
        return MultipleChoiceExercise(exercise: exercise);
      case LessonExerciseType.fillBlank:
        return FillBlankExercise(exercise: exercise);
      case LessonExerciseType.wordBank:
        return WordBankExercise(exercise: exercise);
      case LessonExerciseType.matchPairs:
        return MatchPairsExercise(exercise: exercise);
    }
  }

  Widget _footer(LessonProvider provider) {
    if (provider.isLoading ||
        provider.error != null ||
        provider.isFinished ||
        provider.current == null) {
      return const SizedBox.shrink();
    }

    if (provider.isAnswered) {
      return LessonFeedbackBar(
        isCorrect: provider.isCorrect,
        answerText: provider.correctAnswerText,
        onContinue: provider.next,
      );
    }

    if (provider.current!.type == LessonExerciseType.matchPairs) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s8,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      child: SafeArea(
        top: false,
        child: PrimaryButton(
          label: 'Comprobar',
          onPressed: provider.canCheck ? provider.check : null,
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.provider});

  final LessonProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s8,
        AppSpacing.s8,
        AppSpacing.s16,
        AppSpacing.s8,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.close_rounded, color: AppColors.paperWhite),
          ),
          Expanded(child: LessonProgressBar(results: provider.results)),
          const SizedBox(width: AppSpacing.s16),
          const Icon(
            Icons.bolt_rounded,
            color: AppColors.superViolet,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.unit),
          Text(
            '∞',
            style: AppTypography.statValue(color: AppColors.superViolet),
          ),
        ],
      ),
    );
  }
}
