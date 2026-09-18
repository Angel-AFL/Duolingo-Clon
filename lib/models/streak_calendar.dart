/// Calendario mensual de practica de la racha.
class StreakCalendar {
  const StreakCalendar({
    required this.monthName,
    required this.year,
    required this.practiceDays,
    required this.freezesUsed,
    required this.perfectWeeks,
    required this.activeDays,
    required this.today,
  });

  /// Nombre del mes mostrado (ej. "septiembre").
  final String monthName;

  final int year;

  /// Dias practicados en el mes.
  final int practiceDays;

  /// Protectores de racha usados en el mes.
  final int freezesUsed;

  /// Semanas con racha perfecta.
  final int perfectWeeks;

  /// Dias del mes con practica (resaltados en naranja).
  final List<int> activeDays;

  /// Dia actual del mes.
  final int today;

  bool isActive(int day) => activeDays.contains(day);

  factory StreakCalendar.fromJson(Map<String, dynamic> json) {
    return StreakCalendar(
      monthName: json['month_name'] as String,
      year: json['year'] as int,
      practiceDays: json['practice_days'] as int,
      freezesUsed: json['freezes_used'] as int,
      perfectWeeks: json['perfect_weeks'] as int,
      activeDays: (json['active_days'] as List<dynamic>).cast<int>(),
      today: json['today'] as int,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'month_name': monthName,
    'year': year,
    'practice_days': practiceDays,
    'freezes_used': freezesUsed,
    'perfect_weeks': perfectWeeks,
    'active_days': activeDays,
    'today': today,
  };
}
