import 'package:intl/intl.dart';

String timeDDMMYYY(String date) {
  DateTime releaseDate = DateTime.parse(date);

  String formattedDate = DateFormat('dd.MM.yyyy').format(releaseDate);

  return formattedDate;
}

String timeHHMM(int time) {
  int hours = time ~/ 60;
  int minutes = time % 60;

  return '${hours}h${minutes}m';
}
