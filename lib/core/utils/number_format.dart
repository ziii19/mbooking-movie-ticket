import 'package:intl/intl.dart';

String numFormat(String number) {
  final num = int.parse(number);

  return NumberFormat('#,###').format(num); 
}