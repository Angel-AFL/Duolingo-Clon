import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/learning_path_provider.dart';
import 'providers/user_stats_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserStatsProvider>(
          create: (_) => UserStatsProvider(),
        ),
        ChangeNotifierProvider<LearningPathProvider>(
          create: (_) => LearningPathProvider(),
        ),
      ],
      child: const DuolingoApp(),
    ),
  );
}
