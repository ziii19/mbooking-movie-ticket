part of '../booking_page.dart';

class _PickSeatSection extends StatefulWidget {
  const _PickSeatSection();

  @override
  State<_PickSeatSection> createState() => _PickSeatSectionState();
}

class _PickSeatSectionState extends State<_PickSeatSection> {
  List<String> seats = List.generate(120, (index) {
    String row = String.fromCharCode(65 + index ~/ 12);
    String column = (index % 12 + 1).toString();
    return '$row$column';
  });

  List<String> selectedSeats = [];
  List<String> reservedSeats = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 10 * 40,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 12,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: seats.length,
        itemBuilder: (context, index) {
          String seat = seats[index];

          return GestureDetector(
            onTap: () {
              onSeatTap(seat);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Seat.seatColor(seatStatusChecker(seat)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  seat,
                  style: TextStyle(
                    color: Seat.textColor(seatStatusChecker(seat)),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onSeatTap(seat) {
    if (!selectedSeats.contains(seat)) {
      setState(() {
        selectedSeats.add(seat);
      });
    } else {
      setState(() {
        selectedSeats.remove(seat);
      });
    }
  }

  SeatStatus seatStatusChecker(seat) => reservedSeats.contains(seat)
      ? SeatStatus.reserved
      : selectedSeats.contains(seat)
          ? SeatStatus.selected
          : SeatStatus.available;
}
