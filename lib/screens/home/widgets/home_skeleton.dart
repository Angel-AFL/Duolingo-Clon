import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../widgets/skeleton.dart';

/// Placeholder del camino de aprendizaje mientras carga.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  static const List<double> _offsets = <double>[0, 0.45, 0.12, -0.4, 0.22];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s8,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      children: <Widget>[
        const SkeletonBox(height: 72),
        const SizedBox(height: AppSpacing.s24),
        for (final double offset in _offsets)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
            child: Align(
              alignment: Alignment(offset, 0),
              child: const SkeletonCircle(size: 72),
            ),
          ),
      ],
    );
  }
}
