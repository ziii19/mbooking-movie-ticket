import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/main/pages/main_page.dart';

import '../../../../main/pages/cubit/nav_index_cubit.dart';

class PaymentFalse extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PaymentFalse(),
      );
  const PaymentFalse({super.key});

  @override
  State<PaymentFalse> createState() => _PaymentFalseState();
}

class _PaymentFalseState extends State<PaymentFalse> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Payment Failed',
        desc: 'Please try again later',
        btnOkOnPress: () {
          context.read<NavIndexCubit>().setIndex(1);
          Navigator.pushAndRemoveUntil(
            context,
            MainPage.route(),
            (route) => false,
          );
        },
        btnOkColor: Colors.red,
      ).show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
