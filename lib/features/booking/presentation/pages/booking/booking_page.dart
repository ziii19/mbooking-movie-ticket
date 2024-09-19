import 'package:flutter/material.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/booking/presentation/widgets/pick_time_item.dart';

import '../../../../../core/constants/seat_status.dart';
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
  int selectedIndex = 10;
  String selectedTime = "14:15";
  int totalPrice = 210000;

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
                onTap: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 16),
            const TrapezoidShape(),
            _PickSeatSection(),
            const SizedBox(height: 16),
            const _LegendSection(),
            const SizedBox(height: 30),
            const _SelectDateTimeSection(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                  "${totalPrice.toString()} VND",
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
              onPressed: () {},
              child: const Text("Buy Ticket"),
            ),
          ],
        ),
      ),
    );
  }
}
