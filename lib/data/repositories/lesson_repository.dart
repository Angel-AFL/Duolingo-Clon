import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/lesson_exercise.dart';
import '../mock_data.dart';

/// Acceso a los ejercicios de una leccion del camino.
abstract interface class LessonRepository {
  Future<List<LessonExercise>> fetchExercises(int lessonPosition);
}

class SupabaseLessonRepository implements LessonRepository {
  SupabaseLessonRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<LessonExercise>> fetchExercises(int lessonPosition) async {
    final List<Map<String, dynamic>> rows = await _client
        .from('lesson_exercises')
        .select()
        .eq('lesson_position', lessonPosition)
        .order('position');
    return rows.map(LessonExercise.fromJson).toList();
  }
}

class MockLessonRepository implements LessonRepository {
  /// Cantidad de ejercicios por leccion en `MockData.lessonExercises`.
  static const int _exercisesPerLesson = 4;

  @override
  Future<List<LessonExercise>> fetchExercises(int lessonPosition) async {
    final int start = lessonPosition * _exercisesPerLesson;
    if (start < 0 || start >= MockData.lessonExercises.length) {
      return const <LessonExercise>[];
    }
    final int end = (start + _exercisesPerLesson).clamp(
      0,
      MockData.lessonExercises.length,
    );
    return List<LessonExercise>.of(
      MockData.lessonExercises.sublist(start, end),
    );
  }
}
