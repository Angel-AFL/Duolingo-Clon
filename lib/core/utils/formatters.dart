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
