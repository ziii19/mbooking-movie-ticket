import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/main/pages/main_page.dart';

import '../../../../booking/presentation/cubit/booking_cubit.dart';

class PaymentSuccessPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PaymentSuccessPage(),
      );
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Payment Success',
        desc: 'Thank you for your purchase!',
        btnOkOnPress: () {
          context.read<BookingCubit>().resetState();
          context.read<NavIndexCubit>().setIndex(1);
          Navigator.pushAndRemoveUntil(
            context,
            MainPage.route(),
            (route) => false,
          );
        },
      ).show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
