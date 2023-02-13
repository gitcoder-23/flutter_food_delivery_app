class DeliveryAddressModel {
  String firstName;
  String lastName;
  String mobile;
  String alternateMobile;
  String society;
  String street;
  String landmark;
  String city;
  String area;
  String pincode;
  String addressType;
  double latitude;
  double longitude;

  DeliveryAddressModel({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.alternateMobile,
    required this.society,
    required this.street,
    required this.landmark,
    required this.city,
    required this.area,
    required this.pincode,
    required this.addressType,
    required this.latitude,
    required this.longitude,
  });
}
