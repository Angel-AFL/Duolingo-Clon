import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/lesson_node.dart';

/// Nodo circular del camino de aprendizaje con relieve 3D.
///
/// El nodo activo late (1.0 -> 1.05 cada 1.6s) y muestra la burbuja EMPEZAR,
/// como en el Duolingo original.
class LessonNodeTile extends StatefulWidget {
  const LessonNodeTile({super.key, required this.node, this.onTap});

  final LessonNode node;
  final VoidCallback? onTap;

  /// Diametro de la cara del nodo.
  static const double size = 72;

  /// Altura del lip solido bajo la cara.
  static const double lip = 5;

  @override
  State<LessonNodeTile> createState() => _LessonNodeTileState();
}

class _LessonNodeTileState extends State<LessonNodeTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  late final Animation<double> _scale = Tween<double>(
    begin: 1,
    end: 1.05,
  ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));

  bool get _isActive => widget.node.status == LessonNodeStatus.active;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncPulse();
  }

  @override
  void didUpdateWidget(covariant LessonNodeTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncPulse();
  }

  /// Late solo si el nodo esta activo y el usuario no pidio reducir movimiento.
  void _syncPulse() {
    final bool reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (_isActive && !reduceMotion) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
    } else if (_pulse.isAnimating) {
      _pulse.stop();
      _pulse.value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LessonNode node = widget.node;
    final bool isCompleted = node.status == LessonNodeStatus.completed;
    final bool isLocked = node.status == LessonNodeStatus.locked;

    final Color face = _isActive
        ? AppColors.sparkBlue
        : isCompleted
        ? AppColors.eagerGreen
        : AppColors.lockedNode;
    final Color lip = _isActive
        ? AppColors.sparkBlueLip
        : isCompleted
        ? AppColors.eagerGreenLip
        : AppColors.lockedNodeLip;
    final Color iconColor = isLocked
        ? AppColors.pathLockedText
        : AppColors.paperWhite;

    return Align(
      alignment: Alignment(node.horizontalOffset, 0),
      child: Semantics(
        label: AppLocalizations.of(context).a11yLessonNode(node.position + 1),
        button: true,
        enabled: !isLocked,
        child: GestureDetector(
          onTap: widget.onTap,
          child: SizedBox(
            width: LessonNodeTile.size,
            height: LessonNodeTile.size,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (_isActive)
                  const Positioned(top: -36, child: _StartBubble()),
                AnimatedBuilder(
                  animation: _scale,
                  builder: (BuildContext context, Widget? child) =>
                      Transform.scale(
                        scale: _isActive ? _scale.value : 1,
                        child: child,
                      ),
                  child: _NodeBody(
                    face: face,
                    lip: lip,
                    icon: node.icon,
                    iconColor: iconColor,
                    glow: _isActive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Cara + lip del nodo.
class _NodeBody extends StatelessWidget {
  const _NodeBody({
    required this.face,
    required this.lip,
    required this.icon,
    required this.iconColor,
    required this.glow,
  });

  final Color face;
  final Color lip;
  final IconData icon;
  final Color iconColor;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    const double size = LessonNodeTile.size;
    const double lipHeight = LessonNodeTile.lip;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: lipHeight,
            height: size - lipHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, color: lip),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: size - lipHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: face,
                boxShadow: glow
                    ? <BoxShadow>[
                        BoxShadow(
                          color: AppColors.sparkBlue.withValues(alpha: 0.45),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Icon(icon, color: iconColor, size: 34),
            ),
          ),
        ],
      ),
    );
  }
}

/// Burbuja blanca "EMPEZAR" que flota sobre el nodo activo.
class _StartBubble extends StatelessWidget {
  const _StartBubble();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s12,
            vertical: AppSpacing.s8,
          ),
          decoration: BoxDecoration(
            color: AppColors.paperWhite,
            borderRadius: BorderRadius.circular(AppRadius.standard),
            border: Border.all(color: AppColors.darkBorder, width: 2),
          ),
          child: Text(
            AppLocalizations.of(context).start.toUpperCase(),
            style: AppTypography.navLabel(
              color: AppColors.eagerGreenLip,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        CustomPaint(size: const Size(16, 9), painter: _BubblePointer()),
      ],
    );
  }
}

class _BubblePointer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.paperWhite);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
