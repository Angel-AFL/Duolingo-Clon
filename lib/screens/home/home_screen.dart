import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';
import '../../models/lesson_node.dart';
import '../../providers/learning_path_provider.dart';
import 'widgets/lesson_path.dart';
import 'widgets/section_banner.dart';
import 'widgets/top_stats_bar.dart';

/// Pantalla principal: ruta de aprendizaje (tema oscuro, `home.jpeg`).
///
/// Es el cuerpo de la pestana Home dentro de `AppShell`; el bottom nav lo
/// aporta el shell.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onNodeTap(BuildContext context, LessonNode node) {
    if (node.status == LessonNodeStatus.active) {
      context.read<LearningPathProvider>().completeCurrent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                LessonPath(
                  onNodeTap: (LessonNode node) => _onNodeTap(context, node),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
