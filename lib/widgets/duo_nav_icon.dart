import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Iconos del bottom nav dibujados al estilo Duolingo (multicolor).
enum DuoNavIconType { home, challenges, league, profile }

/// Pinta uno de los iconos del bottom nav.
class DuoNavIcon extends StatelessWidget {
  const DuoNavIcon({super.key, required this.type, this.size = 30});

  final DuoNavIconType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DuoNavPainter(
          type: type,
          background: AppColors.darkBackground,
        ),
      ),
    );
  }
}

class _DuoNavPainter extends CustomPainter {
  const _DuoNavPainter({required this.type, required this.background});

  final DuoNavIconType type;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 24, size.height / 24);
    switch (type) {
      case DuoNavIconType.home:
        _paintHome(canvas);
      case DuoNavIconType.challenges:
        _paintQuest(canvas);
      case DuoNavIconType.league:
        _paintTrophy(canvas);
      case DuoNavIconType.profile:
        _paintPerson(canvas);
    }
    canvas.restore();
  }

  Paint _fill(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  Paint _stroke(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.8
    ..strokeCap = StrokeCap.round;

  void _paintHome(Canvas canvas) {
    final Path roof = Path()
      ..moveTo(1.6, 11.8)
      ..lineTo(12, 3.2)
      ..lineTo(22.4, 11.8)
      ..close();
    canvas.drawPath(roof, _fill(AppColors.heartPink));

    final RRect body = RRect.fromRectAndRadius(
      Rect.fromLTRB(4.6, 10.4, 19.4, 21),
      const Radius.circular(2.4),
    );
    canvas.drawRRect(body, _fill(AppColors.podiumGold));
    canvas.drawPath(_heart(12, 15.6, 3.1), _fill(background));
  }

  void _paintQuest(Canvas canvas) {
    final RRect body = RRect.fromRectAndRadius(
      Rect.fromLTRB(5, 3, 19, 21),
      const Radius.circular(3),
    );
    canvas.drawRRect(body, _fill(AppColors.podiumGold));

    final RRect inner = RRect.fromRectAndRadius(
      Rect.fromLTRB(7.4, 5.4, 16.6, 18.6),
      const Radius.circular(1.8),
    );
    canvas.drawRRect(inner, _fill(AppColors.streakDeep));

    final Paint gold = _fill(AppColors.podiumGold);
    canvas.drawCircle(const Offset(12, 10.4), 2.1, gold);
    final Path stem = Path()
      ..moveTo(11, 11.6)
      ..lineTo(13, 11.6)
      ..lineTo(12.45, 15.2)
      ..lineTo(11.55, 15.2)
      ..close();
    canvas.drawPath(stem, gold);
  }

  void _paintTrophy(Canvas canvas) {
    final Paint gold = _fill(AppColors.podiumGold);
    final Paint dark = _fill(AppColors.streakDeep);

    canvas.drawArc(
      Rect.fromLTRB(4.4, 5.4, 9.6, 10.6),
      1.35,
      2.1,
      false,
      _stroke(AppColors.podiumGold),
    );
    canvas.drawArc(
      Rect.fromLTRB(14.4, 5.4, 19.6, 10.6),
      -0.35,
      2.1,
      false,
      _stroke(AppColors.podiumGold),
    );

    final Path cup = Path()
      ..moveTo(7.4, 3.6)
      ..lineTo(16.6, 3.6)
      ..lineTo(16.6, 9)
      ..cubicTo(16.6, 13, 14.6, 14.6, 12, 14.6)
      ..cubicTo(9.4, 14.6, 7.4, 13, 7.4, 9)
      ..close();
    canvas.drawPath(cup, gold);
    canvas.drawRect(Rect.fromLTRB(11, 14.6, 13, 17.6), dark);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(8.2, 17.6, 15.8, 20.6),
        const Radius.circular(1.4),
      ),
      dark,
    );
  }

  void _paintPerson(Canvas canvas) {
    final Path body = Path()
      ..moveTo(4.2, 21)
      ..lineTo(4.2, 17.8)
      ..cubicTo(4.2, 14.4, 7.6, 12.9, 12, 12.9)
      ..cubicTo(16.4, 12.9, 19.8, 14.4, 19.8, 17.8)
      ..lineTo(19.8, 21)
      ..close();
    canvas.drawPath(body, _fill(AppColors.navProfileBody));

    canvas.drawCircle(
      const Offset(12, 8.4),
      4.7,
      _fill(AppColors.navProfileHead),
    );
  }

  Path _heart(double cx, double cy, double s) {
    return Path()
      ..moveTo(cx, cy + s * 0.85)
      ..cubicTo(
        cx - s * 1.5,
        cy - s * 0.1,
        cx - s * 0.8,
        cy - s * 1.15,
        cx,
        cy - s * 0.3,
      )
      ..cubicTo(
        cx + s * 0.8,
        cy - s * 1.15,
        cx + s * 1.5,
        cy - s * 0.1,
        cx,
        cy + s * 0.85,
      )
      ..close();
  }

  @override
  bool shouldRepaint(covariant _DuoNavPainter oldDelegate) {
    return oldDelegate.type != type || oldDelegate.background != background;
  }
}

/// Estrella de 5 puntas (utilidad compartida por iconos y medallas).
Path starPath(double cx, double cy, double outer, double inner) {
  final Path path = Path();
  const int points = 5;
  for (int i = 0; i < points * 2; i++) {
    final double radius = i.isEven ? outer : inner;
    final double angle = -math.pi / 2 + i * math.pi / points;
    final double x = cx + radius * math.cos(angle);
    final double y = cy + radius * math.sin(angle);
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
  }
  return path..close();
}
