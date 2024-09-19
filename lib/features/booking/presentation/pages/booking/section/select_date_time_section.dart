part of '../booking_page.dart';

class _SelectDateTimeSection extends StatefulWidget {
  const _SelectDateTimeSection();

  @override
  State<_SelectDateTimeSection> createState() => _SelectDateTimeSectionState();
}

class _SelectDateTimeSectionState extends State<_SelectDateTimeSection> {
  final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  final List<int> hours = List.generate(8, (index) => index + 12);

  int? selectedDate;
  int? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Select Date & Time",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 20),
        PickDateItem(
          selectedIndex: selectedDate,
          dates: dates,
          onItemTapped: (i) {
            setState(() {
              selectedDate = i;
            });
          },
        ),
        const SizedBox(height: 20),
        PickTimeItem(
          times: hours,
          selectedIndex: selectedTime,
          onItemTapped: (i) {
            setState(() {
              selectedTime = i;
            });
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
