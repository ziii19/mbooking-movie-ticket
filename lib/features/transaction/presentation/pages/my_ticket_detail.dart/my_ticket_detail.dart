import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/convert_to_idr.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/transaction/domain/transaction.dart';
import 'package:mbooking/features/transaction/presentation/widgets/movie_detail_item.dart';

part 'section/booking_card_info.dart';
part 'section/detail_trx_info.dart';
part 'section/dashed_line_section.dart';
part 'section/movie_info_section.dart';
part 'section/barcode_section.dart';

class MyTicketDetail extends StatelessWidget {
  static route(Transaction transaction) => MaterialPageRoute(
        builder: (context) => MyTicketDetail(
          transaction: transaction,
        ),
      );
  const MyTicketDetail({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BackNav(
              text: 'My ticket',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0)
                            .copyWith(top: 16),
                        child: Column(
                          children: [
                            _MovieInfoSection(
                              movieImage: transaction.movieImage,
                              movieTitle: transaction.movieTitle,
                              movieRuntime: 200,
                              movieGenres: transaction.movieGenres,
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: _BookingCardInfo(
                                    icon: AssetsSvg.calendar,
                                    textUp: timeHHhMM(transaction.wathcingTime),
                                    textDown:
                                        timeDDMMYYY(transaction.wathcingDate),
                                  ),
                                ),
                                Expanded(
                                  child: _BookingCardInfo(
                                    icon: AssetsSvg.seat,
                                    textUp: 'Section',
                                    textDown:
                                        'Seat ${transaction.seats.join(', ')}',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            const Divider(
                              height: 1,
                              color: AppColors.gray,
                            ),
                            const SizedBox(height: 20),
                            _DetailTrxInfo(
                              cinema: transaction.cinema,
                              location: 'transaction.',
                              price: transaction.price,
                            ),
                          ],
                        ),
                      ),
                      const _DashedLine(),
                      _BarCodeSection(
                        trxId: transaction.trxId,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
