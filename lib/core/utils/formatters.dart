import 'package:intl/intl.dart';

/// Formatea un entero con separador de miles segun el locale es.
String formatThousands(int value) =>
    NumberFormat.decimalPattern('es').format(value);

/// Nombre del mes en espanol (minusculas), ej. "septiembre".
String monthNameEs(DateTime date) =>
    DateFormat.MMMM('es').format(date).toLowerCase();

/// Indice (1-12) del mes a partir de su nombre en espanol, o 0 si no coincide.
int monthIndexFromName(String monthName) {
  final String normalized = monthName.toLowerCase();
  for (int month = 1; month <= 12; month++) {
    final String candidate = DateFormat.MMMM(
      'es',
    ).format(DateTime(2000, month)).toLowerCase();
    if (candidate == normalized) return month;
  }
  return 0;
}

/// Dias restantes hasta el final del mes de [date] (incluye el dia actual).
int daysLeftInMonth(DateTime date) {
  final DateTime lastDay = DateTime(date.year, date.month + 1, 0);
  return lastDay.day - date.day + 1;
}
