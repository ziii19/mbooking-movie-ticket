part of '../transaction_detail.dart';

class _TrxDetailSection extends StatefulWidget {
  const _TrxDetailSection();

  @override
  State<_TrxDetailSection> createState() => _TrxDetailSectionState();
}

class _TrxDetailSectionState extends State<_TrxDetailSection> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Column(
          children: [
            TrxInfo(
              title: 'Order ID',
              value: state.trxId!,
            ),
            const SizedBox(height: 16),
            TrxInfo(
                title: 'Seat', value: state.seats!.map((e) => e).join(', ')),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextFormField(
                controller: _controller,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                style: const TextStyle(
                  color: AppColors.white,
                ),
                decoration: InputDecoration(
                  fillColor: AppColors.enabled,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SvgPicture.asset(AssetsSvg.discount),
                  ),
                  hintText: 'discount code',
                  contentPadding: const EdgeInsets.only(top: 5),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(119, 40),
                        maximumSize: const Size(119, 40),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: state.discount != 0
                            ? AppColors.gray
                            : AppColors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: state.discount != 0
                        ? () {}
                        : () {
                            final disc = checkDiscount(_controller.text);
                            if (disc != null) {
                              context.read<BookingCubit>().addDiscount(disc);
                            } else {
                              showErrorDialog(
                                  context, 'Discount code not found');
                            }
                          },
                    child: const Text(
                      'Apply',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            TrxInfo(
              title: 'Discount',
              value: convertToIdr(
                state.discount!,
                2,
              ),
            ),
            const SizedBox(height: 10),
            TrxInfo(
              title: 'Total',
              value: convertToIdr(state.total, 2),
              isValueBig: true,
            ),
          ],
        );
      },
    );
  }
}
