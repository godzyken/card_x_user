import 'package:card_x_user/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:maps/maps.dart';

class AddressTarget extends StatefulWidget {

  @override
  _AddressTargetState createState() => _AddressTargetState();
}

class _AddressTargetState extends State<AddressTarget> {

  // Construct a map widget
  static const parisMap = MapWidget(
    location: MapLocation(
      query: 'Paris',
    ),
  );

  Size _size = Size(650, 450);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildMapWidget(parisMap, _size),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildMapWidget(MapWidget mapWidget, Size size) {

    // Base URL
    final sb = StringBuffer();
    sb.write('https://maps.googleapis.com/maps/api/staticmap');

    // Size
    sb.write('?size=');
    sb.write(size.width.toInt());
    sb.write('x');
    sb.write(size.height.toInt());

    // Location
    final location = mapWidget.location;
    final geoPoint = location.geoPoint;
    if (geoPoint != null && geoPoint.isValid) {
      sb.write('&center=');
      sb.write(geoPoint.latitude.toString());
      sb.write(',');
      sb.write(geoPoint.longitude.toString());
    }

    // Zoom
    final zoom = location.zoom;
    if (zoom != null) {
      sb.write('&zoom=');
      sb.write(zoom.value.toInt().clamp(1, 20));
    }

    // API key
    sb.write('&key=');
    sb.write(Uri.encodeQueryComponent(API_KEY));
    final url = sb.toString();

    return Image.network(url, width: size.width, height: size.height);
  }
}
