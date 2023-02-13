import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/delivery_address_model.dart';
import 'package:flutter_food_delivery_app/providers/checkout_provider.dart';
import 'package:flutter_food_delivery_app/screens/checkout/add_delivery_address/add_delivery_address.dart';
import 'package:flutter_food_delivery_app/screens/checkout/delivery_details/single_delivery_item.dart';
import 'package:flutter_food_delivery_app/screens/checkout/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  // bool isAddress = false;

  DeliveryAddressModel? value;

  @override
  void initState() {
    super.initState();
    getDeliveryDetails();
  }

  getDeliveryDetails() async {
    print("$mounted");
    CheckoutProvider checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    if (mounted) {
      checkoutProvider.fetchDeliveryAddress();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getDeliveryDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    DeliveryAddressModel? value;
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: headerColor,
        centerTitle: true,
        title: Text(
          'Delivery Details',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Add Delivery Address',
        mouseCursor: MouseCursor.defer,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddDeliveryAddress(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          onPressed: () {
            checkoutProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddDeliveryAddress(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSummary(
                        deliveryAddressListData: value,
                      ),
                    ),
                  );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          child: checkoutProvider.getDeliveryAddressList.isEmpty
              ? const Text("Add new Address")
              : const Text("Payment Summary"),
        ),

        //  MaterialButton(
        //   onPressed: () {
        //     if (isAddress == true) {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => const AddDeliveryAddress(),
        //         ),
        //       );
        //     } else {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => PaymentSummary(
        //               deliveryAddressListData:
        //                   checkoutProvider.getDeliveryAddressList),
        //         ),
        //       );
        //     }
        //   },
        //   color: primaryColor,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(
        //       30,
        //     ),
        //   ),
        //   child: isAddress == true
        //       ? const Text("Add new address")
        //       : const Text("Payment Summary"),
        // ),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Deliver To"),
            leading: Icon(Icons.location_pin),
          ),
          const Divider(
            height: 1,
          ),
          checkoutProvider.getDeliveryAddressList.isEmpty
              ? Center(
                  child: Container(
                    child: const Center(
                      child: Text("No Delivery Address"),
                    ),
                  ),
                )
              : Column(
                  children:
                      checkoutProvider.getDeliveryAddressList.map<Widget>((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      address:
                          "area: ${e.area}, street: ${e.street}, society: ${e.society}, pincode: ${e.pincode}",
                      title: "${e.firstName} ${e.lastName}",
                      number: "mobile: ${e.mobile}",
                      addressType: e.addressType,
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }
}
