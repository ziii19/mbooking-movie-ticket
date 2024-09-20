import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/constants/discount.dart';
import 'package:mbooking/core/constants/movie_booking_properti.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/core/utils/convert_to_idr.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:mbooking/features/movie/presentation/widgets/movie_card_item.dart';
import 'package:mbooking/features/transaction/presentation/pages/midtrans/midtrans_payment.dart';

import '../../widgets/trx_info.dart';

part 'section/movie_section.dart';
part 'section/trx_detail_section.dart';
part 'section/payment_method_section.dart';

class TransactionDetail extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const TransactionDetail(),
      );
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackNav(
                text: 'Detail Transaction',
                onTap: () {
                  context.read<BookingCubit>().updateState(
                        disc: 0,
                        id: '',
                      );
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
              const _MovieSection(),
              const SizedBox(height: 24),
              const _TrxDetailSection(),
              const SizedBox(height: 24),
              // _PaymentMethod(),
              // SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MidtransPaymentPage.route(
                      state.trxId!,
                      state.total,
                    ));
              },
              child: const Text('Buy ticket'),
            ),
          );
        },
      ),
    );
  }
}
