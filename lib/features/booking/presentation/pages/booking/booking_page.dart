import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_booking_properti.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/core/utils/convert_to_idr.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:mbooking/features/booking/presentation/widgets/pick_time_item.dart';
import 'package:mbooking/features/transaction/presentation/pages/detail/transaction_detail.dart';

import '../../../../../core/constants/seat_status.dart';
import '../../widgets/pick_date_item.dart';
import '../../widgets/trapezoid_shape.dart';

part 'section/select_date_time_section.dart';
part 'section/legend_section.dart';
part 'section/pick_seat_section.dart';

class BookingPage extends StatefulWidget {
  static route(int movieId) => MaterialPageRoute(
        builder: (context) => BookingPage(
          movieId: movieId,
        ),
      );
  const BookingPage({super.key, required this.movieId});

  final int movieId;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Stream<List<String>> getSeatReservedRealtime(int movieId) {
    return _firebaseFirestore
        .collection('transactions')
        .where('movieId', isEqualTo: movieId)
        .where('status', isEqualTo: 'Success')
        .snapshots()
        .map((snapshot) {
      List<String> reservedSeats = [];
      for (var doc in snapshot.docs) {
        List<dynamic> seats = doc.data()['seats']; 

        reservedSeats.addAll(List<String>.from(
            seats));
      }
      return reservedSeats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
              stream: getSeatReservedRealtime(widget.movieId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  context
                      .read<BookingCubit>()
                      .updateReservedSeats(snapshot.data!);
                } else {
                  context.read<BookingCubit>().updateReservedSeats([]);
                }
                return const SizedBox();
              }),
          const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                TrapezoidShape(),
                _PickSeatSection(),
                SizedBox(height: 16),
                _LegendSection(),
                SizedBox(height: 30),
                _SelectDateTimeSection(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: AppColors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
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
            ),
          ),
        ],
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
                      convertToIdr((state.total), 2),
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
                    context.read<BookingCubit>().updateState(
                        trxId:
                            DateTime.now().millisecondsSinceEpoch.toString());

                    Navigator.push(context, TransactionDetail.route());
                  },
                  child: const Text("Continue"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
