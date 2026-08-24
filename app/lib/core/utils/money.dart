/// Money is stored everywhere as integer paise (1/100 rupee) to keep
/// accounting arithmetic exact — no floating point in ledger math.
extension PaiseFormatting on int {
  /// Formats paise as an Indian-grouped rupee string, e.g. 24850000 -> "2,48,500".
  /// Negative values keep the sign in front of the grouped digits.
  String toIndianRupees({bool withSymbol = false}) {
    final negative = this < 0;
    final rupees = (abs() / 100).round();
    final s = rupees.toString();
    final grouped = _indianGroup(s);
    final sign = negative ? '-' : '';
    return withSymbol ? '$sign₹$grouped' : '$sign$grouped';
  }

  int get toRupees => (this / 100).round();
}

String _indianGroup(String digits) {
  if (digits.length <= 3) return digits;
  final last3 = digits.substring(digits.length - 3);
  var rest = digits.substring(0, digits.length - 3);
  final groups = <String>[];
  while (rest.length > 2) {
    groups.insert(0, rest.substring(rest.length - 2));
    rest = rest.substring(0, rest.length - 2);
  }
  if (rest.isNotEmpty) groups.insert(0, rest);
  return '${groups.join(',')},$last3';
}

int rupeesToPaise(num rupees) => (rupees * 100).round();
