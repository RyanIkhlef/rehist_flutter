import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'navigation/nav_drawer.dart';
import 'navigation/nav_bar.dart';
import 'package:rehist/services/event_service.dart';
import 'package:rehist/services/association_service.dart';

class MapsAssociationsPage extends StatelessWidget {
  MapsAssociationsPage({Key? key}) : super(key: key);

  static const String routeName = '/mapsAssociations';

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(48.84861, 2.36652);
  static const LatLng showLocation = const LatLng(48.84861, 2.36652);

  MapType _currentMapType = MapType.normal;
  Set<Marker> markers = new Set<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Associations'),
              backgroundColor: Colors.green[700],
            ),
            body: Center(
                child: FutureBuilder(
                    future: AssociationService.getAssociations(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Set<Marker> markers = new Set<Marker>();
                      for (var data in snapshot.data) {
                        markers.add(Marker( //add second marker
                          markerId: MarkerId(showLocation.toString()),
                          position: LatLng(data['long'], data['lat']),
                          //position of marker
                          infoWindow: InfoWindow(title: data['title'],
                              snippet: data['description']),
                          icon: BitmapDescriptor.defaultMarker,
                        ));
                      }
                      return GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 5.0,),
                          mapType: _currentMapType,
                          markers: markers
                      );
                    }
                )
            )
        )
    );
  }
}