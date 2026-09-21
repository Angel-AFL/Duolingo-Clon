import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/daily_challenge.dart';
import '../mock_data.dart';

/// Estado de los desafios del usuario.
class ChallengeSnapshot {
  const ChallengeSnapshot({
    required this.points,
    required this.pointsTarget,
    required this.challenges,
  });

  final int points;
  final int pointsTarget;
  final List<DailyChallenge> challenges;
}

/// Acceso a los desafios del usuario.
abstract interface class ChallengesRepository {
  Future<ChallengeSnapshot> fetchChallenges();

  Future<void> saveChallenges(int points, List<DailyChallenge> challenges);
}

class SupabaseChallengesRepository implements ChallengesRepository {
  SupabaseChallengesRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<ChallengeSnapshot> fetchChallenges() async {
    final String userId = _client.auth.currentUser!.id;
    final Map<String, dynamic> state = await _client
        .from('challenge_state')
        .select()
        .eq('user_id', userId)
        .single();
    final List<Map<String, dynamic>> rows = await _client
        .from('daily_challenges')
        .select()
        .eq('user_id', userId)
        .order('position');
    return ChallengeSnapshot(
      points: state['points'] as int,
      pointsTarget: state['points_target'] as int,
      challenges: rows.map(DailyChallenge.fromJson).toList(),
    );
  }

  @override
  Future<void> saveChallenges(int points, List<DailyChallenge> challenges) async {
    final String userId = _client.auth.currentUser!.id;
    await _client
        .from('challenge_state')
        .update(<String, dynamic>{'points': points})
        .eq('user_id', userId);
    for (int i = 0; i < challenges.length; i++) {
      await _client
          .from('daily_challenges')
          .update(<String, dynamic>{'progress': challenges[i].progress})
          .eq('user_id', userId)
          .eq('position', i);
    }
  }
}

class MockChallengesRepository implements ChallengesRepository {
  int _points = MockData.challengePoints;
  List<DailyChallenge> _challenges = List<DailyChallenge>.of(
    MockData.dailyChallenges,
  );

  @override
  Future<ChallengeSnapshot> fetchChallenges() async => ChallengeSnapshot(
    points: _points,
    pointsTarget: MockData.challengePointsTarget,
    challenges: _challenges,
  );

  @override
  Future<void> saveChallenges(int points, List<DailyChallenge> challenges) async {
    _points = points;
    _challenges = challenges;
  }
}
