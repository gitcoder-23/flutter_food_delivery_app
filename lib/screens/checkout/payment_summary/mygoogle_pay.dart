import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final total;
  const MyGooglePay({this.total, super.key});

  @override
  State<MyGooglePay> createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  @override
  Widget build(BuildContext context) {
    print("@@@Total---> ${widget.total}");

    final paymentItems = [
      PaymentItem(
        label: 'Total',
        // amount: '99.99',
        amount: '${widget.total}',
        status: PaymentItemStatus.final_price,
      )
    ];

    // In your Stateless Widget class or State
    void onGooglePayResult(paymentResult) {
      // Send the resulting Google Pay token to your server or PSP
      print("paymentResult@@@-> $paymentResult");
    }

    final Future<PaymentConfiguration> googlePayConfigFuture =
        PaymentConfiguration.fromAsset('sample_payment_configuration.json');

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<PaymentConfiguration>(
            future: googlePayConfigFuture,
            builder: (context, snapshot) => snapshot.hasData
                ? GooglePayButton(
                    paymentConfiguration: snapshot.data!,
                    paymentItems: paymentItems,
                    type: GooglePayButtonType.buy,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: onGooglePayResult,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
