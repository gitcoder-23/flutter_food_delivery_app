import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  var getLatitude;
  var getLongitude;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();
  var currentLocation = LocationData;
  var location = Location();
  var currentPosition;
  Future _getLocation() async {
    try {
      location.onLocationChanged.listen((LocationData currentLocation) {
        print('Latitude:${currentLocation.latitude}');
        print('Longitude:${currentLocation.longitude}');
        setState(() {
          getLatitude = currentLocation.latitude;
          getLongitude = currentLocation.longitude;
        });

        LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    } catch (e) {
      print('ERROR:$e');
    }
  }

  // static final CameraPosition _currentPosition = CameraPosition(
  //   target: LatLng(currentPosition.latitude, currentPosition.longitude),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    // CheckoutProvider checkoutProvider = Provider.of(context);

    print('getLongitude: ---> $getLatitude, $getLongitude');
    // const initialcameraposition = LatLng(20.5937, 78.9629);
    // if (getLatitude && getLongitude) {
    //   var initialcameraposition = LatLng(getLatitude, getLongitude);
    // }

    GoogleMapController? controller;
    final Location location = Location();
    void _onMapCreated(GoogleMapController value) {
      controller = value;
      location.onLocationChanged.listen(
        (event) async {
          print('Event--> $event');
          await controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(event.latitude!, event.longitude!), zoom: 15),
            ),
          );
        },
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(getLatitude, getLongitude),
                ),
                mapType: MapType.normal,
                onMapCreated: (onMapCreated) {},
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      // await _location.getLocation().then((value) {
                      //   setState(() {
                      //     checkoutProvider.setLoaction = value;
                      //   });
                      // });
                      // Navigator.of(context).pop();
                    },
                    color: primaryColor,
                    shape: const StadiumBorder(),
                    child: const Text("Set Location"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
