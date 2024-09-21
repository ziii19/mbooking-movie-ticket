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

String timeHHSMM(int time) {
  int hours = time ~/ 60;
  int minutes = time % 60;

  return '$hours hour $minutes minutes';
}

String timeHHhMM(String waktu) {
  List<String> parts = waktu.split(":");
  String jam = parts[0];
  String menit = parts[1];

  return "${jam}h$menit’";
}
