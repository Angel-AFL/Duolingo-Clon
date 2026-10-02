import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../widgets/skeleton.dart';

/// Placeholder del calendario de racha mientras carga.
class StreakSkeleton extends StatelessWidget {
  const StreakSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: <Widget>[
        const SkeletonBox(width: 220, height: 32),
        const SizedBox(height: AppSpacing.s24),
        const SkeletonBox(width: 160, height: 56),
        const SizedBox(height: AppSpacing.s24),
        const SkeletonBox(height: 88),
        const SizedBox(height: AppSpacing.s24),
        const SkeletonBox(height: 260),
      ],
    );
  }
}
