import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/streak_calendar.dart';
import '../../../widgets/stat_box.dart';

/// Calendario mensual de practica con dias activos resaltados.
class StreakCalendarView extends StatelessWidget {
  const StreakCalendarView({
    super.key,
    required this.calendar,
    required this.streakDays,
  });

  final StreakCalendar calendar;

  /// Valor unico de racha (`user_stats.streak_days`), mostrado como dias de
  /// practica para no depender de la sincronizacion con la BD.
  final int streakDays;

  static const List<String> _weekdays = <String>[
    'D',
    'L',
    'Ma',
    'Mi',
    'J',
    'V',
    'S',
  ];

  static const List<String> _monthNames = <String>[
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre',
  ];

  int get _monthIndex =>
      _monthNames.indexOf(calendar.monthName.toLowerCase()) + 1;

  @override
  Widget build(BuildContext context) {
    final int monthIndex = _monthIndex;
    final DateTime firstDay = DateTime(calendar.year, monthIndex, 1);
    final int daysInMonth = DateTime(calendar.year, monthIndex + 1, 0).day;
    final int leadingBlanks = firstDay.weekday % 7;

    final List<Widget?> cells = <Widget?>[
      for (int i = 0; i < leadingBlanks; i++) null,
      for (int day = 1; day <= daysInMonth; day++)
        _DayCell(
          day: day,
          active: calendar.isActive(day),
          isToday: day == calendar.today,
        ),
    ];
    while (cells.length % 7 != 0) {
      cells.add(null);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${calendar.monthName} de ${calendar.year}',
                style: AppTypography.screenTitle(color: AppColors.paperWhite),
              ),
            ),
            const Icon(Icons.chevron_left_rounded, color: AppColors.pencilGray),
            const SizedBox(width: AppSpacing.s16),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.pencilGray,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s16),
        Row(
          children: <Widget>[
            Expanded(
              child: StatBox(
                icon: Icons.check_circle_rounded,
                iconColor: AppColors.streakOrange,
                value: '$streakDays',
                label: 'días de práctica',
              ),
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: StatBox(
                icon: Icons.shield_rounded,
                iconColor: AppColors.sparkBlue,
                value: '${calendar.freezesUsed}',
                label: 'Protectores usados',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s16),
        Container(
          padding: const EdgeInsets.all(AppSpacing.s12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkBorder),
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  for (final String day in _weekdays)
                    Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: AppTypography.caption(
                          color: AppColors.pencilGray,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.s8),
              for (int row = 0; row < cells.length ~/ 7; row++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.unit,
                  ),
                  child: Row(
                    children: <Widget>[
                      for (int col = 0; col < 7; col++)
                        Expanded(
                          child: cells[row * 7 + col] ?? const SizedBox(),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.active,
    required this.isToday,
  });

  final int day;
  final bool active;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final Color textColor = active || isToday
        ? AppColors.paperWhite
        : AppColors.pathLockedText;

    return Center(
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active
              ? AppColors.streakOrange
              : isToday
              ? AppColors.darkSurfaceAlt
              : null,
          borderRadius: BorderRadius.circular(AppRadius.standard),
        ),
        child: Text('$day', style: AppTypography.subheading(color: textColor)),
      ),
    );
  }
}
