import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/providers/checkout_provider.dart';
import 'package:flutter_food_delivery_app/screens/checkout/custom_google_map/custom_google_map.dart';
import 'package:flutter_food_delivery_app/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({super.key});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myAddressType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    // var addressType = AddressTypes.Home == "";

    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: headerColor,
        centerTitle: true,
        title: Text(
          'Add Delivery Address',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: 160,
        height: 48,
        child: checkoutProvider.isLoading == false
            ? MaterialButton(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                onPressed: () {
                  checkoutProvider.validatorWithAddDeliveryAddress(
                      context, myAddressType);
                },
                child: Text(
                  'Add Address',
                  style: TextStyle(color: textColor),
                ),
              )
            : Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(
              labText: "First Name",
              controller: checkoutProvider.firstName,
              fieldIcon: const Icon(Icons.person_add),
            ),
            CustomTextField(
              labText: "Last Name",
              controller: checkoutProvider.lastName,
              fieldIcon: const Icon(Icons.person_add),
            ),
            CustomTextField(
              labText: "Mobile",
              controller: checkoutProvider.mobile,
              fieldIcon: const Icon(Icons.phone_android),
            ),
            CustomTextField(
              labText: "Alternate Mobile",
              controller: checkoutProvider.alternateMobile,
              fieldIcon: const Icon(Icons.phone_android),
            ),
            CustomTextField(
              labText: "Society",
              controller: checkoutProvider.society,
              fieldIcon: const Icon(Icons.location_history),
            ),
            CustomTextField(
              labText: "Street",
              controller: checkoutProvider.street,
              fieldIcon: const Icon(Icons.streetview),
            ),
            CustomTextField(
              labText: "Landmark",
              controller: checkoutProvider.landmark,
              fieldIcon: const Icon(Icons.landscape),
            ),
            CustomTextField(
              labText: "City",
              controller: checkoutProvider.city,
              fieldIcon: const Icon(Icons.location_city),
            ),
            CustomTextField(
              labText: "Area",
              controller: checkoutProvider.area,
              fieldIcon: const Icon(Icons.location_on),
            ),
            CustomTextField(
              labText: "Pincode",
              controller: checkoutProvider.pincode,
              fieldIcon: const Icon(Icons.pin_drop),
            ),
            InkWell(
              onTap: () {
                // print('Set Location Click');
                // checkoutProvider.setLocation?.latitude == null ||
                //         checkoutProvider.setLocation?.longitude == null
                //     ? Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => CustomGoogleMap(),
                //         ),
                //       )
                //     : Container();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CustomGoogleMap(),
                  ),
                );
              },
              child: SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLocation?.latitude == null ||
                            checkoutProvider.setLocation?.longitude == null
                        ? const Text("Set Location")
                        : const Text("Location added"),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const ListTile(
              title: Text('Address Type*'),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myAddressType,
              title: const Text('Home'),
              secondary: Icon(
                Icons.home,
                color: primaryColor,
              ),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myAddressType = value!;
                });
              },
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myAddressType,
              title: const Text('Work'),
              secondary: Icon(
                Icons.work,
                color: primaryColor,
              ),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myAddressType = value!;
                });
              },
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myAddressType,
              title: const Text('Other'),
              secondary: Icon(
                Icons.other_houses,
                color: primaryColor,
              ),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myAddressType = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
