import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/service_token.dart';
import 'package:mbooking/core/constants/transaction_status.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/features/main/pages/main_page.dart';
import 'package:mbooking/features/transaction/domain/transaction.dart';
import 'package:mbooking/features/transaction/presentation/pages/payment_result/payment_false.dart';
import 'package:mbooking/features/transaction/presentation/pages/payment_result/payment_success.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';

import '../../blocs/transaction/transaction_bloc.dart';

class MidtransPaymentPage extends StatefulWidget {
  static route(String orderId, int grossAmount) => MaterialPageRoute(
        builder: (context) => MidtransPaymentPage(
          orderId: orderId,
          grossAmount: grossAmount,
        ),
      );
  final String orderId;
  final int grossAmount;
  const MidtransPaymentPage(
      {super.key, required this.orderId, required this.grossAmount});

  @override
  State<MidtransPaymentPage> createState() => _MidtransPaymentPageState();
}

class _MidtransPaymentPageState extends State<MidtransPaymentPage> {
  late final WebViewController _controller;
  String? snapToken;
  Transaction? _transaction;

  @override
  void initState() {
    super.initState();
    _getSnapToken();
  }

  Future<void> _getSnapToken() async {
    final token = await getSnapToken(widget.orderId, widget.grossAmount);
    if (token != null) {
      setState(() {
        snapToken = token;
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {},
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                if (url.contains('success') ||
                    url.contains('123456') ||
                    url.contains('654321')) {
                  _handlePaymentSuccess();
                } else if (url.contains('failure')) {
                  _handlePaymentFailure();
                } else if (url.contains('cancel') || url.contains('pending')) {
                  _handlePaymentFailure();
                }
              },
              onWebResourceError: (WebResourceError error) {
                _handlePaymentFailure();
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith(
                    'https://app.sandbox.midtrans.com/snap/v2/vtweb/')) {
                  return NavigationDecision.navigate;
                } else if (request.url
                    .contains('payment_status?transaction_status=success')) {
                  _handlePaymentSuccess();
                  return NavigationDecision.prevent;
                } else if (request.url.contains(
                        'payment_status?transaction_status=failure') ||
                    request.url
                        .contains('payment_status?transaction_status=cancel')) {
                  _handlePaymentFailure();
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(
              'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken'));
      });
    } else {
      showMessage('Failed to retrieve Snap token');
    }
  }

  void showMessage(String message) {
    showSnackBar(context, message);
  }

  void backWarning() async {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionSuccess) {
          _transaction = state.transaction;
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Warning',
                  desc: 'Are you sure you want to go back?',
                  btnCancelOnPress: () {
                    Navigator.pop(context);
                  },
                  btnOkOnPress: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MainPage.route(),
                      (route) => false,
                    );
                  },
                ).show();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Payment'),
          ),
          body: snapToken == null
              ? const Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: _controller),
        );
      },
    );
  }

  void _handlePaymentSuccess() {
    context.read<TransactionBloc>().add(
          BlocUpdateTransaction(
            _transaction!.toModel().copyWith(
                  status: TransactionStatus.success.statusName,
                ),
          ),
        );

    Navigator.of(context)
        .pushAndRemoveUntil(PaymentSuccessPage.route(), (route) => false);
  }

  void _handlePaymentFailure() {
    context.read<TransactionBloc>().add(
          BlocUpdateTransaction(
            _transaction!.toModel().copyWith(
                  status: TransactionStatus.failed.statusName,
                ),
          ),
        );

    Navigator.of(context)
        .pushAndRemoveUntil(PaymentFalse.route(), (route) => false);
  }

  Future<String?> getSnapToken(String orderId, int grossAmount) async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        'https://app.sandbox.midtrans.com/snap/v1/transactions',
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ServiceToken.midtransToken}:'))}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "transaction_details": {
            "order_id": orderId,
            "gross_amount": grossAmount,
          },
          "credit_card": {
            "secure": true,
          },
        },
      );

      if (response.statusCode == 201) {
        return response.data['token'];
      } else {
        showMsg('Failed to get token: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      showMsg('Error: $e');
      return null;
    }
  }

  void showMsg(String msg) {
    showSnackBar(context, msg);
  }
}
