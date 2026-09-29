/// Formatea un entero con separador de miles (ej. 11696 -> "11,696").
String formatThousands(int value) {
  final String digits = value.abs().toString();
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  return value < 0 ? '-$buffer' : buffer.toString();
}

const List<String> _monthsEs = <String>[
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

/// Nombre del mes en espanol (minusculas), ej. "septiembre".
String monthNameEs(DateTime date) => _monthsEs[date.month - 1];

/// Dias restantes hasta el final del mes de [date] (incluye el dia actual).
int daysLeftInMonth(DateTime date) {
  final DateTime lastDay = DateTime(date.year, date.month + 1, 0);
  return lastDay.day - date.day + 1;
}
