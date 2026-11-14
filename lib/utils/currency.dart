/// Formats an amount in Taka, e.g. 3150.0 -> "৳3,150", 2700.5 -> "৳2,700.50".
String formatTaka(double amount) {
  final isWhole = amount == amount.roundToDouble();
  final fixed = amount.toStringAsFixed(isWhole ? 0 : 2);
  final parts = fixed.split('.');
  final withCommas = parts[0].replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+$)'),
    (match) => '${match[1]},',
  );
  return '৳$withCommas${parts.length > 1 ? '.${parts[1]}' : ''}';
}
