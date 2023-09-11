import 'package:intl/intl.dart';

formattedDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  return formattedDate;
}

formattedCurency(String currency) {
  NumberFormat idrFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  String formattedAmount = idrFormat.format(int.parse(currency));
  return formattedAmount;
}
