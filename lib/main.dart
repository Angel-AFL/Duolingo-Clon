import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/supabase_config.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/challenges_repository.dart';
import 'data/repositories/friend_streak_repository.dart';
import 'data/repositories/league_repository.dart';
import 'data/repositories/learning_path_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/streak_repository.dart';
import 'data/repositories/user_stats_repository.dart';
import 'providers/auth_provider.dart';
import 'providers/challenges_provider.dart';
import 'providers/league_provider.dart';
import 'providers/learning_path_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/streak_provider.dart';
import 'providers/user_stats_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  SupabaseClient? supabase;
  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.anonKey,
    );
    supabase = Supabase.instance.client;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            repository: supabase == null
                ? null
                : SupabaseAuthRepository(supabase.auth),
          ),
        ),
        ChangeNotifierProvider<UserStatsProvider>(
          create: (_) => UserStatsProvider(
            repository: supabase == null
                ? null
                : SupabaseUserStatsRepository(supabase),
          ),
        ),
        ChangeNotifierProvider<LearningPathProvider>(
          create: (_) => LearningPathProvider(
            repository: supabase == null
                ? null
                : SupabaseLearningPathRepository(supabase),
          ),
        ),
        ChangeNotifierProvider<ChallengesProvider>(
          create: (_) => ChallengesProvider(
            repository: supabase == null
                ? null
                : SupabaseChallengesRepository(supabase),
          ),
        ),
        ChangeNotifierProvider<LeagueProvider>(
          create: (_) => LeagueProvider(
            repository: supabase == null
                ? null
                : SupabaseLeagueRepository(supabase),
          ),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(
            repository: supabase == null
                ? null
                : SupabaseProfileRepository(supabase),
          ),
        ),
        ChangeNotifierProvider<StreakProvider>(
          create: (_) => StreakProvider(
            streakRepository: supabase == null
                ? null
                : SupabaseStreakRepository(supabase),
            friendStreakRepository: supabase == null
                ? null
                : SupabaseFriendStreakRepository(supabase),
          ),
        ),
      ],
      child: const DuolingoApp(),
    ),
  );
}
