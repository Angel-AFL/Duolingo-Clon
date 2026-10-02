import 'package:flutter/material.dart';

import '../../../widgets/duo_choice_tile.dart';

/// Estado visual de una opcion de ejercicio.
enum ExerciseOptionState { idle, selected, correct, wrong }

/// Opcion seleccionable reutilizada por los ejercicios de opcion multiple
/// y de completar la oracion.
///
/// Delega el relieve 3D en [DuoChoiceTile].
class ExerciseOptionTile extends StatelessWidget {
  const ExerciseOptionTile({
    super.key,
    required this.label,
    required this.state,
    this.onTap,
  });

  final String label;
  final ExerciseOptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuoChoiceTile(label: label, state: _map(state), onTap: onTap);
  }

  DuoChoiceState _map(ExerciseOptionState state) {
    switch (state) {
      case ExerciseOptionState.idle:
        return DuoChoiceState.idle;
      case ExerciseOptionState.selected:
        return DuoChoiceState.selected;
      case ExerciseOptionState.correct:
        return DuoChoiceState.correct;
      case ExerciseOptionState.wrong:
        return DuoChoiceState.wrong;
    }
  }
}
