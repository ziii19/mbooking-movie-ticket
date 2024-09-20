class MovieBookingProperti {
  static final List<String> seats = List.generate(120, (index) {
    String row = String.fromCharCode(65 + index ~/ 12);
    String column = (index % 12 + 1).toString();
    return '$row$column';
  });

  static final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  static final List<String> times = [
    '10:30',
    '11:45',
    '12:05',
    '13:20',
    '14:30',
    '16:10',
    '18:25',
    '20:00',
    '22:15',
  ];
}
