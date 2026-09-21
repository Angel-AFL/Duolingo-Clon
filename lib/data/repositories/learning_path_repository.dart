import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/lesson_node.dart';
import '../mock_data.dart';

/// Acceso al camino de aprendizaje.
abstract interface class LearningPathRepository {
  Future<List<LessonNode>> fetchNodes();

  /// Persiste el estado de los nodos (posicion -> estado).
  Future<void> saveNodes(List<LessonNode> nodes);
}

class SupabaseLearningPathRepository implements LearningPathRepository {
  SupabaseLearningPathRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<LessonNode>> fetchNodes() async {
    final String userId = _client.auth.currentUser!.id;
    final List<Map<String, dynamic>> rows = await _client
        .from('lesson_nodes')
        .select()
        .eq('user_id', userId)
        .order('position');
    return rows.map(LessonNode.fromJson).toList();
  }

  @override
  Future<void> saveNodes(List<LessonNode> nodes) async {
    final String userId = _client.auth.currentUser!.id;
    for (int i = 0; i < nodes.length; i++) {
      await _client
          .from('lesson_nodes')
          .update(<String, dynamic>{'status': nodes[i].status.name})
          .eq('user_id', userId)
          .eq('position', i);
    }
  }
}

class MockLearningPathRepository implements LearningPathRepository {
  List<LessonNode> _nodes = List<LessonNode>.of(MockData.lessonPath);

  @override
  Future<List<LessonNode>> fetchNodes() async => _nodes;

  @override
  Future<void> saveNodes(List<LessonNode> nodes) async => _nodes = nodes;
}
