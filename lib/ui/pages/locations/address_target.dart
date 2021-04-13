import 'package:card_x_user/core/helpers/helpers.dart' as helpers;
import 'package:flutter/material.dart';
import 'package:maps/maps.dart';
import 'package:maps_adapter_google_maps/maps_adapter_google_maps.dart';


class AddressTarget extends StatefulWidget {

  @override
  _AddressTargetState createState() => _AddressTargetState();
}

final parisGeoPoint = GeoPoint(48.856613, 2.352222);

class _AddressTargetState extends State<AddressTarget> {

  // Construct a map widget
  static const defaultMapAdapter = MapAdapter.platformSpecific(
    ios: appleMapsNative,
    otherwise: bingMapsIframe,
  );
  static const AppleMapsJsAdapter? appleMapsJs = null;
  static const AppleMapsNativeAdapter appleMapsNative =
  AppleMapsNativeAdapter();
  static const AppleMapsStaticAdapter? appleMapsStatic = null;
  static const bingMapsIframe = BingMapsIframeAdapter();
  static const bingMapsJs = BingMapsJsAdapter(apiKey: helpers.Map_API_KEY);
  static const bingMapsStatic = BingMapsStaticAdapter(apiKey: helpers.Map_API_KEY);
  static const googleMapsIframe = GoogleMapsIframeAdapter(apiKey: helpers.Map_API_KEY);
  static const googleMapsJs = GoogleMapsJsAdapter(apiKey: helpers.Map_API_KEY);
  static const googleMapsNative = GoogleMapsNativeAdapter();
  static const googleMapsStatic = GoogleMapsStaticAdapter(apiKey: helpers.Map_API_KEY);
  var _tab = 0;
  MapAdapter? selectedAdapter = defaultMapAdapter;

  late String query;

  GeoPoint? geoPoint = parisGeoPoint;

  double zoom = 11.0;

  // Paris
  final _key = GlobalKey();

  double _width = 500.0;

  double _height = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: buildTab(context, _tab),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.launch),
              label: 'MapLauncher',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'MapWidget',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (i) {
            setState(() {
              _tab = i;
            });
          },
        ),
    );
  }

  Widget buildMapLauncherDemo(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        MaterialButton(
          child: Text('Apple Maps'),
          onPressed: () {
            const AppleMapsLauncher().launch(
              query: query,
              geoPoint: geoPoint!,
            );
          },
        ),
        MaterialButton(
          child: Text('Bing Maps'),
          onPressed: () {
            const BingMapsApp().launch(
              query: query,
              geoPoint: geoPoint!,
            );
          },
        ),
        MaterialButton(
          child: Text('Google Maps'),
          onPressed: () {
            const GoogleMapsLauncher().launch(
              query: query,
              geoPoint: geoPoint!,
            );
          },
        ),
      ],
    );
  }

  Widget buildMapWidgetDemo(BuildContext context) {
    final radioButtonRows = <Row>[];
    void f(String name, MapAdapter? value) {
      if (value == null) {
        return;
      }
      radioButtonRows.add(Row(
        children: [
          Radio<MapAdapter>(
            value: value,
            groupValue: selectedAdapter,
            onChanged: (newValue) {
              setState(() {
                selectedAdapter = newValue;
              });
            },
          ),
          Text(
            name,
          ),
        ],
      ));
    }

    f('Platform specific', defaultMapAdapter);
    f('Apple Maps (js)', appleMapsJs);
    f('Apple Maps (native)', appleMapsNative);
    f('Apple Maps (static)', appleMapsStatic);
    f('Bing Maps (iframe)', bingMapsIframe);
    f('Bing Maps (js)', bingMapsJs);
    f('Bing Maps (static)', bingMapsStatic);
    f('Google Maps (iframe)', googleMapsIframe);
    f('Google Maps (js)', googleMapsJs);
    f('Google Maps (native)', googleMapsNative);
    f('Google Maps (static)', googleMapsStatic);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Center(
          child: SizedBox(
            width: _width,
            height: _height,
            child: MapWidget(
              key: _key,
              adapter: selectedAdapter!,
              location: MapLocation(
                query: query,
                geoPoint: geoPoint!,
                zoom: Zoom(zoom),
              ),
              markers: {
                MapMarker(
                  geoPoint: GeoPoint(48.8606, 2.3376),
                  details: MapMarkerDetails(
                    title: 'Louvre',
                    snippet: 'A popular museum.',
                  ),
                ),
                MapMarker(
                  geoPoint: GeoPoint(48.8539, 2.2913),
                  details: MapMarkerDetails(
                    title: 'Eiffel Tower',
                    snippet: 'An iconic tower.',
                  ),
                ),
              },
            ),
          ),
        ),
        Text(
          'Choose adapter:',
          textScaleFactor: 1.5,
          textAlign: TextAlign.left,
        ),
        ...radioButtonRows,
        Text('Width (${_width.toInt()} px)'),
        Slider(
          min: 100,
          max: 1000,
          value: _width.toDouble(),
          onChanged: (newValue) {
            setState(() {
              _width = newValue;
            });
          },
        ),
        Text('Height (${_height.toInt()} px)'),
        Slider(
          min: 100,
          max: 1000,
          value: _height.toDouble(),
          onChanged: (newValue) {
            setState(() {
              _height = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget buildSettings(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        MaterialButton(
          child: Text('No geopoint'),
          onPressed: () {
            setState(() {
              geoPoint = null;
            });
          },
        ),
        MaterialButton(
          child: Text('Paris geopoint'),
          onPressed: () {
            setState(() {
              geoPoint = parisGeoPoint;
            });
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Query:'),
            MaterialButton(
              child: Text('None'),
              onPressed: () {
                setState(() {
                  query = '';
                });
              },
            ),
            MaterialButton(
              child: Text('Tokyo'),
              onPressed: () {
                setState(() {
                  query = 'Tokyo';
                });
              },
            ),
            MaterialButton(
              child: Text('New York'),
              onPressed: () {
                setState(() {
                  query = 'New York';
                });
              },
            ),
          ],
        ),
        TextField(
          controller: TextEditingController()..text = query,
          maxLength: 30,
          onChanged: (newValue) {
            query = newValue;
          },
        ),
      ],
    );
  }

  Widget buildTab(BuildContext context, int i) {
    switch (i) {
      case 0:
        return buildMapLauncherDemo(context);
      case 1:
        return buildMapWidgetDemo(context);
      default:
        return buildSettings(context);
    }
  }
}