import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/friend_streak_repository.dart';
import '../data/repositories/streak_repository.dart';
import '../models/friend_streak.dart';
import '../models/streak_calendar.dart';

/// Estado de la racha: calendario y rachas con amigos.
class StreakProvider extends ChangeNotifier {
  StreakProvider({
    StreakRepository? streakRepository,
    FriendStreakRepository? friendStreakRepository,
  }) : _streakRepository = streakRepository ?? MockStreakRepository(),
       _friendStreakRepository =
           friendStreakRepository ?? MockFriendStreakRepository();

  final StreakRepository _streakRepository;
  final FriendStreakRepository _friendStreakRepository;

  StreakCalendar _calendar = MockData.streakCalendar;
  List<FriendStreak> _friendStreaks = List<FriendStreak>.of(
    MockData.friendStreaks,
  );
  bool _isLoading = false;

  StreakCalendar get calendar => _calendar;
  List<FriendStreak> get friendStreaks =>
      List<FriendStreak>.unmodifiable(_friendStreaks);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _calendar = await _streakRepository.fetchCalendar();
      final List<FriendStreak> friends =
          await _friendStreakRepository.fetchFriendStreaks();
      if (friends.isNotEmpty) _friendStreaks = friends;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
