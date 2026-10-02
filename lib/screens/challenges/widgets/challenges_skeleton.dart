import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../widgets/skeleton.dart';

/// Placeholder de los desafios del dia mientras cargan.
class ChallengesSkeleton extends StatelessWidget {
  const ChallengesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      children: <Widget>[
        Row(
          children: <Widget>[
            const SkeletonCircle(size: 20),
            const SizedBox(width: AppSpacing.s12),
            const Expanded(child: SkeletonBox(height: 18)),
            const SizedBox(width: AppSpacing.s24),
            const SkeletonBox(width: 48, height: 18),
          ],
        ),
        const SizedBox(height: AppSpacing.s16),
        Row(
          children: <Widget>[
            const Expanded(child: SkeletonBox(height: 52)),
            const SizedBox(width: AppSpacing.s12),
            const Expanded(child: SkeletonBox(height: 52)),
          ],
        ),
        const SizedBox(height: AppSpacing.s24),
        for (int i = 0; i < 3; i++) ...<Widget>[
          const SkeletonBox(height: 76),
          const SizedBox(height: AppSpacing.s16),
        ],
      ],
    );
  }
}
