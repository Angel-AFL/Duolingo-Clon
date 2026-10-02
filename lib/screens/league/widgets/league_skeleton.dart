import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../widgets/skeleton.dart';

/// Placeholder de la tabla de liga mientras carga.
class LeagueSkeleton extends StatelessWidget {
  const LeagueSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      itemCount: 6,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: AppSpacing.s8),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        child: Row(
          children: <Widget>[
            const SkeletonBox(width: 28, height: 20),
            const SizedBox(width: AppSpacing.s12),
            const SkeletonCircle(size: 40),
            const SizedBox(width: AppSpacing.s12),
            const Expanded(child: SkeletonBox(height: 18)),
            const SizedBox(width: AppSpacing.s24),
            const SkeletonBox(width: 40, height: 18),
          ],
        ),
      ),
    );
  }
}
