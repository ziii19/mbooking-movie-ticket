import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_booking_properti.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/core/utils/convert_to_idr.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:mbooking/features/booking/presentation/widgets/pick_time_item.dart';
import 'package:mbooking/features/transaction/presentation/pages/midtrans/midtrans_payment.dart';

import '../../../../../core/constants/seat_status.dart';
import '../../../../transaction/presentation/pages/payment/payment_page.dart';
import '../../widgets/pick_date_item.dart';
import '../../widgets/trapezoid_shape.dart';

part 'section/select_date_time_section.dart';
part 'section/legend_section.dart';
part 'section/pick_seat_section.dart';

class BookingPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BookingPage(),
      );
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BackNav(
                text: 'Select seat',
                onTap: () {
                  context.read<BookingCubit>().updateState(
                    seats: [],
                    wathcingDate: -1,
                    wathcingTime: -1,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 16),
            const TrapezoidShape(),
            const _PickSeatSection(),
            const SizedBox(height: 16),
            const _LegendSection(),
            const SizedBox(height: 30),
            const _SelectDateTimeSection(),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.enabled),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      convertToIdr(
                          (state.price! * (state.seats?.length ?? 0)), 2),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.yellow,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(191, 56),
                  ),
                  onPressed: () {
                    if (state.seats!.isEmpty) {
                      showSnackBar(context, 'Please select seat');
                      return;
                    } else if (state.wathcingDate == null ||
                        state.wathcingTime == -1) {
                      showSnackBar(context, 'Please select date');
                      return;
                    } else if (state.wathcingTime == null ||
                        state.wathcingTime == -1) {
                      showSnackBar(context, 'Please select time');
                      return;
                    }

                    Navigator.push(
                        context,
                        MidtransPaymentPage.route(
                            DateTime.now().millisecondsSinceEpoch.toString(),
                            state.price! * (state.seats!.length)));
                  },
                  child: const Text("Buy Ticket"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
