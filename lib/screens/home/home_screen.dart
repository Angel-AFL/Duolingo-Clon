import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../models/lesson_node.dart';
import '../../providers/learning_path_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/error_retry_view.dart';
import 'widgets/home_skeleton.dart';
import 'widgets/lesson_path.dart';
import 'widgets/section_banner.dart';
import 'widgets/top_stats_bar.dart';

/// Pantalla principal: ruta de aprendizaje (tema oscuro, `home.jpeg`).
///
/// Es el cuerpo de la pestana Home dentro de `AppShell`; el bottom nav lo
/// aporta el shell. El banner de seccion queda fijo al hacer scroll.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onNodeTap(BuildContext context, LessonNode node) {
    if (node.status == LessonNodeStatus.locked) return;
    Navigator.of(context).pushNamed(AppRoutes.lesson, arguments: node.position);
  }

  @override
  Widget build(BuildContext context) {
    final LearningPathProvider path = context.watch<LearningPathProvider>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          const TopStatsBar(),
          Expanded(child: _body(context, path)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, LearningPathProvider path) {
    if (!path.hasLoaded) {
      if (path.hasError) {
        return ErrorRetryView(
          title: AppLocalizations.of(context).homeLoadError,
          message: path.error,
          onRetry: path.load,
        );
      }
      if (path.isLoading) return const HomeSkeleton();
    }

    final List<LessonNode> nodes = path.nodes;
    final int completed = nodes
        .where((LessonNode n) => n.status == LessonNodeStatus.completed)
        .length;
    final double progress = nodes.isEmpty ? 0 : completed / nodes.length;

    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: _BannerHeaderDelegate(
            stage: AppConstants.sectionStage,
            title: AppConstants.sectionTitle,
            progress: progress,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s16,
            0,
            AppSpacing.s16,
            AppSpacing.s24,
          ),
          sliver: SliverToBoxAdapter(
            child: LessonPath(
              onNodeTap: (LessonNode node) => _onNodeTap(context, node),
            ),
          ),
        ),
      ],
    );
  }
}

/// Header fijo del banner de seccion.
class _BannerHeaderDelegate extends SliverPersistentHeaderDelegate {
  _BannerHeaderDelegate({
    required this.stage,
    required this.title,
    required this.progress,
  });

  final String stage;
  final String title;
  final double progress;

  static const double _extent = 160;

  @override
  double get minExtent => _extent;

  @override
  double get maxExtent => _extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s8,
          AppSpacing.s16,
          AppSpacing.s8,
        ),
        child: SectionBanner(stage: stage, title: title, progress: progress),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _BannerHeaderDelegate oldDelegate) {
    return oldDelegate.stage != stage ||
        oldDelegate.title != title ||
        oldDelegate.progress != progress;
  }
}
