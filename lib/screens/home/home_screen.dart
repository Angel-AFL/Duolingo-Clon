import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';
import '../../models/lesson_node.dart';
import '../../models/nav_item.dart';
import '../../providers/learning_path_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import 'widgets/lesson_path.dart';
import 'widgets/section_banner.dart';
import 'widgets/top_stats_bar.dart';

/// Pantalla principal: ruta de aprendizaje (tema oscuro, `home.jpeg`).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<NavItem> _navItems = <NavItem>[
    NavItem(icon: Icons.home_rounded, color: AppColors.streakOrange),
    NavItem(icon: Icons.fitness_center_rounded, color: AppColors.streakOrange),
    NavItem(icon: Icons.diamond_rounded, color: AppColors.gemBlue),
    NavItem(icon: Icons.favorite_rounded, color: AppColors.heartPink),
    NavItem(icon: Icons.emoji_events_rounded, color: AppColors.sparkBlue),
    NavItem(icon: Icons.more_horiz_rounded, color: AppColors.leaguePurple),
  ];

  void _onNodeTap(LessonNode node) {
    if (node.status == LessonNodeStatus.active) {
      context.read<LearningPathProvider>().completeCurrent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const TopStatsBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s16,
                  AppSpacing.s8,
                  AppSpacing.s16,
                  AppSpacing.s24,
                ),
                children: <Widget>[
                  const SectionBanner(
                    stage: MockData.sectionStage,
                    title: MockData.sectionTitle,
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  LessonPath(onNodeTap: _onNodeTap),
                ],
              ),
            ),
            AppBottomNav(
              items: _navItems,
              selectedIndex: _selectedIndex,
              onTap: (int index) => setState(() => _selectedIndex = index),
            ),
          ],
        ),
      ),
    );
  }
}
