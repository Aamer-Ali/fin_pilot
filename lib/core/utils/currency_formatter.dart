/// Formats a whole-currency amount with thousands separators, e.g.
/// 14220.0 -> "14,220". No decimals — matches the app's amount display
/// convention (see `dataMono` in CLAUDE.md §2.3).
String formatCurrency(double amount) {
  final isNegative = amount < 0;
  final wholePart = amount.abs().truncate().toString();

  final buffer = StringBuffer();
  for (var i = 0; i < wholePart.length; i++) {
    if (i != 0 && (wholePart.length - i) % 3 == 0) buffer.write(',');
    buffer.write(wholePart[i]);
  }

  return '${isNegative ? '-' : ''}$buffer';
}