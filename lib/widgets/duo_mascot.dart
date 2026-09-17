import 'package:flutter/material.dart';

import '../core/constants/app_assets.dart';
import '../core/theme/app_colors.dart';

/// Mascota Duo.
///
/// Mientras no haya un asset real (`AppAssets.hasMascotAsset == false`) se
/// dibuja un placeholder plano con los tokens del skill: relleno Eager Green,
/// panza Fresh Leaf, pico naranja y contorno grueso.
class DuoMascot extends StatelessWidget {
  const DuoMascot({super.key, this.size = 120});

  final double size;

  @override
  Widget build(BuildContext context) {
    if (AppAssets.hasMascotAsset) {
      return Image.asset(
        AppAssets.duoMascot,
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _DuoPainter()),
    );
  }
}

class _DuoPainter extends CustomPainter {
  static const Color _outline = Color(0xFF1B3A12);
  static const Color _pupil = Color(0xFF2B2B2B);

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint fill = Paint()..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035
      ..color = _outline;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.13, h * 0.18, w * 0.74, h * 0.78),
      Radius.circular(w * 0.34),
    );
    fill.color = AppColors.eagerGreen;
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    final belly = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.30, h * 0.58, w * 0.40, h * 0.32),
      Radius.circular(w * 0.20),
    );
    fill.color = AppColors.freshLeaf;
    canvas.drawRRect(belly, fill);

    final double eyeRadius = w * 0.135;
    for (final double cx in <double>[w * 0.37, w * 0.63]) {
      final Offset center = Offset(cx, h * 0.44);
      fill.color = Colors.white;
      canvas.drawCircle(center, eyeRadius, fill);
      canvas.drawCircle(center, eyeRadius, stroke);
      fill.color = _pupil;
      final double dx = cx < w / 2 ? w * 0.02 : -w * 0.02;
      canvas.drawCircle(
        Offset(cx + dx, h * 0.45),
        eyeRadius * 0.5,
        fill,
      );
    }

    final beak = Path()
      ..moveTo(w * 0.42, h * 0.60)
      ..lineTo(w * 0.58, h * 0.60)
      ..lineTo(w * 0.50, h * 0.70)
      ..close();
    fill.color = AppColors.streakOrange;
    canvas.drawPath(beak, fill);
    canvas.drawPath(beak, stroke);

    final Paint feet = Paint()..color = AppColors.streakOrange;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.24, h * 0.90, w * 0.20, h * 0.08),
        Radius.circular(w * 0.04),
      ),
      feet,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.56, h * 0.90, w * 0.20, h * 0.08),
        Radius.circular(w * 0.04),
      ),
      feet,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
