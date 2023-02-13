// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/delivery_address_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

import '../screens/checkout/add_delivery_address/add_delivery_address.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController alternateMobile = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  // TextEditingController setLocation = TextEditingController();
  LocationData? setLocation;

  // BuildContext? context;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstName.dispose();
    lastName.dispose();
    mobile.dispose();
    alternateMobile.dispose();
    society.dispose();
    street.dispose();
    landmark.dispose();
    city.dispose();
    area.dispose();
    pincode.dispose();
    super.dispose();
  }

  clearTextField() {
    firstName.clear();
    lastName.clear();
    mobile.clear();
    alternateMobile.clear();
    society.clear();
    street.clear();
    landmark.clear();
    city.clear();
    area.clear();
    pincode.clear();
  }

// Add Delivery Address
  void validatorWithAddDeliveryAddress(context, myAddressType) async {
    print("@@@@setLocation--> $setLocation");
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "First name required");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Last name required");
    } else if (mobile.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mobile number required");
    } else if (alternateMobile.text.isEmpty) {
      Fluttertoast.showToast(msg: "Alternate mobile number required");
    } else if (society.text.isEmpty) {
      Fluttertoast.showToast(msg: "Society required");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street name required");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "Landmark required");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "City required");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area required");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "Pincode required");
    } else if (setLocation == null ||
        setLocation?.latitude == null ||
        setLocation?.longitude == null) {
      Fluttertoast.showToast(msg: "You need to set location");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("deliveryAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": firstName.text,
        "lastName": lastName.text,
        "mobile": mobile.text,
        "alternateMobile": alternateMobile.text,
        "society": society.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "area": area.text,
        "pincode": pincode.text,
        // "setLocation": setLocation,
        // For location
        "latitude": setLocation?.latitude,
        "longitude": setLocation?.longitude,
        //  "addressType": myAddressType.toString(),
        "addressType": myAddressType == AddressTypes.Home
            ? 'Home'
            : myAddressType == AddressTypes.Work
                ? 'Work'
                : 'Other',
      }).then((value) {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Delivery address added success");

        // back to previous screen from where the screen coming
        Navigator.of(context).pop();
        notifyListeners();
        clearTextField();
      }).catchError(
        (onError) {
          print("Address add failed @@@->> $onError");
          isLoading = false;
          notifyListeners();
        },
      );
      notifyListeners();
    }
  }

// Get Delivery Address
  List<DeliveryAddressModel> deliveryAddressList = [];
  void fetchDeliveryAddress() async {
    List<DeliveryAddressModel> newDeliveryList = [];

    // notifyListeners();
    DocumentSnapshot deliveryAddressData = await FirebaseFirestore.instance
        .collection("deliveryAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (deliveryAddressData.exists) {
      // notifyListeners();
      DeliveryAddressModel deliveryAddressList = DeliveryAddressModel(
        firstName: deliveryAddressData.get('firstName'),
        lastName: deliveryAddressData.get('lastName'),
        mobile: deliveryAddressData.get('mobile'),
        alternateMobile: deliveryAddressData.get('alternateMobile'),
        society: deliveryAddressData.get('society'),
        street: deliveryAddressData.get('street'),
        landmark: deliveryAddressData.get('landmark'),
        city: deliveryAddressData.get('city'),
        area: deliveryAddressData.get('area'),
        pincode: deliveryAddressData.get('pincode'),
        addressType: deliveryAddressData.get('addressType'),
        latitude: deliveryAddressData.get('latitude'),
        longitude: deliveryAddressData.get('longitude'),
      );
      newDeliveryList.add(deliveryAddressList);
      notifyListeners();
    }
    deliveryAddressList = newDeliveryList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }
}
