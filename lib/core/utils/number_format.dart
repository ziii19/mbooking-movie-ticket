import 'package:intl/intl.dart';

String numFormat(int number) {
  return NumberFormat('#,###').format(number);
}
