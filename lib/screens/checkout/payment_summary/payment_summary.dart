import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:flutter_food_delivery_app/screens/checkout/delivery_details/single_delivery_item.dart';
import 'package:flutter_food_delivery_app/screens/checkout/payment_summary/mygoogle_pay.dart';
import 'package:flutter_food_delivery_app/screens/checkout/payment_summary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final deliveryAddressListData;
  const PaymentSummary({this.deliveryAddressListData, super.key});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum PaymentType {
  Home,
  Online_Payment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myPaymentType = PaymentType.Home;

  @override
  void initState() {
    getCartProducts();
    super.initState();
  }

  getCartProducts() async {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);

    if (mounted) {
      reviewCartProvider.getReviewCartData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getCartProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    reviewCartProvider.getReviewCartData();

    // print("deliveryAddressListData--> ${widget.deliveryAddressListData}");
// Discount Operation
    double discount = 30;
    double? discountValue;
    double shippingCharge = 3.7;
    double? total;
    double totalPrice = reviewCartProvider.getTotalPriceInCart();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    // print('total ---> $total, $totalPrice, $discountValue');

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: headerColor,
        centerTitle: true,
        title: Text(
          'Payment Summary',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: const Text('Total Amount'),
        subtitle: Text(
          "\$${total != null ? (total + 5) + (shippingCharge * 10) : totalPrice + (shippingCharge * 10)}",
          // "\$${total != null ? total + 5 : totalPrice}",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myPaymentType == PaymentType.Online_Payment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyGooglePay(
                            total: total != null
                                ? (total + 5) + (shippingCharge * 10)
                                : totalPrice + (shippingCharge * 10)),
                      ),
                    )
                  : Container();
            },
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Place Order',
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                // const ListTile(
                //   title: Text('First & Last Name'),
                //   subtitle: Text("Address"),
                // ),

                SingleDeliveryItem(
                  address:
                      "area: ${widget.deliveryAddressListData.area}, street: ${widget.deliveryAddressListData.street}, society: ${widget.deliveryAddressListData.society}, pincode: ${widget.deliveryAddressListData.pincode}",
                  title:
                      "${widget.deliveryAddressListData.firstName} ${widget.deliveryAddressListData.lastName}",
                  number: "mobile: ${widget.deliveryAddressListData.mobile}",
                  addressType: widget.deliveryAddressListData.addressType,
                ),

                const Divider(),
                ExpansionTile(
                  title: Text(
                    'Order Item ${reviewCartProvider.getReviewCartDataList.length}',
                  ),
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(e: e);
                  }).toList(),
                ),
                const Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: const Text(
                    'Sub Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$$totalPrice',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    'Shiping Charge',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[400],
                    ),
                  ),
                  trailing: Text(
                    '\$${shippingCharge * 10}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[400],
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    'Discount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[400],
                    ),
                  ),
                  trailing: Text(
                    discountValue == null ? 'No discount' : '\$$discountValue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[400],
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Text(
                    'Payment Option',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[400],
                    ),
                  ),
                ),
                RadioListTile(
                  value: PaymentType.Home,
                  groupValue: myPaymentType,
                  title: const Text('Home (COD)'),
                  secondary: Icon(
                    Icons.home,
                    color: primaryColor,
                  ),
                  onChanged: (PaymentType? value) {
                    setState(() {
                      myPaymentType = value!;
                    });
                  },
                ),
                RadioListTile(
                  value: PaymentType.Online_Payment,
                  groupValue: myPaymentType,
                  title: const Text('Online Payment Method'),
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                  onChanged: (PaymentType? value) {
                    setState(() {
                      myPaymentType = value!;
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
