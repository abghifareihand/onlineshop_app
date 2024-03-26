import 'package:intl/intl.dart';

String priceFormat(dynamic price) {
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );
  return currencyFormat.format(price);
}

extension IntegerExt on int {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'IDR ',
        decimalDigits: 0,
      ).format(this);
}

extension DateTimeExt on DateTime {
  String toFormattedDate() {
    const List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    String day = this.day.toString();
    String month = monthNames[this.month - 1];
    String year = this.year.toString();

    return '$day $month $year';
  }
}
