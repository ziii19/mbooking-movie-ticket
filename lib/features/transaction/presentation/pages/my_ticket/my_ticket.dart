import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/features/auth/presentation/blocs/user/user_bloc.dart';
import 'package:mbooking/features/transaction/presentation/blocs/transaction/transaction_bloc.dart';

import '../../widgets/my_ticket_card.dart';
import '../my_ticket_detail.dart/my_ticket_detail.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({super.key});

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  @override
  void initState() {
    super.initState();
    getTransactions();
  }

  getTransactions() {
    final user = context.read<UserBloc>().state as UserSuccess;
    context.read<TransactionBloc>().add(GetTransaction(user.user.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SafeArea(
            child: Center(
              child: Text(
                'My Ticket',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is TransactionFailed) {
                  showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is GetTransactionSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      getTransactions();
                    },
                    child: state.transactions.isEmpty
                        ? const Center(
                            child: Text(
                              'No Transaction',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final transaction = state.transactions[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MyTicketDetail.route(transaction),
                                  );
                                },
                                child: MyTicketCard(
                                  movieImage: transaction.movieImage,
                                  movieName: transaction.movieTitle,
                                  watchingTimes:
                                      '${timeHHhMM(transaction.wathcingTime)} • ${timeDDMMYYY(transaction.wathcingDate)}',
                                  cinema: transaction.cinema,
                                  trxStatus: transaction.status,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemCount: state.transactions.length,
                          ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
