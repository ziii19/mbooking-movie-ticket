part of '../booking_page.dart';

class _SelectDateTimeSection extends StatelessWidget {
  const _SelectDateTimeSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
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
              selectedIndex: state.wathcingDate,
              dates: MovieBookingProperti.dates,
              onItemTapped: (index) {
                context.read<BookingCubit>().updateState(
                      wathcingDate: index,
                    );
              },
            ),
            const SizedBox(height: 20),
            PickTimeItem(
              times: MovieBookingProperti.times,
              selectedIndex: state.wathcingTime,
              onItemTapped: (index) {
                context.read<BookingCubit>().updateState(
                      wathcingTime: index,
                    );
              },
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
