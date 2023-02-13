// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapOld extends StatefulWidget {
  const CustomGoogleMapOld({super.key});

  @override
  State<CustomGoogleMapOld> createState() => _CustomGoogleMapOldState();
}

class _CustomGoogleMapOldState extends State<CustomGoogleMapOld> {
  // latitude, longitude
  late LatLng initialCameraPosition = const LatLng(20.5937, 78.9629);

  late GoogleMapController controller;

  final Location _location = Location();
  @override
  void initState() {
    print('mounted-- $mounted');
    if (mounted) {
      LatLng initialCameraPosition = const LatLng(20.5937, 78.9629);
    }

    super.initState();
  }

  // Set Current Location From Map
  void onMapCreated(GoogleMapController _mapController) {
    controller = _mapController;
    // If map Camera turn to and fro then location catch
    _location.onLocationChanged.listen((event) {
      print("event---> $event");
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.latitude!, event.longitude!),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // "CameraPosition" -- depend on place or country specific
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialCameraPosition,
              ),
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              onMapCreated: onMapCreated,
              // onMapCreated: (mapEnable) {
              //   print('mapEnable--- ${mapEnable.mapId}');

              // },
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
                  onPressed: () {
                    print('Click');
                  },
                  color: primaryColor,
                  shape: const StadiumBorder(),
                  child: const Text('Set Location'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
