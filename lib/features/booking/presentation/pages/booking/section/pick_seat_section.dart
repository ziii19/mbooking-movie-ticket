part of '../booking_page.dart';

class _PickSeatSection extends StatefulWidget {
  const _PickSeatSection();

  @override
  State<_PickSeatSection> createState() => _PickSeatSectionState();
}

class _PickSeatSectionState extends State<_PickSeatSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 10 * 40,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 12,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: MovieBookingProperti.seats.length,
                itemBuilder: (context, index) {
                  String seat = MovieBookingProperti.seats[index];

                  return GestureDetector(
                    onTap: () {
                      if (state.reservedSeats!.contains(seat)) {
                        showSnackBar(context, 'This seat is reserved');
                        return;
                      }

                      if (state.seats!.contains(seat)) {
                        context.read<BookingCubit>().pickSeat(seat);
                        return;
                      }

                      if (state.seats!.length >= 3) {
                        showSnackBar(
                            context, 'You can not select more than 3 seats');
                        return;
                      }

                      context.read<BookingCubit>().pickSeat(seat);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Seat.seatColor(
                          state.seatStatusChecker(seat),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          seat,
                          style: TextStyle(
                            color: Seat.textColor(
                              state.seatStatusChecker(seat),
                            ),
                            fontWeight: FontWeight.bold,
                            fontSize: width > 400 ? 14 : 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
