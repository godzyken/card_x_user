import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddressTarget extends StatefulWidget {

  @override
  _AddressTargetState createState() => _AddressTargetState();
}

final parisGeoPoint = GeoPoint(48.856613, 2.352222);

class _AddressTargetState extends State<AddressTarget> {
  late AppleMapController mapController;
  late String query;

  GeoPoint? geoPoint = parisGeoPoint;
  double zoom = 11.0;
  double _width = 500.0;
  double _height = 300.0;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: AppleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                  ),
                  mapType: MapType.standard,
                  compassEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: _onMapCreated,
                  zoomGesturesEnabled: true,
                  pitchGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationEnabled: true,
                  trafficEnabled: true,
                )
            )
          ],
        ),
      )
    );
  }
}